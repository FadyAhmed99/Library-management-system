const mongoose = require("mongoose");
const schema = mongoose.Schema;

const itemSchema = new schema({
  _id: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Item",
  },
});

const favoriteSchema = new schema({
    _id: { type: mongoose.Schema.Types.ObjectId, ref: "User",
           required: true
    },
    items: [itemSchema],
});

var Favorites = mongoose.model("Favorite", favoriteSchema);
module.exports = Favorites;
