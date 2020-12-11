const mongoose = require("mongoose");
const schema = mongoose.Schema;

const permissionSchema = new schema({
  _id: { type: mongoose.Schema.Types.ObjectId, ref: "User", required: true },
  canBorrowItems: { type: Boolean, default: true },
  canEvaluateItems: { type: Boolean, default: true },
});

var Permissions = mongoose.model("Permission", permissionSchema);
module.exports = Permissions;
