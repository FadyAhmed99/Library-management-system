var express = require('express');
const bodyParser = require('body-parser');
User = require('../models/usersSchema');
const Library = require('../models/librarySchema');
const passport = require('passport');
var libraryRouter = express.Router();
libraryRouter.use(bodyParser.json());
const cors = require('./cors');
const multer = require('multer');
const authenticate = require('../authenticate');
const upload = require('../upload');


libraryRouter.options('*' , cors.corsWithOptions , (req,res,next)=>{
  res.sendStatus(200);
});

libraryRouter.route('/')
.get(cors.cors, (req,res,next)=>{
    Library.find({}).then((libs)=>{
        if(libs == null){
            res.statusCode = 500;
            res.setHeader("Content-Type" , 'application/json');
            res.json({success: false, status: "Process Failed" ,err:"No Libraries Found"});
        }
        else{
            res.statusCode = 200;
            res.setHeader("Content-Type" , 'application/json');
            res.json({success: true , libraries: libs});
        }
    }).catch((err="Server Failed")=>{
        res.statusCode = 500;
        res.setHeader("Content-Type" , 'application/json');
        res.json({success: false, status: "Process Failed" ,err:err});
    });
})
.post(cors.corsWithOptions, (req,res,next)=>{
    res.statusCode = 404;
    res.setHeader("Content-Type" , 'application/json');
    res.json({success: false, status: "NOT ALLOWED" ,err:"Not Found"});
})
.put(cors.corsWithOptions, (req,res,next)=>{
    res.statusCode = 404;
    res.setHeader("Content-Type" , 'application/json');
    res.json({success: false, status: "NOT ALLOWED" ,err:"Not Found"});
})
.delete(cors.corsWithOptions, (req,res,next)=>{
    res.statusCode = 404;
    res.setHeader("Content-Type" , 'application/json');
    res.json({success: false, status: "NOT ALLOWED" ,err:"Not Found"});
});

libraryRouter.route('/:libraryId/info')
.get(cors.cors , (req,res,next)=>{
    Library.findById(req.params.libraryId).populate('librarian').then((library)=>{
        if(library == null){
            res.statusCode = 404;
            res.setHeader("Content-Type" , 'application/json');
            res.json({success: false, status: "Process Failed" ,err:"Library Not Found"});
        }
        else{
            var libr = {
                firstname: library.librarian.firstname,
                lastname: library.librarian.lastname,
                email: library.librarian.email,
                profilePhoto: library.librarian.profilePhoto,
                phoneNumber: library.librarian.phoneNumber
            }
            var lib = {
                name:library.name,
                address: library.address,
                description: library.description,
                phoneNumber: library.phoneNumber,
                image: library.image
            }
            res.statusCode = 200;
            res.setHeader("Content-Type" , 'application/json');
            res.json({success: true , library: lib ,librarian: libr});
        }
    }).catch((err="Server Failed")=>{
        res.statusCode = 500;
        res.setHeader("Content-Type" , 'application/json');
        res.json({success: false, status: "Process Failed" ,err:err});
    });
})
.post(cors.corsWithOptions, (req,res,next)=>{
    res.statusCode = 404;
    res.setHeader("Content-Type" , 'application/json');
    res.json({success: false, status: "NOT ALLOWED" ,err:"Not Found"});
})
.put(cors.corsWithOptions , authenticate.verifyUser , authenticate.verifyLibrarian, (req,res,next)=>{
    Library.findById(req.params.libraryId).then((lib)=>{
        if(req.body.name){
            lib.name = req.body.name;
        }
        if(req.body.address){
            lib.address = req.body.address;
        }
        if(req.body.description){
            lib.description = req.body.description;
        }
        if(req.body.phoneNumber){
            lib.phoneNumber = req.body.phoneNumber;
        }
        lib.save().then((lib)=>{
            res.statusCode = 200;
            res.setHeader("Content-Type" , 'application/json');
            res.json({success: true , library: lib});
        }).catch((err="Server Failed")=>{
            res.statusCode = 500;
            res.setHeader("Content-Type" , 'application/json');
            res.json({success: false, status: "Process Failed" ,err:err});
        })
    }).catch((err="Server Failed")=>{
        res.statusCode = 500;
        res.setHeader("Content-Type" , 'application/json');
        res.json({success: false, status: "Process Failed" ,err:err});
    });
})
.delete(cors.corsWithOptions, (req,res,next)=>{
    res.statusCode = 404;
    res.setHeader("Content-Type" , 'application/json');
    res.json({success: false, status: "NOT ALLOWED" ,err:"Not Found"});
});

// Get list of all members of the library or list of all join requests to the library
libraryRouter.get('/:libraryId', cors.corsWithOptions, authenticate.verifyUser, authenticate.verifyLibrarian, (req,res,next)=>{
    if(req.query.option == "requests"){
        User.find({"subscribedLibraries": {$elemMatch:{_id: req.params.libraryId, member: false}}}).then((requests)=>{
            if(requests == null){
                res.statusCode = 404;
                res.setHeader("Content-Type", "application/json");
                res.json({success: false, status: "Process Failed", err:"Requests Not Found"});
            }
            else{
                var requestArr = [];
                for(var i=0; i<requests.length; i++){
                    requestArr[i]={
                        firstname: requests[i].firstname,
                        lastname: requests[i].lastname,
                        _id: requests[i]._id,
                        profilePhoto: requests[i].profilePhoto
                    }
                }
                res.statusCode = 200;
                res.setHeader("Content-Type", "application/json");
                res.json({success: true, requests: requestArr});
            }
        }).catch((err="Server Failed")=>{
            res.statusCode = 500;
            res.setHeader("Content-Type", "application/json");
            res.json({success: false, status: "Process Failed", err:err});
        });
    }
    else if(req.query.option == "members"){
        User.find({"subscribedLibraries": {$elemMatch:{_id: req.params.libraryId, member: true}}}).then((members)=>{
            if(members == null){
                res.statusCode = 404;
                res.setHeader("Content-Type", "application/json");
                res.json({success: false, status: "Process Failed", err:"Members Not Found"});
            }
            else{
                var memberArr = [];
                for(var i=0; i<members.length; i++){
                    memberArr[i]={
                        firstname: members[i].firstname,
                        lastname: members[i].lastname,
                        _id: members[i]._id,
                        profilePhoto: members[i].profilePhoto
                    }
                }
                res.statusCode = 200;
                res.setHeader("Content-Type", "application/json");
                res.json({success: true, members: memberArr});
            }
        }).catch((err="Server Failed")=>{
            res.statusCode = 500;
            res.setHeader("Content-Type", "application/json");
            res.json({success: false, status: "Process Failed", err:err});
        });
    }
    else{
        res.statusCode = 404;
        res.setHeader("Content-Type", "application/json");
        res.json({success: false, status: "Process Failed", err:"Invalid Parameters"});
    }
});

// Send a join request to a library
libraryRouter.post('/:libraryId/requests' , cors.corsWithOptions, authenticate.verifyUser, authenticate.verifyNotMember, (req,res,next)=>{
    User.findById(req.user._id).then((user)=>{
        user.subscribedLibraries.push({
            _id: req.params.libraryId
        });
        user.save().then((user)=>{
            res.statusCode = 200;
            res.setHeader("Content-Type", "application/json");
            res.json({success: true, status: "Join Request Sent"});
        }).catch((err="Server Failed")=>{
            res.statusCode = 500;
            res.setHeader("Content-Type", "application/json");
            res.json({success: false, status: "Process Failed", err:err});
        });
    }).catch((err="Server Failed")=>{
        res.statusCode = 500;
        res.setHeader("Content-Type", "application/json");
        res.json({success: false, status: "Process Failed", err:err});
    });
});

// Accept or reject requests   or  delete memebers from the library
libraryRouter.put('/:libraryId/:userId', cors.corsWithOptions, authenticate.verifyUser, authenticate.verifyLibrarian, (req,res,next)=>{
    User.findById(req.params.userId).then((user)=>{
        if(user == null){
            res.statusCode = 404;
            res.setHeader("Content-Type", "application/json");
            res.json({success: false, status: "Process Failed", err:"User Not Found"});
        }
        else{
            if(req.query.action == "approve"){  // approve join request
                user.subscribedLibraries.id(req.params.libraryId).member = true;
                user.save().then((user)=>{
                    res.statusCode = 200;
                    res.setHeader("Content-Type", "application/json");
                    res.json({success: true, status: "Request Approved Successfuly"});
                }).catch((err="Server Failed")=>{
                    res.statusCode = 500;
                    res.setHeader("Content-Type", "application/json");
                    res.json({success: false, status: "Process Failed", err:err});
                });
            }
            // Reject Incoming Requests or Delete existing memebers
            else if(req.query.action == "reject"){ // reject join request or delete the user if he is already a memeber
                user.subscribedLibraries.id(req.params.libraryId).remove();
                user.save().then((user)=>{
                    res.statusCode = 200;
                    res.setHeader("Content-Type", "application/json");
                    res.json({success: true, status: "User Rejected Successfuly"});
                }).catch((err="Server Failed")=>{
                    res.statusCode = 500;
                    res.setHeader("Content-Type", "application/json");
                    res.json({success: false, status: "Process Failed", err:err});
                });
            }
            else{
                res.statusCode = 404;
                res.setHeader("Content-Type", "application/json");
                res.json({success: false, status: "Process Failed", err:"Invalid Parameters"});
            }
        } 
    }).catch((err="Server Failed")=>{
        res.statusCode = 500;
        res.setHeader("Content-Type", "application/json");
        res.json({success: false, status: "Process Failed", err:err});
    });
});

// Send feedback to the library
libraryRouter.route('/:libraryId/feedback')
.post(cors.corsWithOptions, authenticate.verifyUser, authenticate.verifyMember, (req,res,next)=>{
    Library.findById(req.params.libraryId).then((library)=>{
        if(library == null){
            res.statusCode = 404;
            res.setHeader("Content-Type", "application/json");
            res.json({success: false, status: "Process Failed", err:"Library Not Found"});
        }
        else{
            library.feedback.push({
                user: req.user._id,
                feedback: req.body.feedback 
            });
            library.save().then((lib)=>{
                res.statusCode = 200;
                res.setHeader("Content-Type", "application/json");
                res.json({success: true, status: "Feedback Sent Successfully"});
            }).catch((err="Server Failed")=>{
                res.statusCode = 500;
                res.setHeader("Content-Type", "application/json");
                res.json({success: false, status: "Process Failed", err:err})
            });
        }
    }).catch((err="Server Failed")=>{
        res.statusCode = 500;
        res.setHeader("Content-Type", "application/json");
        res.json({success: false, status: "Process Failed", err:err});
    });
})
// view library feedbacks
.get(cors.corsWithOptions, authenticate.verifyUser, authenticate.verifyLibrarian, (req,res,next)=>{
    Library.findById(req.params.libraryId).populate("feedback.user").then((library)=>{
        if(library == null){
            res.statusCode = 404;
            res.setHeader("Content-Type", "application/json");
            res.json({success: false, status: "Process Failed", err:"Library Not Found"});
        }
        else{
            var feedbacks = [];
            for(var i=0; i<library.feedback.length; i++){
                feedbacks.push({
                    firstname: library.feedback[i].user.firstname,
                    lastname: library.feedback[i].user.lastname,
                    profilePhoto: library.feedback[i].user.profilePhoto,
                    feedback: library.feedback[i].feedback
                });
            }
            res.statusCode = 200;
            res.setHeader("Content-Type", "application/json");
            res.json({success: true, feedbacks: feedbacks});
        }
    }).catch((err="Server Failed")=>{
        res.statusCode = 500;
        res.setHeader("Content-Type", "application/json");
        res.json({success: false, status: "Process Failed", err:err});
    });
});


// Get all blocked users from something in your library
libraryRouter.get('/:libraryId/permissions/get', cors.corsWithOptions , authenticate.verifyUser , authenticate.verifyLibrarian , (req,res,next)=>{
    if(req.query.blockedFrom == "borrowing"){
      User.find({canBorrowItems: false, subscribedLibraries: {$elemMatch:{_id: req.params.libraryId, member: true}}}).then((users)=>{
        var bUsers = [];
        for(var i=0; i<users.length; i++){
            bUsers.push({
                firstname: users[i].firstname,
                lastname: users[i].lastname,
                profilePhoto: users[i].profilePhoto,
                canBorrowItems: users[i].canBorrowItems,
                canEvaluateItems: users[i].canEvaluateItems,
                _id: users[i]._id
            });
        }
        res.statusCode = 200;
        res.setHeader("Content-Type" , 'application/json');
        res.json({success: true, blockedUsers: bUsers});
      }).catch((err="Server Failed")=>{
        res.statusCode = 500;
        res.setHeader("Content-Type" , 'application/json');
        res.json({success: false , status: "Process Failed", err:err});
      });
    }
    else if(req.query.blockedFrom == "evaluating"){
      User.find({canEvaluateItems: false, subscribedLibraries: {$elemMatch:{_id: req.params.libraryId, member: true}}}).then((users)=>{
        var bUsers = [];
        for(var i=0; i<users.length; i++){
            bUsers.push({
                firstname: users[i].firstname,
                lastname: users[i].lastname,
                profilePhoto: users[i].profilePhoto,
                canBorrowItems: users[i].canBorrowItems,
                canEvaluateItems: users[i].canEvaluateItems,
                _id: users[i]._id
            });
        }
        res.statusCode = 200;
        res.setHeader("Content-Type" , 'application/json');
        res.json({success: true, blockedUsers: bUsers});
      }).catch((err="Server Failed")=>{
        res.statusCode = 500;
        res.setHeader("Content-Type" , 'application/json');
        res.json({success: false , status: "Process Failed", err:err});
      });
    }
    else{
      res.statusCode = 404;
      res.setHeader("Content-Type" , 'application/json');
      res.json({success: false , status: "Process Failed", err:"Invalid Parameters"});
    }
  });
  
// set permissions to a certain user in the library
libraryRouter.put('/:libraryId/permissions/:userId/set', cors.corsWithOptions , authenticate.verifyUser , authenticate.verifyLibrarian, authenticate.verifyMemberToLibrary ,(req,res,next)=>{
    User.findById(req.params.userId).then((user)=>{
      if(user == null){
        res.statusCode = 500;
        res.setHeader("Content-Type" , 'application/json');
        res.json({success: false , status: "Process Failed", err:"User Not Found"});
      }
      else if(user.librarian){
        res.statusCode = 403;
        res.setHeader("Content-Type" , 'application/json');
        res.json({success: false , status: "Process Failed", err:"You Can't Set Permissions For Admins"});
      }
      else if((req.query.action == "block" || req.query.action == "unblock") && (req.query.from == "evaluating" || req.query.from == "borrowing")){
        if(req.query.action == "block"){
          if(req.query.from == "borrowing"){
            user.canBorrowItems = false;
            user.save().then((user)=>{
              var sUser ={
                firstname: user.firstname,
                lastname: user.lastname,
                profilePhoto: user.profilePhoto,
                canBorrowItems: user.canBorrowItems,
                canEvaluateItems: user.canEvaluateItems,
                _id: user._id
              };  
              res.statusCode = 200;
              res.setHeader("Content-Type" , 'application/json');
              res.json({success: true, user: sUser});
            }).catch((err="Server Failed")=>{
              res.statusCode = 500;
              res.setHeader("Content-Type" , 'application/json');
              res.json({success: false , status: "Process Failed", err:err});
            });
          }
          else if(req.query.from == "evaluating"){
            user.canEvaluateItems = false;
            user.save().then((user)=>{
                var sUser ={
                    firstname: user.firstname,
                    lastname: user.lastname,
                    profilePhoto: user.profilePhoto,
                    canBorrowItems: user.canBorrowItems,
                    canEvaluateItems: user.canEvaluateItems,
                    _id: user._id
                  };  
              res.statusCode = 200;
              res.setHeader("Content-Type" , 'application/json');
              res.json({success: true, user: sUser});
            }).catch((err="Server Failed")=>{
              res.statusCode = 500;
              res.setHeader("Content-Type" , 'application/json');
              res.json({success: false , status: "Process Failed", err:err});
            });
          }
        }
        else if(req.query.action == "unblock"){
          if(req.query.from == "borrowing"){
            user.canBorrowItems = true;
            user.save().then((user)=>{
                var sUser ={
                    firstname: user.firstname,
                    lastname: user.lastname,
                    profilePhoto: user.profilePhoto,
                    canBorrowItems: user.canBorrowItems,
                    canEvaluateItems: user.canEvaluateItems,
                    _id: user._id
                  };  
              res.statusCode = 200;
              res.setHeader("Content-Type" , 'application/json');
              res.json({success: true, user: sUser});
            }).catch((err="Server Failed")=>{
              res.statusCode = 500;
              res.setHeader("Content-Type" , 'application/json');
              res.json({success: false , status: "Process Failed", err:err});
            });
          }
          else if(req.query.from == "evaluating"){
            user.canEvaluateItems = true;
            user.save().then((user)=>{
                var sUser ={
                    firstname: user.firstname,
                    lastname: user.lastname,
                    profilePhoto: user.profilePhoto,
                    canBorrowItems: user.canBorrowItems,
                    canEvaluateItems: user.canEvaluateItems,
                    _id: user._id
                  };    
              res.statusCode = 200;
              res.setHeader("Content-Type" , 'application/json');
              res.json({success: true, user: sUser});
            }).catch((err="Server Failed")=>{
              res.statusCode = 500;
              res.setHeader("Content-Type" , 'application/json');
              res.json({success: false , status: "Process Failed", err:err});
            });
          }
        }
      }
      else{
        res.statusCode = 404;
        res.setHeader("Content-Type" , 'application/json');
        res.json({success: false , status: "Process Failed", err:"Invalid Parameters"});
      }
    }).catch((err="Server Failed")=>{
      res.statusCode = 500;
      res.setHeader("Content-Type" , 'application/json');
      res.json({success: false , status: "Process Failed", err:err});
    });
  });
  
  


module.exports = libraryRouter;