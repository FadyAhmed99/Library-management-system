var express = require("express");
const bodyParser = require("body-parser");
const User = require("../models/usersSchema");
const BorrowRequest = require("../models/physicalBorrowRequestSchema");
const Item = require("../models/itemSchema");
const cors = require("./cors");
const authenticate = require("../authenticate");

var borrowRequestRouter = express.Router();
borrowRequestRouter.use(bodyParser.json());

// user request to borrow item
borrowRequestRouter.post(
  "/:libraryId/:itemId",
  cors.corsWithOptions,
  authenticate.verifyUser,
  authenticate.verifyMember,
  (req, res, next) => {
    User.findById(req.user._id)
      .then((user) => {
        if (user.canBorrowItems == true) {
          Item.findById(req.params.itemId)
            .then((item) => {
              // if item is available
              if (item.available.id(req.params.libraryId).amount != 0) {
                // if item is physical
                if (
                  item.type == "book" ||
                  item.type == "audioMaterial" ||
                  item.type == "magazine"
                ) {
                  var date = new Date();
                  date.setDate(date.getDate() + 2);
                  BorrowRequest.create(
                    new BorrowRequest({
                      user: req.user._id,
                      library: req.params.libraryId,
                      item: req.params.itemId,
                      deadline: date,
                    })
                  ).then(() => {
                    item.available.id(req.params.libraryId).amount -= 1;
                    item
                      .save()
                      .then((item) => {
                        res.statusCode = 200;
                        res.setHeader("Content-Type", "application/json");
                        res.json({
                          success: true,
                          status: "Requested Succesfully",
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
                }
                // if item is not physical
                else {
                  // TODO: add transaction
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
              res.json({ success: false, status: "Request Failed", err: err });
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
      .catch(() => {
        res.statusCode = 500;
        res.setHeader("Content-Type", "application/json");
        res.json({
          success: false,
          status: "Request Failed",
        });
      });
  }
);

// librarian get all requests
borrowRequestRouter.get(
  "/:libraryId",
  cors.corsWithOptions,
  authenticate.verifyUser,
  authenticate.verifyLibrarian,
  (req, res, next) => {
    BorrowRequest.find({})
      .where("library", req.user.managedLibrary)
      .where("borrowed", false)
      .then((requests) => {
        res.statusCode = 200;
        res.setHeader("Content-Type", "application/json");
        res.json(requests);
      })
      .catch(() => {
        res.statusCode = 500;
        res.setHeader("Content-Type", "application/json");
        res.json({
          success: false,
          status: "Request Failed",
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
    BorrowRequest.findOneAndUpdate(
      { _id: req.params.requestId },
      { $set: { borrowed: true } }
    )
      .then((request) => {
        res.statusCode = 200;
        res.setHeader("Content-Type", "application/json");
        res.json({
          success: true,
          status: "Request Approved",
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

module.exports = borrowRequestRouter;
