var express = require("express");
const bodyParser = require("body-parser");
const User = require("../models/usersSchema");
const Library = require("../models/librarySchema");
const Item = require("../models/itemSchema");
const Transaction = require("../models/transactionSchema");
const passport = require("passport");
var libraryRouter = express.Router();
libraryRouter.use(bodyParser.json());
const cors = require("./cors");
const multer = require("multer");
const authenticate = require("../authenticate");
const upload = require("../upload");
const { correctPath } = require("../photo_correction");

libraryRouter.options("*", cors.corsWithOptions, (req, res, next) => {
  res.sendStatus(200);
});

libraryRouter
  .route("/")
  .get(cors.corsWithOptions, authenticate.verifyUser, (req, res, next) => {
    Library.find({})
      .then((libs) => {
        if (libs == null) {
          res.statusCode = 500;
          res.setHeader("Content-Type", "application/json");
          res.json({
            success: false,
            status: "Process Failed",
            err: "No Libraries Found",
          });
        } else {
          var librars = [];
          for (var i = 0; i < libs.length; i++) {
            librars.push({
              name: libs[i].name,
              address: libs[i].address,
              description: libs[i].description,
              _id: libs[i]._id,
              phoneNumber: libs[i].phoneNumber,
              image: libs[i].image,
              librarian: libs[i].librarian,
            });
          }
          res.statusCode = 200;
          res.setHeader("Content-Type", "application/json");
          res.json({ success: true, libraries: librars });
        }
      })
      .catch((err = "Server Failed") => {
        res.statusCode = 500;
        res.setHeader("Content-Type", "application/json");
        res.json({ success: false, status: "Process Failed", err: err });
      });
  })
  .post(cors.corsWithOptions, (req, res, next) => {
    res.statusCode = 404;
    res.setHeader("Content-Type", "application/json");
    res.json({ success: false, status: "NOT ALLOWED", err: "Not Found" });
  })
  .put(cors.corsWithOptions, (req, res, next) => {
    res.statusCode = 404;
    res.setHeader("Content-Type", "application/json");
    res.json({ success: false, status: "NOT ALLOWED", err: "Not Found" });
  })
  .delete(cors.corsWithOptions, (req, res, next) => {
    res.statusCode = 404;
    res.setHeader("Content-Type", "application/json");
    res.json({ success: false, status: "NOT ALLOWED", err: "Not Found" });
  });

libraryRouter
  .route("/:libraryId/info")
  .get(cors.corsWithOptions, authenticate.verifyUser, (req, res, next) => {
    Library.findById(req.params.libraryId)
      .populate("librarian")
      .then((library) => {
        if (library == null) {
          res.statusCode = 404;
          res.setHeader("Content-Type", "application/json");
          res.json({
            success: false,
            status: "Process Failed",
            err: "Library Not Found",
          });
        } else {
          var libr = {
            firstname: library.librarian.firstname,
            lastname: library.librarian.lastname,
            email: library.librarian.email,
            profilePhoto: correctPath(library.librarian.profilePhoto,req.hostname),
            phoneNumber: library.librarian.phoneNumber,
            _id: library.librarian._id,
          };
          var lib = {
            name: library.name,
            address: library.address,
            description: library.description,
            phoneNumber: library.phoneNumber,
            image: library.image,
            _id: library._id,
          };
          res.statusCode = 200;
          res.setHeader("Content-Type", "application/json");
          res.json({ success: true, library: lib, librarian: libr });
        }
      })
      .catch((err = "Server Failed") => {
        res.statusCode = 500;
        res.setHeader("Content-Type", "application/json");
        res.json({ success: false, status: "Process Failed", err: err });
      });
  })
  .post(cors.corsWithOptions, (req, res, next) => {
    res.statusCode = 404;
    res.setHeader("Content-Type", "application/json");
    res.json({ success: false, status: "NOT ALLOWED", err: "Not Found" });
  })
  .put(
    cors.corsWithOptions,
    authenticate.verifyUser,
    authenticate.verifyLibrarian,
    (req, res, next) => {
      Library.findById(req.params.libraryId)
        .then((lib) => {
          if (req.body.name) {
            lib.name = req.body.name;
          }
          if (req.body.address) {
            lib.address = req.body.address;
          }
          if (req.body.description) {
            lib.description = req.body.description;
          }
          if (req.body.phoneNumber) {
            lib.phoneNumber = req.body.phoneNumber;
          }
          lib
            .save()
            .then((lib) => {
              var librar = {
                name: lib.name,
                address: lib.address,
                description: lib.description,
                phoneNumber: lib.phoneNumber,
                image: lib.image,
                _id: lib._id,
              };
              res.statusCode = 200;
              res.setHeader("Content-Type", "application/json");
              res.json({ success: true, library: librar });
            })
            .catch((err = "Server Failed") => {
              res.statusCode = 500;
              res.setHeader("Content-Type", "application/json");
              res.json({ success: false, status: "Process Failed", err: err });
            });
        })
        .catch((err = "Server Failed") => {
          res.statusCode = 500;
          res.setHeader("Content-Type", "application/json");
          res.json({ success: false, status: "Process Failed", err: err });
        });
    }
  )
  .delete(cors.corsWithOptions, (req, res, next) => {
    res.statusCode = 404;
    res.setHeader("Content-Type", "application/json");
    res.json({ success: false, status: "NOT ALLOWED", err: "Not Found" });
  });

// Get list of all members of the library or list of all join requests to the library
libraryRouter.get(
  "/:libraryId",
  cors.corsWithOptions,
  authenticate.verifyUser,
  authenticate.verifyLibrarian,
  (req, res, next) => {
    if (req.query.option == "requests") {
      User.find({
        subscribedLibraries: {
          $elemMatch: { _id: req.params.libraryId, member: false },
        },
      })
        .then((requests) => {
          if (requests == null) {
            res.statusCode = 404;
            res.setHeader("Content-Type", "application/json");
            res.json({
              success: false,
              status: "Process Failed",
              err: "Requests Not Found",
            });
          } else {
            var requestArr = [];
            for (var i = 0; i < requests.length; i++) {
              requestArr[i] = {
                firstname: requests[i].firstname,
                lastname: requests[i].lastname,
                _id: requests[i]._id,
                profilePhoto: correctPath(requests[i].profilePhoto,req.hostname),
              };
            }
            res.statusCode = 200;
            res.setHeader("Content-Type", "application/json");
            res.json({ success: true, requests: requestArr });
          }
        })
        .catch((err = "Server Failed") => {
          res.statusCode = 500;
          res.setHeader("Content-Type", "application/json");
          res.json({ success: false, status: "Process Failed", err: err });
        });
    } else if (req.query.option == "members") {
      User.find({
        subscribedLibraries: {
          $elemMatch: { _id: req.params.libraryId, member: true },
        },
      })
        .then((members) => {
          if (members == null) {
            res.statusCode = 404;
            res.setHeader("Content-Type", "application/json");
            res.json({
              success: false,
              status: "Process Failed",
              err: "Members Not Found",
            });
          } else {
            var memberArr = [];
            for (var i = 0; i < members.length; i++) {
              memberArr[i] = {
                firstname: members[i].firstname,
                lastname: members[i].lastname,
                canBorrowItems: members[i].canBorrowItems,
                canEvaluateItems: members[i].canEvaluateItems,
                _id: members[i]._id,
                profilePhoto: correctPath(members[i].profilePhoto,req.hostname),
              };
            }
            res.statusCode = 200;
            res.setHeader("Content-Type", "application/json");
            res.json({ success: true, members: memberArr });
          }
        })
        .catch((err = "Server Failed") => {
          res.statusCode = 500;
          res.setHeader("Content-Type", "application/json");
          res.json({ success: false, status: "Process Failed", err: err });
        });
    } else {
      res.statusCode = 404;
      res.setHeader("Content-Type", "application/json");
      res.json({
        success: false,
        status: "Process Failed",
        err: "Invalid Parameters",
      });
    }
  }
);

// Send a join request to a library
libraryRouter.post(
  "/:libraryId/requests",
  cors.corsWithOptions,
  authenticate.verifyUser,
  authenticate.verifyNotMember,
  (req, res, next) => {
    User.findById(req.user._id)
      .then((user) => {
        user.subscribedLibraries.push({
          _id: req.params.libraryId,
        });
        user
          .save()
          .then((user) => {
            res.statusCode = 200;
            res.setHeader("Content-Type", "application/json");
            res.json({ success: true, status: "Join Request Sent" });
          })
          .catch((err = "Server Failed") => {
            res.statusCode = 500;
            res.setHeader("Content-Type", "application/json");
            res.json({ success: false, status: "Process Failed", err: err });
          });
      })
      .catch((err = "Server Failed") => {
        res.statusCode = 500;
        res.setHeader("Content-Type", "application/json");
        res.json({ success: false, status: "Process Failed", err: err });
      });
  }
);

//  Accept or reject requests   or  delete memebers from the library
libraryRouter.put(
  "/:libraryId/:userId",
  cors.corsWithOptions,
  authenticate.verifyUser,
  authenticate.verifyLibrarian,
  (req, res, next) => {
    User.findById(req.params.userId)
      .then((user) => {
        if (user == null) {
          res.statusCode = 404;
          res.setHeader("Content-Type", "application/json");
          res.json({
            success: false,
            status: "Process Failed",
            err: "User Not Found",
          });
        } else {
          if (req.query.action == "approve") {
            // approve join request
            user.subscribedLibraries.id(req.params.libraryId).member = true;
            user
              .save()
              .then((user) => {
                res.statusCode = 200;
                res.setHeader("Content-Type", "application/json");
                res.json({
                  success: true,
                  status: "Request Approved Successfuly",
                });
              })
              .catch((err = "Server Failed") => {
                res.statusCode = 500;
                res.setHeader("Content-Type", "application/json");
                res.json({
                  success: false,
                  status: "Process Failed",
                  err: err,
                });
              });
          }
          // Reject Incoming Requests or Delete existing memebers
          else if (req.query.action == "reject") {
            // reject join request or delete the user if he is already a memeber
            Transaction.find({
              user: req.params.userId,
              borrowedFrom: req.params.libraryId,
              returned: false,
            })
              .then((tranasctions) => {
                if (tranasctions.length == 0) {
                  user.subscribedLibraries.id(req.params.libraryId).remove();
                  user
                    .save()
                    .then((user) => {
                      res.statusCode = 200;
                      res.setHeader("Content-Type", "application/json");
                      res.json({
                        success: true,
                        status: "User Rejected Successfuly",
                      });
                    })
                    .catch((err = "Server Failed") => {
                      res.statusCode = 500;
                      res.setHeader("Content-Type", "application/json");
                      res.json({
                        success: false,
                        status: "Process Failed",
                        err: err,
                      });
                    });
                } else {
                  res.statusCode = 403;
                  res.setHeader("Content-Type", "application/json");
                  res.json({
                    success: false,
                    status: "Process Failed",
                    err: "User has non-returned items",
                  });
                }
              })
              .catch((err = "Server Failed") => {
                res.statusCode = 500;
                res.setHeader("Content-Type", "application/json");
                res.json({
                  success: false,
                  status: "Process Failed",
                  err: err,
                });
              });
          } else {
            res.statusCode = 404;
            res.setHeader("Content-Type", "application/json");
            res.json({
              success: false,
              status: "Process Failed",
              err: "Invalid Parameters",
            });
          }
        }
      })
      .catch((err = "Server Failed") => {
        res.statusCode = 500;
        res.setHeader("Content-Type", "application/json");
        res.json({ success: false, status: "Process Failed", err: err });
      });
  }
);

// Send feedback to the library
libraryRouter
  .route("/:libraryId/feedback")
  .post(
    cors.corsWithOptions,
    authenticate.verifyUser,
    authenticate.verifyMember,
    (req, res, next) => {
      Library.findById(req.params.libraryId)
        .then((library) => {
          if (library == null) {
            res.statusCode = 404;
            res.setHeader("Content-Type", "application/json");
            res.json({
              success: false,
              status: "Process Failed",
              err: "Library Not Found",
            });
          } else {
            library.feedback.push({
              user: req.user._id,
              feedback: req.body.feedback,
            });
            library
              .save()
              .then((lib) => {
                res.statusCode = 200;
                res.setHeader("Content-Type", "application/json");
                res.json({
                  success: true,
                  status: "Feedback Sent Successfully",
                });
              })
              .catch((err = "Server Failed") => {
                res.statusCode = 500;
                res.setHeader("Content-Type", "application/json");
                res.json({
                  success: false,
                  status: "Process Failed",
                  err: err,
                });
              });
          }
        })
        .catch((err = "Server Failed") => {
          res.statusCode = 500;
          res.setHeader("Content-Type", "application/json");
          res.json({ success: false, status: "Process Failed", err: err });
        });
    }
  )
  // view library feedbacks
  .get(cors.corsWithOptions, authenticate.verifyUser, (req, res, next) => {
    Library.findById(req.params.libraryId)
      .populate("feedback.user")
      .then((library) => {
        if (library == null) {
          res.statusCode = 404;
          res.setHeader("Content-Type", "application/json");
          res.json({
            success: false,
            status: "Process Failed",
            err: "Library Not Found",
          });
        } else {
          var feedbacks = [];
          for (var i = 0; i < library.feedback.length; i++) {
            feedbacks.push({
              firstname: library.feedback[i].user.firstname,
              lastname: library.feedback[i].user.lastname,
              profilePhoto: correctPath(library.feedback[i].user.profilePhoto,req.hostname),
              userId: library.feedback[i].user._id,
              feedback: library.feedback[i].feedback,
            });
          }
          res.statusCode = 200;
          res.setHeader("Content-Type", "application/json");
          res.json({ success: true, feedbacks: feedbacks });
        }
      })
      .catch((err = "Server Failed") => {
        res.statusCode = 500;
        res.setHeader("Content-Type", "application/json");
        res.json({ success: false, status: "Process Failed", err: err });
      });
  });

// Get all blocked users from something in your library
libraryRouter.get(
  "/:libraryId/permissions/get",
  cors.corsWithOptions,
  authenticate.verifyUser,
  authenticate.verifyLibrarian,
  (req, res, next) => {
    if (req.query.blockedFrom == "borrowing") {
      User.find({
        canBorrowItems: false,
        subscribedLibraries: {
          $elemMatch: { _id: req.params.libraryId, member: true },
        },
      })
        .then((users) => {
          var bUsers = [];
          for (var i = 0; i < users.length; i++) {
            bUsers.push({
              firstname: users[i].firstname,
              lastname: users[i].lastname,
              profilePhoto: correctPath(users[i].profilePhoto,req.hostname),
              canBorrowItems: users[i].canBorrowItems,
              canEvaluateItems: users[i].canEvaluateItems,
              _id: users[i]._id,
            });
          }
          res.statusCode = 200;
          res.setHeader("Content-Type", "application/json");
          res.json({ success: true, blockedUsers: bUsers });
        })
        .catch((err = "Server Failed") => {
          res.statusCode = 500;
          res.setHeader("Content-Type", "application/json");
          res.json({ success: false, status: "Process Failed", err: err });
        });
    } else if (req.query.blockedFrom == "evaluating") {
      User.find({
        canEvaluateItems: false,
        subscribedLibraries: {
          $elemMatch: { _id: req.params.libraryId, member: true },
        },
      })
        .then((users) => {
          var bUsers = [];
          for (var i = 0; i < users.length; i++) {
            bUsers.push({
              firstname: users[i].firstname,
              lastname: users[i].lastname,
              profilePhoto: correctPath(users[i].profilePhoto,req.hostname),
              canBorrowItems: users[i].canBorrowItems,
              canEvaluateItems: users[i].canEvaluateItems,
              _id: users[i]._id,
            });
          }
          res.statusCode = 200;
          res.setHeader("Content-Type", "application/json");
          res.json({ success: true, blockedUsers: bUsers });
        })
        .catch((err = "Server Failed") => {
          res.statusCode = 500;
          res.setHeader("Content-Type", "application/json");
          res.json({ success: false, status: "Process Failed", err: err });
        });
    } else {
      res.statusCode = 404;
      res.setHeader("Content-Type", "application/json");
      res.json({
        success: false,
        status: "Process Failed",
        err: "Invalid Parameters",
      });
    }
  }
);

// set permissions to a certain user in the library
libraryRouter.put(
  "/:libraryId/permissions/:userId/set",
  cors.corsWithOptions,
  authenticate.verifyUser,
  authenticate.verifyLibrarian,
  authenticate.verifyMemberToLibrary,
  (req, res, next) => {
    User.findById(req.params.userId)
      .then((user) => {
        if (user == null) {
          res.statusCode = 500;
          res.setHeader("Content-Type", "application/json");
          res.json({
            success: false,
            status: "Process Failed",
            err: "User Not Found",
          });
        } else if (user.librarian) {
          res.statusCode = 403;
          res.setHeader("Content-Type", "application/json");
          res.json({
            success: false,
            status: "Process Failed",
            err: "You Can't Set Permissions For Admins",
          });
        } else if (
          (req.query.action == "block" || req.query.action == "unblock") &&
          (req.query.from == "evaluating" || req.query.from == "borrowing")
        ) {
          if (req.query.action == "block") {
            if (req.query.from == "borrowing") {
              user.canBorrowItems = false;
              user
                .save()
                .then((user) => {
                  var sUser = {
                    firstname: user.firstname,
                    lastname: user.lastname,
                    profilePhoto: user.profilePhoto,
                    canBorrowItems: user.canBorrowItems,
                    canEvaluateItems: user.canEvaluateItems,
                    _id: user._id,
                  };
                  res.statusCode = 200;
                  res.setHeader("Content-Type", "application/json");
                  res.json({ success: true, user: sUser });
                })
                .catch((err = "Server Failed") => {
                  res.statusCode = 500;
                  res.setHeader("Content-Type", "application/json");
                  res.json({
                    success: false,
                    status: "Process Failed",
                    err: err,
                  });
                });
            } else if (req.query.from == "evaluating") {
              user.canEvaluateItems = false;
              user
                .save()
                .then((user) => {
                  var sUser = {
                    firstname: user.firstname,
                    lastname: user.lastname,
                    profilePhoto: user.profilePhoto,
                    canBorrowItems: user.canBorrowItems,
                    canEvaluateItems: user.canEvaluateItems,
                    _id: user._id,
                  };
                  res.statusCode = 200;
                  res.setHeader("Content-Type", "application/json");
                  res.json({ success: true, user: sUser });
                })
                .catch((err = "Server Failed") => {
                  res.statusCode = 500;
                  res.setHeader("Content-Type", "application/json");
                  res.json({
                    success: false,
                    status: "Process Failed",
                    err: err,
                  });
                });
            }
          } else if (req.query.action == "unblock") {
            if (req.query.from == "borrowing") {
              user.canBorrowItems = true;
              user
                .save()
                .then((user) => {
                  var sUser = {
                    firstname: user.firstname,
                    lastname: user.lastname,
                    profilePhoto: user.profilePhoto,
                    canBorrowItems: user.canBorrowItems,
                    canEvaluateItems: user.canEvaluateItems,
                    _id: user._id,
                  };
                  res.statusCode = 200;
                  res.setHeader("Content-Type", "application/json");
                  res.json({ success: true, user: sUser });
                })
                .catch((err = "Server Failed") => {
                  res.statusCode = 500;
                  res.setHeader("Content-Type", "application/json");
                  res.json({
                    success: false,
                    status: "Process Failed",
                    err: err,
                  });
                });
            } else if (req.query.from == "evaluating") {
              user.canEvaluateItems = true;
              user
                .save()
                .then((user) => {
                  var sUser = {
                    firstname: user.firstname,
                    lastname: user.lastname,
                    profilePhoto: user.profilePhoto,
                    canBorrowItems: user.canBorrowItems,
                    canEvaluateItems: user.canEvaluateItems,
                    _id: user._id,
                  };
                  res.statusCode = 200;
                  res.setHeader("Content-Type", "application/json");
                  res.json({ success: true, user: sUser });
                })
                .catch((err = "Server Failed") => {
                  res.statusCode = 500;
                  res.setHeader("Content-Type", "application/json");
                  res.json({
                    success: false,
                    status: "Process Failed",
                    err: err,
                  });
                });
            }
          }
        } else {
          res.statusCode = 404;
          res.setHeader("Content-Type", "application/json");
          res.json({
            success: false,
            status: "Process Failed",
            err: "Invalid Parameters",
          });
        }
      })
      .catch((err = "Server Failed") => {
        res.statusCode = 500;
        res.setHeader("Content-Type", "application/json");
        res.json({ success: false, status: "Process Failed", err: err });
      });
  }
);

// Working with items
libraryRouter
  .route("/:libraryId/items")
  // Get all items in a certain library "library collection", marking the latest additions
  .get(cors.corsWithOptions, authenticate.verifyUser, (req, res, next) => {
    Item.find({ available: { $elemMatch: { _id: req.params.libraryId } } })
      .then((items) => {
        var itemS = [];
        var dates = [];
        for (var i = 0; i < items.length; i++) {
          dates.push({
            item: i,
            createdAt: items[i].available.id(req.params.libraryId).createdAt,
          });
          itemS.push({
            _id: items[i]._id,
            type: items[i].type,
            genre: items[i].genre,
            name: items[i].name,
            author: items[i].author,
            language: items[i].language,
            ISBN: items[i].ISBN,
            image: items[i].available.id(req.params.libraryId).image,
            inLibrary: items[i].available.id(req.params.libraryId).inLibrary,
            lateFees: items[i].available.id(req.params.libraryId).lateFees,
            location: items[i].available.id(req.params.libraryId).location,
            amount: items[i].available.id(req.params.libraryId).amount,
            isNew: false,
          });
          // calculate averageRating
          var ratings = [];
          for (var j = 0; j < items[i].reviews.length; j++) {
            ratings.push(items[i].reviews[j].rating);
          }
          var avarageRating = 0;
          if (ratings.length > 0) {
            for (var k = 0; k < ratings.length; k++) {
              avarageRating += ratings[k];
            }
            avarageRating = avarageRating / ratings.length;
          }
          itemS[i].averageRating = avarageRating;
        }
        // handling latest items in a certain library
        dates.sort((a, b) => {
          if (a.createdAt < b.createdAt) {
            return 1;
          } else {
            return -1;
          }
        });
        if (dates.length < 5) {
          for (var i = 0; i < dates.length; i++) {
            itemS[dates[i].item].isNew = true;
          }
        } else {
          for (var i = 0; i < 5; i++) {
            itemS[dates[i].item].isNew = true;
          }
        }

        res.statusCode = 200;
        res.setHeader("Content-Type", "application/json");
        res.json({ success: true, num: items.length, items: itemS });
      })
      .catch((err = "Server Failed") => {
        res.statusCode = 500;
        res.setHeader("Content-Type", "application/json");
        res.json({ success: false, status: "Process Failed", err: err });
      });
  })
  // add a new item to a certain library
  .post(
    cors.corsWithOptions,
    authenticate.verifyUser,
    authenticate.verifyLibrarian,
    (req, res, next) => {
      Item.findOne({
        name: req.body.name,
        type: req.body.type,
        genre: req.body.genre,
        author: req.body.author,
        language: req.body.language,
      })
        .then((item) => {
          if (item == null) {
            var newItem = new Item({
              name: req.body.name,
              genre: req.body.genre,
              author: req.body.author,
              type: req.body.type,
              language: req.body.language,
            });
            if (req.body.ISBN) {
              newItem.ISBN = req.body.ISBN;
            }
            newItem.available.push({
              _id: req.params.libraryId,
            });
            if (req.body.inLibrary == true || req.body.inLibrary == false) {
              newItem.available[newItem.available.length - 1].inLibrary =
                req.body.inLibrary;
            }
            if (req.body.lateFees) {
              newItem.available[newItem.available.length - 1].lateFees =
                req.body.lateFees;
            }
            if (req.body.amount) {
              newItem.available[newItem.available.length - 1].amount =
                req.body.amount;
            }
            if (req.body.location) {
              newItem.available[newItem.available.length - 1].location =
                req.body.location;
            }
            if (req.body.image) {
              newItem.available[newItem.available.length - 1].image =
                req.body.image;
            }
            if (req.body.itemLink) {
              newItem.available[newItem.available.length - 1].itemLink =
                req.body.itemLink;
            }
            newItem
              .save()
              .then((newitem) => {
                res.statusCode = 200;
                res.setHeader("Content-Type", "application/json");
                res.json({ success: true, status: "Item Added Successfully" });
              })
              .catch((err = "Server Failed") => {
                res.statusCode = 500;
                res.setHeader("Content-Type", "application/json");
                res.json({
                  success: false,
                  status: "Process Failed",
                  err: err,
                });
              });
          } else {
            if (item.available.id(req.params.libraryId)) {
              res.statusCode = 403;
              res.setHeader("Content-Type", "application/json");
              res.json({
                success: false,
                status: "Process Failed",
                err: "This Item Already Exists In This Library",
              });
            } else {
              item.available.push({ _id: req.params.libraryId });
              if (req.body.inLibrary) {
                item.available[item.available.length - 1].inLibrary =
                  req.body.inLibrary;
              }
              if (req.body.lateFees) {
                item.available[item.available.length - 1].lateFees =
                  req.body.lateFees;
              }
              if (req.body.amount) {
                item.available[item.available.length - 1].amount =
                  req.body.amount;
              }
              if (req.body.location) {
                item.available[item.available.length - 1].location =
                  req.body.location;
              }
              if (req.body.image) {
                item.available[item.available.length - 1].image =
                  req.body.image;
              }
              if (req.body.itemLink) {
                item.available[item.available.length - 1].itemLink =
                  req.body.itemLink;
              }
              item
                .save()
                .then((it) => {
                  res.statusCode = 200;
                  res.setHeader("Content-Type", "application/json");
                  res.json({
                    success: true,
                    status: "Item Added Successfully",
                  });
                })
                .catch((err = "Server Failed") => {
                  res.statusCode = 500;
                  res.setHeader("Content-Type", "application/json");
                  res.json({
                    success: false,
                    status: "Process Failed",
                    err: err,
                  });
                });
            }
          }
        })
        .catch((err = "Server Failed") => {
          res.statusCode = 500;
          res.setHeader("Content-Type", "application/json");
          res.json({ success: false, status: "Process Failed", err: err });
        });
    }
  );

libraryRouter
  .route("/:libraryId/items/:itemId")
  // Get full info of a certain item in a certain library
  .get(cors.corsWithOptions, authenticate.verifyUser, (req, res, next) => {
    Item.findById(req.params.itemId)
      .populate("reviews._id")
      .populate("available._id")
      .then((item) => {
        if (item == null) {
          res.statusCode = 404;
          res.setHeader("Content-Type", "application/json");
          res.json({
            success: false,
            status: "Process Failed",
            err: "Item Not Found",
          });
        } else {
          if (item.available.id(req.params.libraryId)) {
            var itemN = {
              _id: item._id,
              type: item.type,
              genre: item.genre,
              name: item.name,
              author: item.author,
              language: item.language,
              ISBN: item.ISBN,
              image: item.available.id(req.params.libraryId).image,
              inLibrary: item.available.id(req.params.libraryId).inLibrary,
              lateFees: item.available.id(req.params.libraryId).lateFees,
              location: item.available.id(req.params.libraryId).location,
              amount: item.available.id(req.params.libraryId).amount,
            };
            // handling average rating and reviews
            var ratings = [];
            var reviewS = [];
            for (var i = 0; i < item.reviews.length; i++) {
              reviewS.push({
                firstname: item.reviews[i]._id.firstname,
                lastname: item.reviews[i]._id.lastname,
                profilePhoto: correctPath(item.reviews[i]._id.profilePhoto,req.hostname),
                rating: item.reviews[i].rating,
                review: item.reviews[i].review,
              });
              ratings.push(item.reviews[i].rating);
            }
            var averageRating = 0.0;
            if (ratings.length > 0) {
              for (var j = 0; j < ratings.length; j++) {
                averageRating += ratings[j];
              }
              averageRating = averageRating / ratings.length;
            }
            itemN.averageRating = averageRating;
            itemN.reviews = reviewS;

            res.statusCode = 200;
            res.setHeader("Content-Type", "application/json");
            res.json({ success: true, item: itemN });
          } else {
            res.statusCode = 404;
            res.setHeader("Content-Type", "application/json");
            res.json({
              success: false,
              status: "Process Failed",
              err: "Item Not Found In This Library",
            });
          }
        }
      })
      .catch((err = "Server Failed") => {
        res.statusCode = 500;
        res.setHeader("Content-Type", "application/json");
        res.json({ success: false, status: "Process Failed", err: err });
      });
  })
  // Modify the info of a certain item in a certain library
  .put(
    cors.corsWithOptions,
    authenticate.verifyUser,
    authenticate.verifyLibrarian,
    (req, res, next) => {
      Item.findById(req.params.itemId)
        .then((item) => {
          if (item == null) {
            res.statusCode = 404;
            res.setHeader("Content-Type", "application/json");
            res.json({
              success: false,
              status: "Process Failed",
              err: "Item Not Found",
            });
          } else {
            if (item.available.id(req.params.libraryId)) {
              if (req.body.amount) {
                item.available.id(req.params.libraryId).amount =
                  req.body.amount;
              }
              if (req.body.location) {
                item.available.id(req.params.libraryId).location =
                  req.body.location;
              }
              if (req.body.lateFees) {
                item.available.id(req.params.libraryId).lateFees =
                  req.body.lateFees;
              }
              if (req.body.inLibrary == true || req.body.inLibrary == false) {
                item.available.id(req.params.libraryId).inLibrary =
                  req.body.inLibrary;
              }
              if (req.body.image) {
                item.available.id(req.params.libraryId).image = req.body.image;
              }
              if (req.body.itemLink) {
                item.available.id(req.params.libraryId).itemLink =
                  req.body.itemLink;
              }
              item
                .save()
                .then((item) => {
                  var modItem = {
                    _id: item._id,
                    type: item.type,
                    genre: item.genre,
                    name: item.name,
                    author: item.author,
                    language: item.language,
                    ISBN: item.ISBN,
                    image: item.available.id(req.params.libraryId).image,
                    inLibrary: item.available.id(req.params.libraryId)
                      .inLibrary,
                    lateFees: item.available.id(req.params.libraryId).lateFees,
                    location: item.available.id(req.params.libraryId).location,
                    amount: item.available.id(req.params.libraryId).amount,
                  };

                  var ratings = [];
                  var reviewS = [];
                  for (var i = 0; i < item.reviews.length; i++) {
                    reviewS.push({
                      firstname: item.reviews[i]._id.firstname,
                      lastname: item.reviews[i]._id.lastname,
                      profilePhoto: item.reviews[i]._id.profilePhoto,
                      rating: item.reviews[i].rating,
                      review: item.reviews[i].review,
                    });
                    ratings.push(item.reviews[i].rating);
                  }
                  var averageRating = 0;
                  if (ratings.length > 0) {
                    for (var j = 0; j < ratings.length; j++) {
                      averageRating += ratings[j];
                    }
                    averageRating = averageRating / ratings.length;
                  }
                  modItem.averageRating = averageRating;
                  modItem.reviews = reviewS;

                  res.statusCode = 200;
                  res.setHeader("Content-Type", "application/json");
                  res.json({
                    success: true,
                    status: "Item Modified Successfully",
                    modifiedItem: modItem,
                  });
                })
                .catch((err = "Server Failed") => {
                  res.statusCode = 500;
                  res.setHeader("Content-Type", "application/json");
                  res.json({
                    success: false,
                    status: "Process Failed",
                    err: err,
                  });
                });
            } else {
              res.statusCode = 404;
              res.setHeader("Content-Type", "application/json");
              res.json({
                success: false,
                status: "Process Failed",
                err: "Item Not Found In This Library",
              });
            }
          }
        })
        .catch((err = "Server Failed") => {
          res.statusCode = 500;
          res.setHeader("Content-Type", "application/json");
          res.json({ success: false, status: "Process Failed", err: err });
        });
    }
  )
  // Delete a certain item in a certain library
  .delete(
    cors.corsWithOptions,
    authenticate.verifyUser,
    authenticate.verifyLibrarian,
    (req, res, next) => {
      Item.findById(req.params.itemId)
        .then((item) => {
          if (item == null) {
            res.statusCode = 404;
            res.setHeader("Content-Type", "application/json");
            res.json({
              success: false,
              status: "Process Failed",
              err: "Item Not Found",
            });
          } else {
            if (item.available.id(req.params.libraryId)) {
              item.available.id(req.params.libraryId).remove();
              item
                .save()
                .then((item) => {
                  res.statusCode = 200;
                  res.setHeader("Content-Type", "application/json");
                  res.json({
                    success: true,
                    status: "Item Deleted Successfully From This Library",
                  });
                })
                .catch((err = "Server Failed") => {
                  res.statusCode = 500;
                  res.setHeader("Content-Type", "application/json");
                  res.json({
                    success: false,
                    status: "Process Failed",
                    err: err,
                  });
                });
            } else {
              res.statusCode = 404;
              res.setHeader("Content-Type", "application/json");
              res.json({
                success: false,
                status: "Process Failed",
                err: "Item Not Found In This Library",
              });
            }
          }
        })
        .catch((err = "Server Failed") => {
          res.statusCode = 500;
          res.setHeader("Content-Type", "application/json");
          res.json({ success: false, status: "Process Failed", err: err });
        });
    }
  );

// posting reviews
libraryRouter.post(
  "/:libraryId/items/:itemId/reviews",
  cors.corsWithOptions,
  authenticate.verifyUser,
  authenticate.verifyMember,
  authenticate.canThisUserEvaluate,
  (req, res, next) => {
    Item.findById(req.params.itemId)
      .then((item) => {
        if (item == null) {
          res.statusCode = 404;
          res.setHeader("Content-Type", "application/json");
          res.json({
            success: false,
            status: "Process Failed",
            err: "Item Not Found",
          });
        } else {
          if (item.available.id(req.params.libraryId)) {
            item.reviews.push({
              _id: req.user._id,
              rating: req.body.rating,
              review: req.body.review,
            });

            item
              .save()
              .then((item) => {
                res.statusCode = 200;
                res.setHeader("Content-Type", "application/json");
                res.json({
                  success: true,
                  status: "Review Posted Successfully",
                });
              })
              .catch((err = "Server Failed") => {
                res.statusCode = 500;
                res.setHeader("Content-Type", "application/json");
                res.json({
                  success: false,
                  status: "Process Failed",
                  err: err,
                });
              });
          } else {
            res.statusCode = 404;
            res.setHeader("Content-Type", "application/json");
            res.json({
              success: false,
              status: "Process Failed",
              err: "Item Not Found In This Library",
            });
          }
        }
      })
      .catch((err = "Server Failed") => {
        res.statusCode = 500;
        res.setHeader("Content-Type", "application/json");
        res.json({ success: false, status: "Process Failed", err: err });
      });
  }
);

module.exports = libraryRouter;
