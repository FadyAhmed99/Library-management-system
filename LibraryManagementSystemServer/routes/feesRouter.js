var express = require("express");
const bodyParser = require("body-parser");

const Fee = require("../models/feeSchema");
const User = require("../models/usersSchema");
const cors = require("./cors");
const authenticate = require("../authenticate");

var feesRouter = express.Router();
feesRouter.use(bodyParser.json());

// user get all of his fees
feesRouter.get(
  "/myFees",
  cors.corsWithOptions,
  authenticate.verifyUser,
  (req, res, next) => {
    if (req.query.paid == null) {
      Fee.find({ user: req.user._id })
        .populate("item")
        .then((fees) => {
          for (var i in fees) {
            fees[i].item = {
              _id: fees[i].item._id,
              image: fees[i].item.image,
              name: fees[i].item.name,
            };
            fees[i].user = null;
          }

          res.statusCode = 200;
          res.setHeader("Content-Type", "application/json");
          res.json({
            success: true,
            status: "Request Succeed",
            fees: fees,
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
    } else if (req.query.paid == false) {
      Fee.find({ user: req.user._id, paid: false })
        .then((fees) => {
          res.statusCode = 200;
          res.setHeader("Content-Type", "application/json");
          res.json({
            success: true,
            status: "Request Succeed",
            fees: fees,
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
      Fee.find({ user: req.user._id })
        .then((fees) => {
          res.statusCode = 200;
          res.setHeader("Content-Type", "application/json");
          res.json({
            success: true,
            status: "Request Succeed",
            fees: fees,
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
  }
);

feesRouter.put(
  "/pay/:feeId",
  cors.corsWithOptions,
  authenticate.verifyUser,
  (req, res, next) => {
    Fee.findByIdAndUpdate(
      { _id: req.params.feeId },
      { $set: { paid: true } },
      function (err, fee) {
        if (!err) {
          Fee.find({ _id: req.user._id, paid: false })
            .then((fees) => {
              if (fees.length == 0) {
                User.findByIdAndUpdate(
                  { _id: req.user._id },
                  { $set: { canBorrowItems: true } }
                ).then(() => {
                  var date = new Date();
                  Fee.findByIdAndUpdate(
                    req.params.feeId,
                    {
                      creditCardInfo: req.body.creditCardInfo,
                      ccv: req.body.ccv,
                      paymentDate: date,
                    },
                    function (err, doc) {
                      if (err) {
                        res.statusCode = 500;
                        res.setHeader("Content-Type", "application/json");
                        res.json({
                          success: true,
                          status: "Request Failed",
                          err: err,
                        });
                      }
                    }
                  )
                    .then(() => {
                      res.statusCode = 200;
                      res.setHeader("Content-Type", "application/json");
                      res.json({
                        success: true,
                        status: "Paid Successfully",
                        fee: fee,
                      });
                    })
                    .catch((err) => {
                      res.statusCode = 500;
                      res.setHeader("Content-Type", "application/json");
                      res.json({
                        success: false,
                        status: "Request Failed",
                      });
                    });
                });
              } else {
                var date = new Date();
                Fee.findByIdAndUpdate(
                  req.params.feeId,
                  {
                    creditCardInfo: req.body.creditCardInfo,
                    ccv: req.body.ccv,
                    paymentDate: date,
                  },
                  function (err, doc) {
                    if (err) {
                      res.statusCode = 500;
                      res.setHeader("Content-Type", "application/json");
                      res.json({
                        success: true,
                        status: "Request Failed",
                        err: err,
                      });
                    }
                  }
                )
                  .then(() => {
                    res.statusCode = 200;
                    res.setHeader("Content-Type", "application/json");
                    res.json({
                      success: true,
                      status: "Paid Successfully",
                      fee: fee,
                    });
                  })
                  .catch((err) => {
                    res.statusCode = 500;
                    res.setHeader("Content-Type", "application/json");
                    res.json({
                      success: false,
                      status: "Request Failed",
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
              });
            });
        } else {
          res.statusCode = 500;
          res.setHeader("Content-Type", "application/json");
          res.json({
            success: false,
            status: "Request Failed",
          });
        }
      }
    ).catch((err) => {
      res.statusCode = 500;
      res.setHeader("Content-Type", "application/json");
      res.json({
        success: false,
        status: "Request Failed",
      });
    });
  }
);

module.exports = feesRouter;
