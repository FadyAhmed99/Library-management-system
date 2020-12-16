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
    }).catch((err)=>{
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
    }).catch((err)=>{
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
        }).catch((err)=>{
            res.statusCode = 500;
            res.setHeader("Content-Type" , 'application/json');
            res.json({success: false, status: "Process Failed" ,err:err});
        })
    }).catch((err)=>{
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

// Get list of members or list of requests
libraryRouter.get('/:libraryId', cors.corsWithOptions, authenticate.verifyUser, authenticate.verifyLibrarian, (req,res,next)=>{
    if(req.query.option == "requests"){
        User.find({"subscribedLibraries._id": {$eq: req.params.libraryId}, "subscribedLibraries.member":{$eq: false}}).then((requests)=>{
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
        }).catch((err)=>{
            res.statusCode = 500;
            res.setHeader("Content-Type", "application/json");
            res.json({success: false, status: "Process Failed", err:err});
        });
    }
    else if(req.query.option == "members"){
        User.find({"subscribedLibraries._id": {$eq: req.params.libraryId}, "subscribedLibraries.member":{$eq: true}}).then((requests)=>{
            if(requests == null){
                res.statusCode = 404;
                res.setHeader("Content-Type", "application/json");
                res.json({success: false, status: "Process Failed", err:"Members Not Found"});
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
                res.json({success: true, members: requestArr});
            }
        }).catch((err)=>{
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
        }).catch((err)=>{
            res.statusCode = 500;
            res.setHeader("Content-Type", "application/json");
            res.json({success: false, status: "Process Failed", err:err});
        });
    }).catch((err)=>{
        res.statusCode = 500;
        res.setHeader("Content-Type", "application/json");
        res.json({success: false, status: "Process Failed", err:err});
    });
});


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
                }).catch((err)=>{
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
                }).catch((err)=>{
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
    }).catch((err)=>{
        res.statusCode = 500;
        res.setHeader("Content-Type", "application/json");
        res.json({success: false, status: "Process Failed", err:err});
    });
});


module.exports = libraryRouter;