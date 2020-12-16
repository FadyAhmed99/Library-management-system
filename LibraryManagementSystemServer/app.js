// 16 Dec 2:47 AM  3rd
var createError = require("http-errors");
var express = require("express");
var path = require("path");
var cookieParser = require("cookie-parser");
var logger = require("morgan");
var multer = require("multer");
var Mongoose = require("mongoose");
const cron = require("node-cron");

//importing passport  "Me"
var passport = require("passport");
var passportLocal = require("passport-local");
var passportLocalMongoose = require("passport-local-mongoose");
var passportJWT = require("passport-jwt");
var passportFacebook = require("passport-facebook-token");

// Importing Important Files  "Me"
var upload = require("./upload");
var authenticate = require("./authenticate");
var config = require("./config");

// Importing Routers   "Me"
const indexRouter = require('./routes/index');
const userRouter = require('./routes/usersRouter');
const libraryRouter = require('./routes/libraryRouter');
const borrowRequest = require("./routes/borrowRequest");


// Connecting to DB server
const url = config.mongoUrl;
const connect = Mongoose.connect(url);

connect
  .then((db) => {
    console.log("Connected Successfully!");
  })

  .catch((err) => {
    console.log(err);
  });

// Initializing Express app
var app = express();

// redirecting any non-secure communications to the secure https server  "Me"
app.all("*", (req, res, next) => {
  if (req.secure) {
    // if the request is over https then req.secure is true
    return next();
  } else {
    res.redirect(
      307,
      "https://" + req.hostname + ":" + app.get("secPort") + req.url
    ); // secPort is defined in /bin/www
    // 307 is a status code regards redirecting
    // hostname is the name of the site which is localhost at our case here
    // url is the path which was desired to go to
    //                       https://hostname:port/url
  }
});



// view engine setup
app.set("views", path.join(__dirname, "views"));
app.set("view engine", "jade");

app.use(logger("dev"));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));

// commented the line below because we don't need it now because we use sessions
// app.use(cookieParser('12345-67890-09876-54321'));   // added a secret key to the cookie parser in order to use signed cookies

// using passport  "Me"
app.use(passport.initialize());

app.use(express.static(path.join(__dirname, "public"))); // I didn't type that line

// Using Routers    "Me"
app.use('/', indexRouter);
app.use('/users', userRouter);
app.use('/libraries', libraryRouter);
app.use('/borrowRequests', borrowRequest);

// catch 404 and forward to error handler
app.use(function (req, res, next) {
  next(createError(404));
});

// error handler
app.use(function (err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get("env") === "development" ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render("error");
});

module.exports = app;
