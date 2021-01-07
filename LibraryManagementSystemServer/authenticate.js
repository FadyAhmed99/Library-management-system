const passport = require("passport");
const localStrategy = require("passport-local").Strategy;
const User = require("./models/usersSchema");
const Library = require('./models/librarySchema');

// json web tokens
const jwtStrategy = require("passport-jwt").Strategy;
const extractJwt = require("passport-jwt").ExtractJwt;
const jwt = require("jsonwebtoken");
const facebookTokenStrategy = require("passport-facebook-token");
const config = require("./config");

exports.local = passport.use(new localStrategy(User.authenticate()));
// in order to use authenticate, u must use passport-local-mongoose in user schema

passport.serializeUser(User.serializeUser());
passport.deserializeUser(User.deserializeUser());

exports.getToken = (user) => {
  return jwt.sign(user, config.secretKey, { expiresIn: config.jwtDuration }); // token duration 10 hours
};

var opts = {};
opts.jwtFromRequest = extractJwt.fromAuthHeaderAsBearerToken();
opts.secretOrKey = config.secretKey;

exports.jwtPassport = passport.use(
  new jwtStrategy(opts, (jwtPayload, done) => {
    // done is a callback fn with 2 params, err and user
    console.log("jwtPayload: ", jwtPayload);
    User.findOne(
      { _id: jwtPayload._id }, // this is how authentication happens in the jwt strategy
      (err, user) => {
        if (err) {
          return done(err, false);
        } else if (user) {
          return done(null, user);
        } else {
          return done(null, false);
        }
      }
    );
  })
);

exports.verifyUser = (req, res, next) => {
  passport.authenticate("jwt", { session: false }, (err, user, info) => {
    if (err) {
      res.statusCode = 500;
      res.setHeader("Content-Type", "application/json");
      res.json({ success: false, status: "Process Failed", err: err });
    } else if (!user) {
      res.statusCode = 401;
      res.setHeader("Content-Type", "application/json");
      if (
        req.headers.authorization == "" ||
        req.headers.authorization == null
      ) {
        res.json({
          success: false,
          status: "Access Denied",
          err: "No Token Specified",
        });
      } else {
        res.json({ success: false, status: "Access Denied", err: info });
      }
    } else {
      req.logIn(user, (err) => {
        // establish a session
        if (err) {
          res.statusCode = 401;
          res.setHeader("Content-Type", "application/json");
          res.json({
            success: false,
            status: "Access Denied",
            err: "Could not establish a session",
          });
        } else {
          next();
        }
      });
    }
  })(req, res, next);
};

exports.verifyAdmin = (req, res, next) => {
  if (req.user.librarian) {
    return next();
  } else {
    res.statusCode = 403;
    res.setHeader("Content-Type", "application/json");
    res.json({ success: false, status: "Access Denied", err: "Not Admin" });
  }
};

exports.facebookPassport = passport.use(
  new facebookTokenStrategy(
    {
      clientID: config.facebook.clientId,
      clientSecret: config.facebook.clientSecret,
    },
    (accessToken, refreshToken, profile, done) => {
      // done(err,user)
      User.findOne({ facebookId: profile.id }, (err, user) => {
        if (err) {
          return done(err, false);
        }
        if (!err && user !== null) {
          return done(null, user);
        } else {
          user = new User({
            username: profile.displayName,
            facebookId: profile.id,
            firstname: profile.name.givenName,
            lastname: profile.name.familyName,
            email: profile.emails[0].value,
            profilePhoto:
              profile.photos[0].value + "&access_token=" + accessToken,
          });

          user.save((err, user) => {
            if (err) {
              return done(err, false);
            } else {
              return done(null, user);
            }
          });
        }
      });
    }
  )
);

exports.verifyFacebook = (req, res, next) => {
  passport.authenticate("facebook-token", (err, user, info) => {
    if (err) {
      res.statusCode = 500;
      res.setHeader("Content-Type", "application/json");
      res.json({ success: false, status: "Process Failed", err: err });
    } else if (!user) {
      res.statusCode = 401;
      res.setHeader("Content-Type", "application/json");
      res.json({ success: false, status: "Access Denied", err: info });
    } else {
      req.logIn(user, (err) => {
        // establish a session
        if (err) {
          res.statusCode = 401;
          res.setHeader("Content-Type", "application/json");
          res.json({
            success: false,
            status: "Access Denied",
            err: "Could Not Establish A Session",
          });
        } else {
          next();
        }
      });
    }
  })(req, res, next);
};


// verify the current user is librarian for this library
// libraryId must be in request params
exports.verifyLibrarian = (req,res,next)=>{
  Library.findById(req.params.libraryId).then((library)=>{
    if(req.user._id.equals(library.librarian)){
      return next();
    }
    else{
      res.statusCode = 403;
      res.setHeader("Content-Type" , 'application/json');
      res.json({success: false , status: "Access Denied", err: 'You Are Not A Librarian In This Library'});
    }
  }).catch((err="Server Failed")=>{
    res.statusCode = 500;
    res.setHeader("Content-Type" , 'application/json');
    res.json({success: false , status: "Process Failed", err: err});
  })
}


// verify the current user is member for this library
// libraryId must be in request params
exports.verifyMember = (req, res, next) => {
  if (req.user.subscribedLibraries.id(req.params.libraryId)) {
    if(req.user.subscribedLibraries.id(req.params.libraryId).member == true){
      return next();
    }
    else{
      res.statusCode = 403;
      res.setHeader("Content-Type", "application/json");
      res.json({
        success: false,
        status: "Access Denied",
        err: "You Are Not A Member In This Library",
    });
    }
  } 
  else {
    res.statusCode = 403;
    res.setHeader("Content-Type", "application/json");
    res.json({
      success: false,
      status: "Access Denied",
      err: "You Are Not A Member In This Library",
    });
  }
};


exports.verifyNotMember = (req, res, next) => {
  if (!(req.user.subscribedLibraries.id(req.params.libraryId))) {
    return next();
  }
  else if((req.user.subscribedLibraries.id(req.params.libraryId).member == false)){
    res.statusCode = 403;
    res.setHeader("Content-Type", "application/json");
    res.json({
      success: false,
      status: "Request Failed",
      err: "You Have Already Sent A Request To This Library"
  });
   }
  else if(req.user.subscribedLibraries.id(req.params.libraryId).member == true) {
    res.statusCode = 403;
    res.setHeader("Content-Type", "application/json");
    res.json({
      success: false,
      status: "Request Failed",
      err: "You Are Already A Member In This Library"
    });
  }
};

exports.verifyMemberToLibrary = (req,res,next)=>{
  User.findOne({_id: req.params.userId, subscribedLibraries:{$elemMatch:{_id: req.params.libraryId, member: true}}}).then((user)=>{
    if(user == null){
      res.statusCode = 403;
      res.setHeader("Content-Type", "application/json");
      res.json({
        success: false,
        status: "Process Failed",
        err: "This User Is Not In That Library"
      });
    }
    else{
      return next();
      }
  }).catch((err="Server Failed")=>{
      res.statusCode = 500;
      res.setHeader("Content-Type", "application/json");
      res.json({
        success: false,
        status: "Process Failed",
        err: err
      });
  });
};


exports.canThisUserEvaluate = (req,res,next)=>{
  User.findById(req.user._id).then((user)=>{
    if(user == null){
      res.statusCode = 404;
      res.setHeader("Content-Type", "application/json");
      res.json({success: false, status: "Process Failed", err: "User Not Found"});
    }
    else{
      if(user.canEvaluateItems){
        return next();
      }
      else{
        res.statusCode = 403;
        res.setHeader("Content-Type", "application/json");
        res.json({success: false, status: "Process Failed", err: "You Are Blocked From Reviewing Items"});
      }
    }
  }).catch((err="Server Failed")=>{
    res.statusCode = 500;
      res.setHeader("Content-Type", "application/json");
      res.json({
        success: false,
        status: "Process Failed",
        err: err
      });
  });
};