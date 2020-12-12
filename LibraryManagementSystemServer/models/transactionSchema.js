const { Timestamp } = require("bson");
const mongoose = require("mongoose");
const schema = mongoose.Schema;

const transactionSchema = new schema({
  user: { type: mongoose.Schema.Types.ObjectId, ref: "User", required: true },
  borrowedFrom: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Library",
    required: true,
  },
  item: { type: mongoose.Schema.Types.ObjectId, ref: "Item", required: true },
  deadline: { type: Timestamp },
  returnedTo: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Library",
    required: true,
  },
  returnDate: { type: Timestamp },
  requestedToReturn: { type: Boolean },
  returned: { type: Boolean },
  hasFees: { type: Boolean }, // TODO:check type
});

var Transaction = mongoose.model("Transaction", transactionSchema);
module.exports = Transaction;
