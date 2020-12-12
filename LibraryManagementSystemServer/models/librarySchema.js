const mongoose = require("mongoose");
const schema = mongoose.Schema;

const feedbackSchema = new schema({
  _id: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User", // specify the model
  },
  feedback: { type: String, required: true },
});

const librarySchema = new schema({
  name: { type: String, required: true },
  adress: { type: String, required: true },
  description: { type: String },
  phoneNumber: { type: String },
  image: { type: String },
  librarian: { type: mongoose.Schema.Types.ObjectId, ref: "User" },
  feedback: [feedbackSchema],
});

var Libraries = mongoose.model("Library", librarySchema);
module.exports = Libraries;
