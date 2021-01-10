var express = require('express');
const bodyParser = require('body-parser');
const User = require('../models/usersSchema');
const Library = require('../models/librarySchema');
const Item = require('../models/itemSchema');
const passport = require('passport');
var statsReport = express.Router();
statsReport.use(bodyParser.json());
const cors = require('./cors');
const multer = require('multer');
const authenticate = require('../authenticate');
const upload = require('../upload');
const config = require('../config');
const { correctPath } = require('../photo_correction');

statsReport.options('*' , cors.corsWithOptions , (req,res,next)=>{
    res.sendStatus(200);
});

// Getting all registered users
statsReport.get('/users' , cors.corsWithOptions ,  authenticate.verifyUser , authenticate.verifyAdmin , (req,res,next)=>{
    User.find({}).then((users)=>{
      var usrs = [];
      for(var i=0; i<users.length; i++){
        usrs.push({
            _id: users[i]._id,
            firstname: users[i].firstname,
            lastname: users[i].lastname,
            profilePhoto: users[i].profilePhoto
        });
      }

      res.statusCode = 200;
      res.setHeader("Content-Type" , 'application/json');
      res.json({success: true, users: usrs});
    })
    .catch((err="Server Failed")=>{
      res.statusCode = 500;
      res.setHeader("Content-Type" , 'application/json');
      res.json({success: false , status: "Process Failed", err:err});
    });
});

// for library 1
statsReport.get('/libraries/lib1', cors.corsWithOptions, authenticate.verifyUser, authenticate.verifyAdmin, (req,res,next)=>{
    var latest1 = [];
    Item.find({available:{$elemMatch:{_id: config.lib1}}}).then((items)=>{
        var dates = [];
        var itemS = [];
        for(var i=0; i<items.length; i++){
            dates.push({
                item: i,
                createdAt: items[i].available.id(config.lib1).createdAt
            });
            itemS.push({
                _id: items[i]._id,
                type: items[i].type,
                genre: items[i].genre,
                name: items[i].name,
                author: items[i].author,
                language: items[i].language,
                ISBN: items[i].ISBN,
                image: items[i].available.id(config.lib1).image,
                inLibrary: items[i].available.id(config.lib1).inLibrary,
                lateFees: items[i].available.id(config.lib1).lateFees,
                location: items[i].available.id(config.lib1).location,
                amount: items[i].available.id(config.lib1).amount,
                library: items[i].available.id(config.lib1)._id
            });
        }
        dates.sort((a,b)=>{
            if(a.createdAt < b.createdAt){
                return 1;
            }
            else{
                return -1;
            }
        });
        if(dates.length < 5){
            for(var i=0; i<dates.length; i++){
                latest1.push(itemS[dates[i].item]);
            }
        }
        else{
            for(var i=0; i<5; i++){
                latest1.push(itemS[dates[i].item]);
            }
        }
        res.statusCode = 200;
        res.setHeader("Content-Type" , 'application/json');
        res.json({success: true , num: items.length ,latest1: latest1});
    }).catch((err="Server Failed")=>{
        res.statusCode = 500;
        res.setHeader("Content-Type" , 'application/json');
        res.json({success: false , status: "Process Failed", err:err});
    });
});



// for library 2
statsReport.get('/libraries/lib2', cors.corsWithOptions, authenticate.verifyUser, authenticate.verifyAdmin, (req,res,next)=>{
    var latest2 = [];
    Item.find({available:{$elemMatch:{_id: config.lib2}}}).then((items)=>{
        var dates = [];
        var itemS = [];
        for(var i=0; i<items.length; i++){
            dates.push({
                item: i,
                createdAt: items[i].available.id(config.lib2).createdAt
            });
            itemS.push({
                _id: items[i]._id,
                type: items[i].type,
                genre: items[i].genre,
                name: items[i].name,
                author: items[i].author,
                language: items[i].language,
                ISBN: items[i].ISBN,
                image: items[i].available.id(config.lib2).image,
                inLibrary: items[i].available.id(config.lib2).inLibrary,
                lateFees: items[i].available.id(config.lib2).lateFees,
                location: items[i].available.id(config.lib2).location,
                amount: items[i].available.id(config.lib2).amount,
                library: items[i].available.id(config.lib2)._id
            });
        }
        dates.sort((a,b)=>{
            if(a.createdAt < b.createdAt){
                return 1;
            }
            else{
                return -1;
            }
        });
        if(dates.length < 5){
            for(var i=0; i<dates.length; i++){
                latest2.push(itemS[dates[i].item]);
            }
        }
        else{
            for(var i=0; i<5; i++){
                latest2.push(itemS[dates[i].item]);
            }
        }
        res.statusCode = 200;
        res.setHeader("Content-Type" , 'application/json');
        res.json({success: true , num: items.length, latest2: latest2});
    }).catch((err="Server Failed")=>{
        res.statusCode = 500;
        res.setHeader("Content-Type" , 'application/json');
        res.json({success: false , status: "Process Failed", err:err});
    });
});




// for library 3
statsReport.get('/libraries/lib3', cors.corsWithOptions, authenticate.verifyUser, authenticate.verifyAdmin, (req,res,next)=>{
    var latest3 = [];
    Item.find({available:{$elemMatch:{_id: config.lib3}}}).then((items)=>{
        var dates = [];
        var itemS = [];
        for(var i=0; i<items.length; i++){
            dates.push({
                item: i,
                createdAt: items[i].available.id(config.lib3).createdAt
            });
            itemS.push({
                _id: items[i]._id,
                type: items[i].type,
                genre: items[i].genre,
                name: items[i].name,
                author: items[i].author,
                language: items[i].language,
                ISBN: items[i].ISBN,
                image: items[i].available.id(config.lib3).image,
                inLibrary: items[i].available.id(config.lib3).inLibrary,
                lateFees: items[i].available.id(config.lib3).lateFees,
                location: items[i].available.id(config.lib3).location,
                amount: items[i].available.id(config.lib3).amount,
                library: items[i].available.id(config.lib3)._id
            });
        }
        dates.sort((a,b)=>{
            if(a.createdAt < b.createdAt){
                return 1;
            }
            else{
                return -1;
            }
        });
        if(dates.length < 5){
            for(var i=0; i<dates.length; i++){
                latest3.push(itemS[dates[i].item]);
            }
        }
        else{
            for(var i=0; i<5; i++){
                latest3.push(itemS[dates[i].item]);
            }
        }
        res.statusCode = 200;
        res.setHeader("Content-Type" , 'application/json');
        res.json({success: true , num: items.length ,latest3: latest3});
    }).catch((err="Server Failed")=>{
        res.statusCode = 500;
        res.setHeader("Content-Type" , 'application/json');
        res.json({success: false , status: "Process Failed", err:err});
    });    
});


module.exports = statsReport;





