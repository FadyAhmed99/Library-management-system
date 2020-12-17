var express = require('express');
const bodyParser = require('body-parser');
const User = require('../models/usersSchema');
const Library = require('../models/librarySchema');
const Item = require('../models/itemSchema');
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
.get(cors.corsWithOptions, authenticate.verifyUser ,(req,res,next)=>{
    Library.find({}).then((libs)=>{
        if(libs == null){
            res.statusCode = 500;
            res.setHeader("Content-Type" , 'application/json');
            res.json({success: false, status: "Process Failed" ,err:"No Libraries Found"});
        }
        else{
            var librars = [];
            for(var i=0; i<libs.length; i++){
                librars.push({
                    name: libs[i].name,
                    address: libs[i].address,
                    description: libs[i].description,
                    _id: libs[i]._id,
                    phoneNumber: libs[i].phoneNumber,
                    image: libs[i].image,
                    librarian: libs[i].librarian
                });
            }
            res.statusCode = 200;
            res.setHeader("Content-Type" , 'application/json');
            res.json({success: true , libraries: librars});
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
                image: library.image,
                _id: library._id
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
            var librar = {
                name: lib.name,
                address: lib.address,
                description: lib.description,
                phoneNumber: lib.phoneNumber,
                image: lib.image,
                _id: lib._id
            };
            res.statusCode = 200;
            res.setHeader("Content-Type" , 'application/json');
            res.json({success: true , library: librar});
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
                    userId: library.feedback[i].user._id,
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
  
/*
libraryRouter.route('/:libraryId/items')
// Get all items in a certain library  "library collection"
.get(cors.corsWithOptions, authenticate.verifyUser, (req,res,next)=>{
    Item.find({available:{$elemMatch:{_id: req.params.libraryId}}}).then((items)=>{
        var itemS =[];
        for(var i=0; i<items.length; i++){
            itemS.push({
                _id: items[i]._id,
                type: items[i].type,
                genre: items[i].genre,
                name: items[i].name,
                author: items[i].author,
                language: items[i].language,
                image: items[i].image,
                inLibrary: items[i].inLibrary,
                ISBN: items[i].ISBN,
                lateFees: items[i].lateFees,
                location: items[i].available.id(req.params.libraryId).location,
                amount: items[i].available.id(req.params.libraryId).amount
            });
            // calculate averageRating
            var ratings=[];
            for(var j=0; i<items[i].reviews.length; j++){
                ratings.push(items[i].reviews[j].rating);
            }
            var avarageRating = 0;
            if(ratings.length > 0){
                for(var k=0; k<ratings.length; k++){
                    avarageRating += ratings[i];
                }
                avarageRating = avarageRating/(ratings.length);
            }
            itemS[i].avarageRating = avarageRating; 
        }
        res.statusCode = 200;
        res.setHeader("Content-Type" , 'application/json');
        res.json({success: true, items: itemS});
    }
    ).catch((err="Server Failed")=>{
        res.statusCode = 500;
        res.setHeader("Content-Type" , 'application/json');
        res.json({success: false , status: "Process Failed", err:err});
    });
})
// add a new item to a certain library
.post(cors.corsWithOptions, authenticate.verifyUser, authenticate.verifyLibrarian, (req,res,next)=>{
    Item.findOne({}).then((item)=>{
        if(item == null){
            var newItem = new Item({
                name: req.body.name,
                genre: req.body.genre,
                author: req.body.author,
                type: req.body.type,
                language: req.body.language,
                image: req.body.image
            });
            if(req.body.ISBN){
                newItem.ISBN = req.body.ISBN;
            }
            if(req.body.inLibrary){
                newItem.inLibrary = req.body.inLibrary;
            }
            if(req.body.itemLink){
                newItem.itemLink = req.body.itemLink;
            }
            if(req.body.lateFees){
                newItem.lateFees = req.body.lateFees;
            }
            newItem.available.push({
                _id: req.params.libraryId,
            });
            if(req.body.amount){
                newItem.available[newItem.available.length-1].amount = req.body.amount;
            }
            if(req.body.location){
                newItem.available[newItem.available.length-1].location = req.body.location;
            }
        }
        else{

        }
    })
    // saving data
    newItem.save().then((item)=>{
        res.statusCode = 200;
        res.setHeader("Content-Type" , 'application/json');
        res.json({success: true, status: "Item Added Successfully"});
    }).catch((err="Server Failed")=>{
        res.statusCode = 500;
        res.setHeader("Content-Type" , 'application/json');
        res.json({success: false , status: "Process Failed", err:err});
    })
});


libraryRouter.route('/:libraryId/items/:itemId')
// Get full info of a certain item in a certain library
.get()
// Modify the info of a certain item in a certain library
.put()
// Delete a certain item in a certain library
.delete()
*/

module.exports = libraryRouter;