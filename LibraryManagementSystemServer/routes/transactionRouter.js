var express = require("express");
const bodyParser = require("body-parser");
const User = require("../models/usersSchema");
const BorrowRequest = require("../models/physicalBorrowRequestSchema");
const cors = require("./cors");
const authenticate = require("../authenticate");
const Transaction = require("../models/transactionSchema");
const Item = require("../models/itemSchema");
const Fee = require("../models/feeSchema");
const Fees = require("../models/feeSchema");

var transactionRouter = express.Router();
transactionRouter.use(bodyParser.json());

// user get all of his transactions
transactionRouter.get(
  "/myTransactions",
  cors.corsWithOptions,
  authenticate.verifyUser,
  (req, res, next) => {
    Transaction.find({ user: req.user._id })
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

// librarian get all transactions
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
            if (item.lateFees == 0) {
              transaction.requestedToReturn = true;
              transaction.returned = false;
              transaction.hasFees = false;

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
            if (item.lateFees == 0) {
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
              if (transaction.deadline > date) {
                transaction.hasFees = true;
                const date1 = new Date();
                const date2 = transaction.deadline;
                const diffTime = Math.abs(date2 - date1);
                const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
                Fee.create({
                  transactionId: transaction._id,
                  user: req.user._id,
                  item: item._id,
                  paid: false,
                  fees: (item.lateFees / 100) * diffDays,
                })
                  .then((fee) => {
                    res.statusCode = 200;
                    res.setHeader("Content-Type", "application/json");
                    res.json({ success: true, status: "Transaction Returned" });
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
                  status: "Transaction Requested To Return",
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
      hasFees: req.query.hasFees,
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

// librarian return excact transaction
transactionRouter.put(
  "/accept/:transactionId",
  cors.corsWithOptions,
  authenticate.verifyUser,
  authenticate.verifyAdmin,
  (req, res, next) => {
    Transaction.findById(req.params.transactionId)
      .then((transaction) => {
        transaction.returned = true;
        if (transaction.hasFees) {
          Item.findById(transaction.item)
            .then((item) => {
              const date1 = new Date();
              const date2 = transaction.deadline;
              const diffTime = Math.abs(date2 - date1);
              const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
              Fee.create({
                transactionId: transaction._id,
                user: req.user._id,
                item: item._id,
                paid: false,
                fees: (item.lateFees / 100) * diffDays,
              }).then((fee) => {
                transaction
                  .save()
                  .then(() => {
                    res.statusCode = 200;
                    res.setHeader("Content-Type", "application/json");
                    res.json({ success: true, status: "Transaction Returned" });
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
            .then((item) => {
              res.statusCode = 200;
              res.setHeader("Content-Type", "application/json");
              res.json({ success: true, status: "Transaction Returned" });
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
  }
);

module.exports = transactionRouter;
