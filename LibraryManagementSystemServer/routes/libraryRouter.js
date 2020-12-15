var express = require('express');
const bodyParser = require('body-parser');
//const User = require('../models/usersSchema');
const Library = require('../models/librarySchema');
const passport = require('passport');
var libraryRouter = express.Router();
libraryRouter.use(bodyParser.json());
const cors = require('./cors');
const multer = require('multer');
const authenticate = require('../authenticate');
const upload = require('../upload');
const e = require('express');
const userRouter = require('./usersRouter');


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

libraryRouter.route('/:libraryId')
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



module.exports = libraryRouter;