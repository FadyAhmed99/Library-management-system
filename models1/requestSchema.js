const mongoose = require("mongoose");
const schema = mongoose.Schema;

const requestSchema = new schema({
  libraryId: { type: mongoose.Schema.Types.ObjectId, ref: "Library" },
  approved: { type: Boolean, default: false },
});

var Requests = mongoose.model("Request", requestSchema);
module.exports = Requests;
