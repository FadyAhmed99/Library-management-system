const mongoose = require("mongoose");
const schema = mongoose.Schema;


const physicalBorrowRequestSchema = new schema({
  user: { type: mongoose.Schema.Types.ObjectId,ref:"User", required: true },
  library: { type: mongoose.Schema.Types.ObjectId,ref:"Library", required: true },
  item: { type: mongoose.Schema.Types.ObjectId,ref:"Item", required: true },
    borrowed:{type:Boolean,default:false}
});

var PhysicalBorrowRequests = mongoose.model("BorrowRequest", physicalBorrowRequestSchema);
module.exports = PhysicalBorrowRequests;
