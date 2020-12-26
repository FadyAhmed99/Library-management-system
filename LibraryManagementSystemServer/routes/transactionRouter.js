var express = require("express");
const bodyParser = require("body-parser");
const User = require("../models/usersSchema");
const BorrowRequest = require("../models/physicalBorrowRequestSchema");
const cors = require("./cors");
const authenticate = require("../authenticate");
const Transaction = require("../models/transactionSchema");
const Item = require("../models/itemSchema");
const Fee = require("../models/feeSchema");
const Library = require("../models/librarySchema");
const { ObjectID } = require("mongodb");

var transactionRouter = express.Router();
transactionRouter.use(bodyParser.json());

// user get all of his transactions
transactionRouter.get(
  "/myTransactions",
  cors.corsWithOptions,
  authenticate.verifyUser,
  (req, res, next) => {
    if (req.query.requestedToReturn == "null") {
      filter = { user: req.user._id };
    } else {
      filter = {
        user: req.user._id,
        requestedToReturn: req.query.requestedToReturn,
      };
    }
    Transaction.find(filter)
      .populate("item")
      .populate("borrowedFrom")
      .populate("user")
      .then((transactions) => {
        for (var i in transactions) {
          transactions[i].item = {
            _id: transactions[i].item.name,
            image: transactions[i].item.image,
            name: transactions[i].item.name,
          };
          transactions[i].user = null;
        }

        res.statusCode = 200;
        res.setHeader("Content-Type", "application/json");
        res.json({ success: true, transactions: transactions });
      })
      .catch((err) => {
        res.statusCode = 500;
        res.setHeader("Content-Type", "application/json");
        res.json({
          success: false,
          status: "Process Failed",
          err: err,
        });
      });
  }
);

// user get exact transactions
transactionRouter.get(
  "/transaction/:transactionId",
  cors.corsWithOptions,
  authenticate.verifyUser,
  (req, res, next) => {
    Transaction.findOne({ _id: req.params.transactionId })
      .populate("item")
      .populate("borrowedFrom")
      .then((transaction) => {
        console.log(transaction);
        var modTransaction;
        modTransaction = {
          item: {
            _id: transaction.item._id,
            name: transaction.item.name,
            author: transaction.item.author,
            image: transaction.item.image,
          },
          borrowedFrom: {
            _id: transaction.borrowedFrom._id,
            name: transaction.borrowedFrom.name,
          },
          borrowDate: transaction.createdAt,
          deadline: transaction.deadline,
          lateFees: transaction.lateFees,
          requestedToReturn: transaction.requestedToReturn,
          returned: transaction.returned,
          _id: transaction._id,
        };
        res.statusCode = 200;
        res.setHeader("Content-Type", "application/json");
        res.json({ success: true, transaction: modTransaction });
      })
      .catch((err) => {
        res.statusCode = 500;
        res.setHeader("Content-Type", "application/json");
        res.json({
          success: false,
          status: "Process Failed",
          err: err,
        });
      });
  }
);

// user get all borrowed items
transactionRouter.get(
  "/borrowed",
  cors.corsWithOptions,
  authenticate.verifyUser,
  (req, res, next) => {
    var items = [];
    Transaction.find({
      user: req.user._id,
      returned: false,
      requestedToReturn: false,
    })
      .populate("item")
      .then((transactions) => {
        if (transactions.length > 0) {
          transactions.forEach((transaction) => {
            transaction.item.available.forEach((library) => {
              if (library._id.equals(transaction.borrowedFrom)) {
                transaction.item.available = library;
              }
            });
          });
          for (var i = 0; i < transactions.length; i++) {
            items.push({
              _id: transactions[i]._id,
              item: {
                type: transactions[i].item.type,
                name: transactions[i].item.name,
                _id: transactions[i].item._id,
                image: transactions[i].item.available[0].image,
                itemLink: transactions[i].hasFees
                  ? ""
                  : transactions[i].item.available[0].itemLink,
              },
            });
          }
        }

        res.statusCode = 200;
        res.setHeader("Content-Type", "application/json");
        res.json({ success: true, borrowedItems: items });
      })
      .catch((err) => {
        res.statusCode = 500;
        res.setHeader("Content-Type", "application/json");
        res.json({
          success: false,
          status: "Process Failed",
          err: err,
        });
      });
  }
);

// admins get all transactions
transactionRouter.get(
  "/allTransactions",
  cors.corsWithOptions,
  authenticate.verifyUser,
  authenticate.verifyAdmin,
  (req, res, next) => {
    Transaction.find({})
      .then((transactions) => {
        res.statusCode = 200;
        res.setHeader("Content-Type", "application/json");
        res.json({ success: true, transactions: transactions });
      })
      .catch((err) => {
        res.statusCode = 500;
        res.setHeader("Content-Type", "application/json");
        res.json({
          success: false,
          status: "Process Failed",
          err: err,
        });
      });
  }
);

// user request to return
transactionRouter.put(
  "/requestToReturn/:transactionId",
  cors.corsWithOptions,
  authenticate.verifyUser,
  (req, res, next) => {
    var date = new Date();
    Transaction.findById(req.params.transactionId)
      .then((transaction) => {
        Item.findById(transaction.item).then((item) => {
          if (
            item.type == "book" ||
            item.type == "audioMaterial" ||
            item.type == "magazine"
          ) {
            if (
              item.available.id(transaction.borrowedFrom).lateFees / 100 ==
              0
            ) {
              transaction.requestedToReturn = true;
              transaction.returned = false;
              transaction.hasFees = false;

              transaction.save().then((transaction) => {
                res.statusCode = 200;
                res.setHeader("Content-Type", "application/json");
                res.json({
                  success: true,
                  status: "Transaction Requested To Return",
                });
              });
            } else {
              transaction.requestedToReturn = true;
              if (transaction.deadline < date) {
                transaction.hasFees = true;
              } else {
                transaction.hasFees = false;
              }
              transaction.returned = false;

              transaction.save().then((transaction) => {
                res.statusCode = 200;
                res.setHeader("Content-Type", "application/json");
                res.json({
                  success: true,
                  status: "Transaction Requested To Return",
                });
              });
            }
          } else {
            if (
              item.available.id(transaction.borrowedFrom).lateFees / 100 ==
              0
            ) {
              transaction.requestedToReturn = true;
              transaction.hasFees = false;
              transaction.returned = true;

              transaction.save().then((transaction) => {
                res.statusCode = 200;
                res.setHeader("Content-Type", "application/json");
                res.json({
                  success: true,
                  status: "Transaction Returned",
                });
              });
            } else {
              transaction.requestedToReturn = true;
              transaction.returnDate = date;
              if (transaction.deadline < date) {
                transaction.hasFees = true;
                const date1 = new Date();
                const date2 = transaction.deadline;
                const diffTime = Math.abs(date2 - date1);
                const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
                Fee.create({
                  transactionId: transaction._id,
                  user: req.user._id,
                  item: item,
                  paid: false,
                  fees:
                    item.available.id(transaction.borrowedFrom).lateFees *
                    diffDays,
                })
                  .then((fee) => {
                    User.findByIdAndUpdate(
                      { _id: req.user._id },
                      { $set: { canBorrowItems: false } }
                    )
                      .then(() => {
                        res.statusCode = 200;
                        res.setHeader("Content-Type", "application/json");
                        res.json({
                          success: true,
                          status: "Transaction Returned",
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
                transaction.hasFees = false;
              }
              transaction.returned = true;

              transaction.save().then((transaction) => {
                res.statusCode = 200;
                res.setHeader("Content-Type", "application/json");
                res.json({
                  success: true,
                  status: "Transaction Requested To Return Successfully",
                });
              });
            }
          }
        });
      })
      .catch((err) => {
        res.statusCode = 500;
        res.setHeader("Content-Type", "application/json");
        res.json({
          success: false,
          status: "Process Failed",
          err: err,
        });
      });
  }
);

// librarian get all non-returned transactions
transactionRouter.get(
  "/allTransactions/nonReturned",
  cors.corsWithOptions,
  authenticate.verifyUser,
  authenticate.verifyAdmin,
  (req, res, next) => {
    Transaction.find({
      returned: false,
      // hasFees: req.query.hasFees,
    })
      .then((transactions) => {
        res.statusCode = 200;
        res.setHeader("Content-Type", "application/json");
        res.json({ success: true, transactions: transactions });
      })
      .catch((err) => {
        res.statusCode = 500;
        res.setHeader("Content-Type", "application/json");
        res.json({
          success: false,
          status: "Process Failed",
          err: err,
        });
      });
  }
);

// librarian get all requested to return transactions
transactionRouter.get(
  "/allTransactions/requestedToReturn",
  cors.corsWithOptions,
  authenticate.verifyUser,
  authenticate.verifyAdmin,
  (req, res, next) => {
    Transaction.find({
      requestedToReturn: true,
      returned: false,
    })
      .populate("user")
      .populate("item")
      .then((transactions) => {
        var newTransactions = [];
        for (var i in transactions) {
          newTransactions[i] = {
            user: {
              firstname: transactions[i].user.firstname,
              lastname: transactions[i].user.lastname,
              profilePhoto: transactions[i].user.profilePhoto,
              phoneNumber: transactions[i].user.phoneNumber,
              _id: transactions[i].user._id,
              username: transactions[i].user.username,
            },
            item: {
              _id: transactions[i].item._id,
              name: transactions[i].item.name,
            },
            deadline: transactions[i].deadline,
            _id: transactions[i]._id,
          };
        }
        res.statusCode = 200;
        res.setHeader("Content-Type", "application/json");
        res.json({ success: true, transactions: newTransactions });
      })
      .catch((err) => {
        res.statusCode = 500;
        res.setHeader("Content-Type", "application/json");
        res.json({
          success: false,
          status: "Process Failed",
          err: err,
        });
      });
  }
);

// librarian return excact transaction
transactionRouter.put(
  "/recive/:transactionId",
  cors.corsWithOptions,
  authenticate.verifyUser,
  authenticate.verifyAdmin,
  (req, res, next) => {
    Transaction.findById(req.params.transactionId)
      .then((transaction) => {
        transaction.returned = true;
        Library.findOne({ librarian: req.user._id })
          .then((library) => {
            transaction.returnedTo = ObjectID(library._id);
            var date = new Date();
            transaction.returnDate = date;

            console.log(library._id);
            Item.findById(transaction.item).then((item) => {
              // item amount +1
              item.available.id(library._id).amount += 1;
              console.log("item");
              item
                .save()
                .then(() => {
                  if (transaction.deadline < date) {
                    Item.findById(transaction.item)
                      .then((item) => {
                        const date1 = new Date();
                        const date2 = transaction.deadline;
                        const diffTime = Math.abs(date2 - date1);
                        const diffDays = Math.floor(
                          diffTime / (1000 * 60 * 60 * 24)
                        );
                        // create fee on user
                        Fee.create({
                          transactionId: transaction._id,
                          user: req.user._id,
                          item: item._id,
                          paid: false,
                          fees:
                            item.available.id(transaction.borrowedFrom)
                              .lateFees * diffDays,
                        }).then((fee) => {
                          transaction
                            .save()
                            .then((fee) => {
                              User.findByIdAndUpdate(
                                { _id: req.user._id },
                                { $set: { canBorrowItems: false } }
                              );
                            })
                            .then(() => {
                              res.statusCode = 200;
                              res.setHeader("Content-Type", "application/json");
                              res.json({
                                success: true,
                                status: "Transaction Returned",
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
                  } else {
                    transaction
                      .save()
                      .then(() => {
                        res.statusCode = 200;
                        res.setHeader("Content-Type", "application/json");
                        res.json({
                          success: true,
                          status: "Transaction Returned",
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

module.exports = transactionRouter;
