const mongoose = require("mongoose");
const schema = mongoose.Schema;

const requestSchema = new schema({
  user: {
    type: mongoose.Schema.Types.ObjectId, 
    ref: "User"
  },
  library: { 
    type: mongoose.Schema.Types.ObjectId, 
    ref: "Library" 
  },
  approved: { 
    type: String, 
    default: "pending" 
  },
});

var Requests = mongoose.model("Request", requestSchema);
module.exports = Requests;
