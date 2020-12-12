var express = require('express');
const bodyParser = require('body-parser');
const User = require('../models/usersSchema');
const passport = require('passport');
var userRouter = express.Router();
userRouter.use(bodyParser.json());
const cors = require('./cors');
const multer = require('multer');
const authenticate = require('../authenticate');
const upload = require('../upload')


userRouter.options('*' , cors.corsWithOptions , (req,res,next)=>{
  res.sendStatus(200);
});


// Handeling Signup, login, logout using passport, passport-local and passport-local-mongoose



// Configuring SignUp process
userRouter.post('/signup' , cors.corsWithOptions , (req,res,next)=>{

  // register the user needs 3 params, username, password, callback fn
  // notice that username and password aren't explicitly declared in users schema, but they are added by passport-local-mongoose
  User.register(new User({username: req.body.username, firstname: req.body.firstname, lastname: req.body.lastname}), 
  req.body.password , 
  (err, user)=>{

    if(err){
      res.statusCode = 500;
      res.setHeader("Content-Type" , 'application/json');
      res.json({success: false, status: "Process Failed", err: err});
    }
    else{
      if(req.body.email){
        user.email = req.body.email;
      }
      if(req.body.phoneNumber){
        user.phoneNumber = req.body.phoneNumber;
      }

      user.save().then((user)=>{

        // authenticating the registered user to ensure that is registered correctly
        passport.authenticate('local')(req , res , ()=>{  // if an error happened during authentication, it will be handled automatically

          res.statusCode = 200;
          res.setHeader("Content-Type" , 'application/json');
          res.json({success: true , status: "Registeration Successful"});

      });
      }).catch((err)=>{
          res.statusCode = 500;
          res.setHeader("Content-Type" , 'application/json');
          res.json({success: false, status: "Registeration Failed" ,err:err});
          return ;
      });
    }
  });
});




// Configuring login process

// we are expecting the username and the password to be in the body of a post request not in the authorization header as in basic authentication
// if passport.authenticate('local') is a success, the callback fn will be called. But if it is a failure, the error is handled automatically
userRouter.post('/login' , cors.corsWithOptions ,  (req,res,next)=>{
  passport.authenticate('local',(err,user,info)=>{

    if(err){ // if there is an error during the process
      res.statusCode = 500;
      res.setHeader("Content-Type" , 'application/json');
      res.json({success: false , status: "Process Failed", err: err});
    }
    else if(!user){   // if the user doesn't exist or wrong password ... etc
      res.statusCode = 401;
      res.setHeader("Content-Type" , 'application/json');
      res.json({success: false , status: "Login Unsuccessful", err: info});
    }
    else{
      req.logIn(user, (err)=>{     // establish a session
        if(err){
          res.statusCode = 401;
          res.setHeader("Content-Type" , 'application/json');
          res.json({success: false , status: "Login Unsuccessful", err: 'Could not log in user'});
        }
        else{
          var token = authenticate.getToken({_id: req.user._id});  // u could've added more info than user id but we chose to include little information
          res.statusCode = 200;
          res.setHeader("Content-Type" , 'application/json');
          res.json({success: true , status: "Login Successful!", token: token});
        }
      });
    }
    
  })(req,res,next);
  
});

/*
userRouter.get('/checkJWTToken', cors.corsWithOptions , (req,res,next)=>{
  passport.authenticate('jwt' , {session: false} , (err,user,info)=>{
    if(err){
      return next(err);
    }
    else if(!user){
      res.statusCode = 401;
      res.setHeader('Content-Type' , 'application/json');
      res.json({status: 'JWT invalid' , success: false, err: info});
    }
    else{
      res.statusCode = 401;
      res.setHeader('Content-Type' , 'application/json');
      res.json({status: 'JWT valid' , success: true, user: user});
    }
  })(req,res,next);
});
*/

// Configuring logout process
userRouter.get('/logout' , cors.corsWithOptions ,(req,res,next)=>{
    req.logout();
    res.clearCookie('session-id');
    res.redirect('/');   // redirecting to index page.  u need to specify the full path
});



// configuring login using facebook
userRouter.get('/facebook/token' , authenticate.verifyFacebook , (req,res,next)=>{
        if(req.user){
          var token = authenticate.getToken({_id: req.user._id});
          res.statusCode = 200;
          res.setHeader("Content-Type" , 'application/json');
          res.json({success: true , token: token , status: "You are successfully logged in"});
        }
});



// Modifying users's info
//------------------------------

// Modifying Basic info
userRouter.put('/editInfo', cors.corsWithOptions ,authenticate.verifyUser, (req,res,next)=>{
    User.findById(req.user._id).then((user)=>{
      if(user == null){
        res.statusCode = 404;
        res.setHeader("Content-Type" , 'application/json');
        res.json({success: false, status:"Couldn't Modify Info", err: "User Not Found"});
      }
      else{
        if(req.body.firstname){
          user.firstname = req.body.firstname;
        }
        if(req.body.lastname){
          user.lastname = req.body.lastname;
        }
        if(req.body.email){
          user.email = req.body.email;
        }
        if(req.body.phoneNumber){
          user.phoneNumber = req.body.phoneNumber;
        }
        if(req.body.oldPassword && req.body.newPassword){
          user.changePassword(req.body.oldPassword, req.body.newPassword, (err, user)=>{
            if(err){
              res.statusCode = 500;
              res.setHeader("Content-Type" , 'application/json');
              res.json({success: false, status:"Couldn't Modify Info", err:err});
            }
            else{
              user.save().then((user)=>{
                res.statusCode = 200;
                res.setHeader("Content-Type" , 'application/json');
                res.json(user);
              }).catch((err)=>{
                res.statusCode = 500;
                res.setHeader("Content-Type" , 'application/json');
                res.json({success: false, status:"Couldn't Save Changes", err:err});
              })
            }
          });
        }
        else{
          user.save().then((user)=>{
            res.statusCode = 200;
            res.setHeader("Content-Type" , 'application/json');
            res.json(user);
          }).catch((err)=>{
            res.statusCode = 500;
            res.setHeader("Content-Type" , 'application/json');
            res.json({success: false, status:"Couldn't Save Changes", err:err});
          })
        }
      }
    }).catch((err)=>{
      res.statusCode = 500;
      res.setHeader("Content-Type" , 'application/json');
      res.json({success: false, status:"Coudln't Modify Info", err:err});
    })
});

// Modifying Profile Pic
userRouter.put('/editInfo/profilePic', cors.corsWithOptions ,authenticate.verifyUser , 
upload.upload('public/images/profiles',/\.(jpg|jpeg|png|gif)$/).single("profilePic"), (req,res,next)=>{
    if(req.wrongFormat){
      res.statusCode = 500;
      res.setHeader("Content-Type" , 'application/json');
      res.json({success: false, status:"Upload Failed", err:"Unsupported Format"});
    }
    else{
      User.findById(req.user._id).then((user)=>{
        user.profilePhoto = req.file.path;
        user.save().then((user)=>{
          res.statusCode = 200;
          res.setHeader("Content-Type" , 'application/json');
          res.json({success: true, status:"Profile Pic Updated"});
        }).catch((err)=>{
          res.statusCode = 500;
          res.setHeader("Content-Type" , 'application/json');
          res.json({success: false, status:"Couldn't Save Changes", err:err});
        })
      }).catch((err)=>{
          res.statusCode = 500;
          res.setHeader("Content-Type" , 'application/json');
          res.json({success: false, status:"Upload Failed", err:err});
      });
    }
});


// Getting all registered users
userRouter.get('/' , cors.corsWithOptions ,  authenticate.verifyUser , authenticate.verifyAdmin , (req,res,next)=>{
  User.find({}).then((users)=>{
    res.statusCode = 200;
    res.setHeader("Content-Type" , 'application/json');
    res.json(users);
  })
  .catch((err)=>{
    res.statusCode = 500;
    res.setHeader("Content-Type" , 'application/json');
    res.json({success: false , status: "Process Failed", err:err});
  });
});


module.exports = userRouter;