const mongoose = require('mongoose');
const schema = mongoose.Schema;
const passportLocalMongoose = require('passport-local-mongoose');   // importing passport local mongoose

var subsSchema = new schema({
    _id:{
        type: mongoose.Schema.Types.ObjectId,
        ref: "Library"
    }
});

var userSchema = new schema({
    firstname: {
        type: String,
    },
    lastname: {
        type: String,
    },
    facebookId: {
        type: String
    },
    email:{
        type: String,
    },
    profilePhoto:{
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
    subscribedLibraries:[subsSchema]
});

userSchema.plugin(passportLocalMongoose);   // use passport local mongoose to add username and password fields to user schema
// note that the password field can be called when creating a post request 
// for ex: {"username":"cat" , "password": "dkfkdfk"}
// but in the database, the password will be stored in two fields, salt and hash

module.exports = mongoose.model('User' , userSchema);