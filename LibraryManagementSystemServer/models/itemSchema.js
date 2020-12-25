const mongoose = require("mongoose");
const schema = mongoose.Schema;

require('mongoose-currency').loadType(mongoose); 
const currency = mongoose.Types.Currency

const availableSchema = new schema({
  _id: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Library",
    required: true,
  },
  amount: {
    type: Number,
    min: 0
  },
  location: {
    type: String,
    default: ""
  },
  lateFees:{
    type: currency,
    min: 0,
    default: 0
  },
  inLibrary:{
    type: Boolean,
    default: false
  },
  image: { 
    type: String,
    default: ""
  },
  itemLink: {
    type: String,
    default: ''
  }
}, {
  timestamps: true
});
const reviewSchema = new schema({
  _id: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User"
  },
  rating: {
    type: Number,
    min: 0,
    required: true
  },
  review: {
    type: String,
    default: ''
  },
});

const itemSchema = new schema({
  // Essential info
  type: { 
    type: String, 
    required: true 
  },
  genre: { 
    type: String, 
    // required: true 
  },
  name: { 
    type: String, 
    // required: true 
  },
  author: { 
    type: String, 
    // required: true 
  },
  language: { 
    type: String,
    // required: true
  },
  ISBN: { 
    type: String ,
    default: ''
  },
  available: [availableSchema],
  reviews: [reviewSchema]
});

var Items = mongoose.model("Item", itemSchema);
module.exports = Items;
