const { Timestamp } = require("bson");
const mongoose = require("mongoose");
const schema = mongoose.Schema;

const feeSchema = new schema({
  user: { type: mongoose.Schema.Types.ObjectId, ref: "User", required: true },
  transactionId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Transaction",
    required: true,
  },
  creditCardInfo:{type:String,required:true},
  CCV:{type:Number,required:true},
  item: { type: mongoose.Schema.Types.ObjectId, ref: "Item", required: true },
  fees: { type: Number, required: true },
  paid: { type: Boolean,default:false },
  paymentDate: { type: Timestamp },
});

var Fees = mongoose.model("Fee", feeSchema);
module.exports = Fees;
