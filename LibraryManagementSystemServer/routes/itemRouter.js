var express = require('express');
const bodyParser = require('body-parser');
User = require('../models/usersSchema');
const Library = require('../models/librarySchema');
const Item = require('../models/itemSchema');
const passport = require('passport');
var itemRouter = express.Router();
itemRouter.use(bodyParser.json());
const cors = require('./cors');
const multer = require('multer');
const authenticate = require('../authenticate');
const upload = require('../upload');


itemRouter.options('*' , cors.corsWithOptions , (req,res,next)=>{
    res.sendStatus(200);
  });

itemRouter.route('/')
.get(cors.corsWithOptions, (req,res,next)=>{
    Item.find({}).then((items)=>{
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
                lateFees: items[i].lateFees
            });
        }
        res.statusCode = 200;
        res.setHeader("Content-Type" , 'application/json');
        res.json({success: true , items: itemS});
    }).catch((err="Server Failed")=>{
        res.statusCode = 500;
        res.setHeader("Content-Type" , 'application/json');
        res.json({success: false, status: "Process Failed" ,err:err});
    });
})
.post()
.put()
.delete();

module.exports = itemRouter;