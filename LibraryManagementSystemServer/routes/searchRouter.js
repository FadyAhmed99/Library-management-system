var express = require('express');
const bodyParser = require('body-parser');
const User = require('../models/usersSchema');
const Library = require('../models/librarySchema');
const Item = require('../models/itemSchema');
const passport = require('passport');
var searchRouter = express.Router();
searchRouter.use(bodyParser.json());
const cors = require('./cors');
const multer = require('multer');
const authenticate = require('../authenticate');
const upload = require('../upload');

searchRouter.options('*' , cors.corsWithOptions , (req,res,next)=>{
    res.sendStatus(200);
});

searchRouter.get('/', cors.corsWithOptions, authenticate.verifyUser, (req,res,next)=>{
    if(req.query.filter == "" || req.query.filter == " "){
        res.statusCode = 404;
        res.setHeader("Content-Type", "application/json");
        res.json({success: false, status: "Process Failed", err:"No Value Specified"});
    }
    else{
        if(req.query.by == "name"){
            var regex = new RegExp(req.query.filter, 'i');
            Item.find({name: regex}).then((items)=>{
                var itemS = [];

                // calculating average rating
                for(var i=0; i<items.length; i++){
                    var ratings = [];
                    for(var k=0; k<items[i].reviews.length; k++){
                        ratings.push(items[i].reviews[k].rating);
                    };
                    var averageRating = 0;
                    if(ratings.length>0){
                        for(var l=0; l<ratings.length; l++){
                            averageRating += ratings[l];
                        }
                        averageRating = averageRating/(ratings.length);
                    }

                    for(var j=0; j<items[i].available.length; j++){
                        itemS.push({
                            _id: items[i]._id,
                            type: items[i].type,
                            genre: items[i].genre,
                            name: items[i].name,
                            author: items[i].author,
                            language: items[i].language,
                            ISBN: items[i].ISBN,
                            averageRating: averageRating,
                            libraryId: items[i].available[j]._id,
                            lateFees: items[i].available[j].lateFees,
                            location: items[i].available[j].location,
                            amount: items[i].available[j].amount,
                            inLibrary: items[i].available[j].inLibrary,
                            image: items[i].available[j].image
                        });
                    }
                }

                res.statusCode = 200;
                res.setHeader("Content-Type", "application/json");
                res.json({success: true, items: itemS});
            }).catch((err="Server Failed")=>{
                res.statusCode = 500;
                res.setHeader("Content-Type", "application/json");
                res.json({success: false, status: "Process Failed", err:err});
            });
        }



        else if(req.query.by == "genre"){
            var regex = new RegExp(req.query.filter, 'i');
            Item.find({genre: regex}).then((items)=>{
                var itemS = [];

                // calculating average rating
                for(var i=0; i<items.length; i++){
                    var ratings = [];
                    for(var k=0; k<items[i].reviews.length; k++){
                        ratings.push(items[i].reviews[k].rating);
                    };
                    var averageRating = 0;
                    if(ratings.length>0){
                        for(var l=0; l<ratings.length; l++){
                            averageRating += ratings[l];
                        }
                        averageRating = averageRating/(ratings.length);
                    }

                    for(var j=0; j<items[i].available.length; j++){
                        itemS.push({
                            _id: items[i]._id,
                            type: items[i].type,
                            genre: items[i].genre,
                            name: items[i].name,
                            author: items[i].author,
                            language: items[i].language,
                            ISBN: items[i].ISBN,
                            averageRating: averageRating,
                            libraryId: items[i].available[j]._id,
                            lateFees: items[i].available[j].lateFees,
                            location: items[i].available[j].location,
                            amount: items[i].available[j].amount,
                            inLibrary: items[i].available[j].inLibrary,
                            image: items[i].available[j].image
                        });
                    }
                }

                res.statusCode = 200;
                res.setHeader("Content-Type", "application/json");
                res.json({success: true, items: itemS});
            }).catch((err="Server Failed")=>{
                res.statusCode = 500;
                res.setHeader("Content-Type", "application/json");
                res.json({success: false, status: "Process Failed", err:err});
            });
        }



        else if(req.query.by == "author"){
            var regex = new RegExp(req.query.filter, 'i');
            Item.find({author: regex}).then((items)=>{
                var itemS = [];

                // calculating average rating
                for(var i=0; i<items.length; i++){
                    var ratings = [];
                    for(var k=0; k<items[i].reviews.length; k++){
                        ratings.push(items[i].reviews[k].rating);
                    };
                    var averageRating = 0;
                    if(ratings.length>0){
                        for(var l=0; l<ratings.length; l++){
                            averageRating += ratings[l];
                        }
                        averageRating = averageRating/(ratings.length);
                    }

                    for(var j=0; j<items[i].available.length; j++){
                        itemS.push({
                            _id: items[i]._id,
                            type: items[i].type,
                            genre: items[i].genre,
                            name: items[i].name,
                            author: items[i].author,
                            language: items[i].language,
                            ISBN: items[i].ISBN,
                            averageRating: averageRating,
                            libraryId: items[i].available[j]._id,
                            lateFees: items[i].available[j].lateFees,
                            location: items[i].available[j].location,
                            amount: items[i].available[j].amount,
                            inLibrary: items[i].available[j].inLibrary,
                            image: items[i].available[j].image
                        });
                    }
                }

                res.statusCode = 200;
                res.setHeader("Content-Type", "application/json");
                res.json({success: true, items: itemS});
            }).catch((err="Server Failed")=>{
                res.statusCode = 500;
                res.setHeader("Content-Type", "application/json");
                res.json({success: false, status: "Process Failed", err:err});
            });
        }



        else if(req.query.by == "language"){
            var regex = new RegExp(req.query.filter, 'i');
            Item.find({language: regex}).then((items)=>{
                var itemS = [];

                // calculating average rating
                for(var i=0; i<items.length; i++){
                    var ratings = [];
                    for(var k=0; k<items[i].reviews.length; k++){
                        ratings.push(items[i].reviews[k].rating);
                    };
                    var averageRating = 0;
                    if(ratings.length>0){
                        for(var l=0; l<ratings.length; l++){
                            averageRating += ratings[l];
                        }
                        averageRating = averageRating/(ratings.length);
                    }

                    for(var j=0; j<items[i].available.length; j++){
                        itemS.push({
                            _id: items[i]._id,
                            type: items[i].type,
                            genre: items[i].genre,
                            name: items[i].name,
                            author: items[i].author,
                            language: items[i].language,
                            ISBN: items[i].ISBN,
                            averageRating: averageRating,
                            libraryId: items[i].available[j]._id,
                            lateFees: items[i].available[j].lateFees,
                            location: items[i].available[j].location,
                            amount: items[i].available[j].amount,
                            inLibrary: items[i].available[j].inLibrary,
                            image: items[i].available[j].image
                        });
                    }
                }

                res.statusCode = 200;
                res.setHeader("Content-Type", "application/json");
                res.json({success: true, items: itemS});
            }).catch((err="Server Failed")=>{
                res.statusCode = 500;
                res.setHeader("Content-Type", "application/json");
                res.json({success: false, status: "Process Failed", err:err});
            });
        }



        else if(req.query.by == "type"){
            var regex = new RegExp(req.query.filter, 'i');
            Item.find({type: regex}).then((items)=>{
                var itemS = [];

                    // calculating average rating
                    for(var i=0; i<items.length; i++){
                        var ratings = [];
                        for(var k=0; k<items[i].reviews.length; k++){
                            ratings.push(items[i].reviews[k].rating);
                        };
                        var averageRating = 0;
                        if(ratings.length>0){
                            for(var l=0; l<ratings.length; l++){
                                averageRating += ratings[l];
                            }
                            averageRating = averageRating/(ratings.length);
                        }

                        for(var j=0; j<items[i].available.length; j++){
                            itemS.push({
                                _id: items[i]._id,
                                type: items[i].type,
                                genre: items[i].genre,
                                name: items[i].name,
                                author: items[i].author,
                                language: items[i].language,
                                ISBN: items[i].ISBN,
                                averageRating: averageRating,
                                libraryId: items[i].available[j]._id,
                                lateFees: items[i].available[j].lateFees,
                                location: items[i].available[j].location,
                                amount: items[i].available[j].amount,
                                inLibrary: items[i].available[j].inLibrary,
                                image: items[i].available[j].image
                            });
                        }
                    }

                    res.statusCode = 200;
                    res.setHeader("Content-Type", "application/json");
                    res.json({success: true, items: itemS});
            }).catch((err="Server Failed")=>{
                res.statusCode = 500;
                res.setHeader("Content-Type", "application/json");
                res.json({success: false, status: "Process Failed", err:err});
            });
        }



        else if(req.query.by == "ISBN"){
            var regex = new RegExp(req.query.filter, 'i');
            Item.find({ISBN: regex}).then((items)=>{
                var itemS = [];

                // calculating average rating
                for(var i=0; i<items.length; i++){
                    var ratings = [];
                    for(var k=0; k<items[i].reviews.length; k++){
                        ratings.push(items[i].reviews[k].rating);
                    };
                    var averageRating = 0;
                    if(ratings.length>0){
                        for(var l=0; l<ratings.length; l++){
                            averageRating += ratings[l];
                        }
                        averageRating = averageRating/(ratings.length);
                    }

                    for(var j=0; j<items[i].available.length; j++){
                        itemS.push({
                            _id: items[i]._id,
                            type: items[i].type,
                            genre: items[i].genre,
                            name: items[i].name,
                            author: items[i].author,
                            language: items[i].language,
                            ISBN: items[i].ISBN,
                            averageRating: averageRating,
                            libraryId: items[i].available[j]._id,
                            lateFees: items[i].available[j].lateFees,
                            location: items[i].available[j].location,
                            amount: items[i].available[j].amount,
                            inLibrary: items[i].available[j].inLibrary,
                            image: items[i].available[j].image
                        });
                    }
                }

                res.statusCode = 200;
                res.setHeader("Content-Type", "application/json");
                res.json({success: true, items: itemS});
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
});

module.exports = searchRouter;