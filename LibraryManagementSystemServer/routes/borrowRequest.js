var express = require("express");
const bodyParser = require("body-parser");
const User = require("../models/usersSchema");
const Transaction = require("../models/transactionSchema");
const BorrowRequest = require("../models/physicalBorrowRequestSchema");
const Item = require("../models/itemSchema");
const Library = require("../models/librarySchema");
const cors = require("./cors");
const authenticate = require("../authenticate");
const config = require("../config");
const { correctPath } = require("../photo_correction");

var borrowRequestRouter = express.Router();
borrowRequestRouter.use(bodyParser.json());

// user request to borrow item
borrowRequestRouter.post(
  "/request/:libraryId/:itemId",
  cors.corsWithOptions,
  authenticate.verifyUser,
  authenticate.verifyMember,
  (req, res, next) => {
    BorrowRequest.find({ user: req.user._id, borrowed: false })
      .then((userRequests) => {
        // limit check
        if (userRequests.length < config.maxNumOfBorrowings) {
          Transaction.find({ user: req.user._id, returned: false })
            .then((userTransactions) => {
              var canBorrow = true;
              if (userTransactions) {
                var date = new Date();
                userTransactions.forEach((transaction) => {
                  if (transaction.deadline < date) {
                    canBorrow = false;
                  }
                });
              }
              if (canBorrow) {
                // check user limits
                if (
                  userTransactions.length <
                  config.maxNumOfBorrowings - userRequests.length
                ) {
                  User.findById(req.user._id)
                    .then((user) => {
                      if (user.canBorrowItems == true) {
                        Item.findById(req.params.itemId)
                          .then((item) => {
                            // if item is available
                            if (
                              item.available.id(req.params.libraryId).amount !=
                              0
                            ) {
                              // if item is physical
                              if (
                                item.type == "book" ||
                                item.type == "audioMaterial" ||
                                item.type == "magazine"
                              ) {
                                var date = new Date();
                                date.setDate(date.getDate() + 2);
                                BorrowRequest.create({
                                  user: req.user._id,
                                  library: req.params.libraryId,
                                  item: req.params.itemId,
                                  deadline: date,
                                })
                                  .then(() => {
                                    res.statusCode = 200;
                                    res.setHeader(
                                      "Content-Type",
                                      "application/json"
                                    );
                                    res.json({
                                      success: true,
                                      status: "Requested Successfully",
                                    });
                                  })
                                  .then(() => {
                                    item.available.id(
                                      req.params.libraryId
                                    ).amount -= 1;
                                    item.save().catch((err) => {
                                    });
                                  })
                                  .catch((err) => {
                                    res.statusCode = 500;
                                    res.setHeader(
                                      "Content-Type",
                                      "application/json"
                                    );
                                    res.json({
                                      success: false,
                                      status: "Request Failed",
                                      err: err,
                                    });
                                  });
                              }
                              // if item is not physical
                              else {
                                var date = new Date();
                                date.setDate(date.getDate() + config.duration);
                                Transaction.create({
                                  user: req.user._id,
                                  item: req.params.itemId,
                                  lateFees: item.available.id(
                                    req.params.libraryId
                                  ).lateFees,
                                  borrowedFrom: req.params.libraryId,
                                  deadline: date,
                                  returned: false,
                                  requestedToReturn: false,
                                })
                                  .then((transaction) => {
                                    if (transaction) {
                                      res.statusCode = 200;
                                      res.setHeader(
                                        "Content-Type",
                                        "application/json"
                                      );
                                      res.json({
                                        success: true,
                                        status: "Borrowed Successfully",
                                        item: item._id,
                                      });
                                    } else {
                                      res.statusCode = 500;
                                      res.setHeader(
                                        "Content-Type",
                                        "application/json"
                                      );
                                      res.json({
                                        success: false,
                                        status: "Request Failed",
                                      });
                                    }
                                  })
                                  .catch((err) => {
                                    res.statusCode = 500;
                                    res.setHeader(
                                      "Content-Type",
                                      "application/json"
                                    );
                                    res.json({
                                      success: false,
                                      status: "Request Failed",
                                      err: err,
                                    });
                                  });
                              }
                            } else {
                              res.statusCode = 500;
                              res.setHeader("Content-Type", "application/json");
                              res.json({
                                success: false,
                                status: "Request Failed",
                                err: "Item Not Found In This Library",
                              });
                            }
                          })
                          .catch((err) => {
                            res.statusCode = 500;
                            res.setHeader("Content-Type", "application/json");
                            res.json({
                              success: false,
                              status: "Request Failed",
                              err: err,
                            });
                          });
                      } else {
                        res.statusCode = 403;
                        res.setHeader("Content-Type", "application/json");
                        res.json({
                          success: false,
                          status: "Request Failed",
                          err: "Can't Borrow",
                        });
                      }
                    })
                    .catch((err) => {
                      res.statusCode = 500;
                      res.setHeader("Content-Type", "application/json");
                      res.json({
                        success: false,
                        status: "Request Failed",
                        err: err,
                      });
                    });
                } else {
                  res.statusCode = 403;
                  res.setHeader("Content-Type", "application/json");
                  res.json({
                    success: false,
                    status: "Request Failed",
                    err: "Limit Reached",
                  });
                }
              } else {
                res.statusCode = 403;
                res.setHeader("Content-Type", "application/json");
                res.json({
                  success: false,
                  status: "Request Failed",
                  err: "Non Returned Items",
                });
              }
            })
            .catch((err) => {
              res.statusCode = 500;
              res.setHeader("Content-Type", "application/json");
              res.json({
                success: false,
                status: "Request Failed",
                err: err,
              });
            });
        } else {
          res.statusCode = 403;
          res.setHeader("Content-Type", "application/json");
          res.json({
            success: false,
            status: "Request Failed",
            err: "Limit Reached",
          });
        }
      })
      .catch((err) => {
        res.statusCode = 500;
        res.setHeader("Content-Type", "application/json");
        res.json({
          success: false,
          status: "Request Failed",
          err: err,
        });
      });
  }
);

// librarian get all requests
borrowRequestRouter.get(
  "/libraryRequests/:libraryId",
  cors.corsWithOptions,
  authenticate.verifyUser,
  authenticate.verifyLibrarian,
  (req, res, next) => {
    BorrowRequest.find({})
      .where("library", req.params.libraryId)
      .where("borrowed", false)
      .populate("user")
      .populate("item")
      .populate("library")
      .then((requests) => {
        for (var i in requests) {
          requests[i].item = {
            _id: requests[i].item._id,
            name: requests[i].item.name,
            image: requests[i].item.available.id(req.params.libraryId).image,
          };
          requests[i].user = {
            _id: requests[i].user._id,
            firstname: requests[i].user.firstname,
            lastname: requests[i].user.lastname,
            profilePhoto: requests[i].user.profilePhoto,
            phoneNumber: requests[i].user.phoneNumber,
            username: requests[i].user.username,
          };
          requests[i].library = { _id: requests[i].library._id };
        }
        res.statusCode = 200;
        res.setHeader("Content-Type", "application/json");
        res.json({ success: true, requests: requests });
      })
      .catch((err) => {
        res.statusCode = 500;
        res.setHeader("Content-Type", "application/json");
        res.json({
          success: false,
          status: "Request Failed",
          err: err,
        });
      });
  }
);

// librarian accepts requests
borrowRequestRouter.put(
  "/accept/:libraryId/:requestId",
  cors.corsWithOptions,
  authenticate.verifyUser,
  authenticate.verifyLibrarian,
  (req, res, next) => {
    BorrowRequest.findById(req.params.requestId)
      .then((request) => {
        request.borrowed = true;
        request.save().then((request) => {
          Item.findById(request.item).then((item) => {
            // add transaction
            var date = new Date();
            date.setDate(date.getDate() + config.duration);
            Transaction.create({
              user: request.user,
              item: request.item,
              lateFees: item.available.id(req.params.libraryId).lateFees,
              borrowedFrom: req.params.libraryId,
              deadline: date,
              returned: false,
              requestedToReturn: false,
            }).then((transaction) => {
              res.statusCode = 200;
              res.setHeader("Content-Type", "application/json");
              res.json({
                success: true,
                status: "Accepted Successfully",
              });
            });
          });
        });
      })
      .catch((err) => {
        res.statusCode = 500;
        res.setHeader("Content-Type", "application/json");
        res.json({
          success: false,
          status: "Request Failed",
          err: err,
        });
      });
  }
);

// User get all of his bending requests
borrowRequestRouter.get(
  "/myRequests",
  cors.corsWithOptions,
  authenticate.verifyUser,
  (req, res, next) => {
    BorrowRequest.find({ user: req.user._id, borrowed: false })
      .populate("item")
      .populate("library")
      .populate("user")
      .then((requests) => {
        for (var i in requests) {
          requests[i].library = { _id: requests[i].library._id };
          requests[i].item = {
            _id: requests[i].item._id,
            image: requests[i].item.available.id(requests[i].library._id).image,
          };
          requests[i].user = { _id: requests[i].user._id };
        }
        res.statusCode = 200;
        res.setHeader("Content-Type", "application/json");
        res.json({ success: true, requests: requests });
      })
      .catch((err) => {
        res.statusCode = 500;
        res.setHeader("Content-Type", "application/json");
        res.json({
          success: false,
          status: "Request Failed",
          err: err,
        });
      });
  }
);

module.exports = borrowRequestRouter;
