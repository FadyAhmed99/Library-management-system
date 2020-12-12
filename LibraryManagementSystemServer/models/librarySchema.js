const mongoose = require("mongoose");
const schema = mongoose.Schema;

const feedbackSchema = new schema({
  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User", // specify the model
  },
  feedback: { 
    type: String, 
    default: ''
  }
});

const librarySchema = new schema({
  name: { 
    type: String, 
    required: true 
  },
  address: { 
    type: String, 
    default: '' 
  },
  description: { 
    type: String,
    default: '' 
  },
  phoneNumber: {
     type: String,
     default: ''
    },
  image: {
     type: String,
     default: ''
    },
  librarian: {
     type: mongoose.Schema.Types.ObjectId, 
     ref: "User" 
    },
  feedback: [feedbackSchema],
});

var Libraries = mongoose.model("Library", librarySchema);
module.exports = Libraries;
