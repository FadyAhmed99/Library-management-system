const mongoose = require('mongoose');
const schema = mongoose.Schema;
const passportLocalMongoose = require('passport-local-mongoose');   // importing passport local mongoose

var subsSchema = new schema({
    _id:{
        type: mongoose.Schema.Types.ObjectId,
        ref: "Library"
    },
    member:{
        type: Boolean,
        default: false
    }
});

var favoritesSchema = new schema({
    _id:{
        type: mongoose.Schema.Types.ObjectId,
        ref: "Item"
    },
    library:{
        type: mongoose.Schema.Types.ObjectId,
        ref: "Library"
    }
});

var userSchema = new schema({
    firstname: {
        type: String,
        default: ''
    },
    lastname: {
        type: String,
        default: ''
    },
    facebookId: {
        type: String
    },
    email:{
        type: String,
        default: ''
    },
    profilePhoto:{
        type: String,
        default: ''
    },
    profilePhotoPublicId:{
        type: String,
        default: ''
    },
    phoneNumber:{
        type: String,
        default: ''
    },
    librarian:{
        type: Boolean,
        default: false
    },
    canBorrowItems: { 
        type: Boolean, 
        default: true 
    },
    canEvaluateItems: { 
        type: Boolean, 
        default: true 
    },
    subscribedLibraries:[subsSchema],
    favorites:[favoritesSchema]
});

userSchema.plugin(passportLocalMongoose);   // use passport local mongoose to add username and password fields to user schema
// note that the password field can be called when creating a post request 
// for ex: {"username":"cat" , "password": "dkfkdfk"}
// but in the database, the password will be stored in two fields, salt and hash

module.exports = mongoose.model('User' , userSchema);