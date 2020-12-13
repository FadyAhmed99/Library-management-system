const mongoose = require("mongoose");
const schema = mongoose.Schema;

const availableSchema = new schema({
  _id: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Library",
    required: true,
  },
  amount: {
    type: Number
  },
  location: {
    type: String
  },
});
const reviewSchema = new schema({
  _id: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User"
  },
  rating: {
    type: Number,
    required: true
  },
  review: {
    type: String,
    default: ''
  },
});

const itemSchema = new schema({
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
    required: true 
  },
  author: { 
    type: String, 
  //  required: true 
  },
  language: { 
    type: String,
   // required: true
  },
  ISBN: { 
    type: String 
  },
  averageRating: { 
    type: Number, 
    default: 0
  },
  itemLink: {
     type: String 
    },
  inLibrary: { 
    type: Boolean,
    default: false
  },
  image: { 
    type: String
  },
  lateFees: { 
    type: Number
  },
  available: [availableSchema],
  reviews: [reviewSchema],
});

var Items = mongoose.model("Item", itemSchema);
module.exports = Items;
