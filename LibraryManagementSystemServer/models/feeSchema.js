const mongoose = require("mongoose");
const schema = mongoose.Schema;

require("mongoose-currency").loadType(mongoose);
const currency = mongoose.Types.Currency;

const feeSchema = new schema({
  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User",
    required: true,
  },
  transactionId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Transaction",
    required: true,
  },
  creditCardInfo: {
    type: String,
    default: "",
  },
  ccv: {
    type: Number,
  },
  item: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Item",
    required: true,
  },
  fees: {
    type: currency,
    min: 0,
    required: true,
  },
  paid: {
    type: Boolean,
    default: false,
  },
  paymentDate: {
    type: Date,
  },
});

var Fees = mongoose.model("Fee", feeSchema);
module.exports = Fees;
