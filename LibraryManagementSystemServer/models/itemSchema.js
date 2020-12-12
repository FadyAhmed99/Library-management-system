const mongoose = require("mongoose");
const schema = mongoose.Schema;

const availableSchema = new schema({
  _id: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Library",
    required: true,
  },
  amount: {
    type: Number,
    required: true,
    default: 0,
  },
  location: {
    type: String,
    required: true,
  },
});
const reviewSchema = new schema({
  _id: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User",
  },
  rating: {
    type: Number,
    required: true,
  },
  review: {
    type: String,
  },
});

const itemSchema = new schema({
  type: { type: String, required: true },
  genre: { type: String, required: true },
  name: { type: String, required: true },
  author: { type: String, required: true },
  language: { type: String },
  ISBN: { type: String },
  averageRating: { type: Number },
  itemLink: { type: String },
  inLibrary: { type: Boolean, required: true },
  image: { type: String },
  lateFees: { type: Number, required: true },
  available: [availableSchema],
  reviews: [reviewSchema],
});

var Items = mongoose.model("Item", itemSchema);
module.exports = Items;
