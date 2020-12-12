var express = require("express");
const bodyParser = require("body-parser");
const User = require("../models/usersSchema");
const BorrowRequest = require("../models/physicalBorrowRequestSchema");
const Item = require("../models/itemSchema");
const Permission = require("../models/permissionSchema");
const cors = require("./cors");
const authenticate = require("../authenticate");

var borrowRequestRouter = express.Router();
borrowRequestRouter.use(bodyParser.json());

// user request to borrow item
borrowRequestRouter.post(
  "/:libraryId/:itemId",
  cors.corsWithOptions,
  authenticate.verifyUser,
  (req, res, next) => {
    User.findById(req.user._id)
      .then((user) => {
        if (user.canBorrowItems == true) {
          Item.findById(req.params.itemId)
            .then((item) => {
              // if item is physical
              if (
                item.type == "book" ||
                item.type == "audioMaterial" ||
                item.type == "magazine"
              ) {
                BorrowRequest.create(
                  new BorrowRequest({
                    user: req.user._id,
                    library: req.params.libraryId,
                    item: req.params.itemId,
                  })
                ).then(() => {
                  res.statusCode = 200;
                  res.setHeader("Content-Type", "application/json");
                  res.json({ success: true, status: "Requested Succesfully" });
                });
              }
              // if item is not physical
              else {
                // TODO: add transaction
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
  "/",
  cors.corsWithOptions,
  //authenticate.verifyLibrarian,
  (req, res, next) => {
    BorrowRequest.find({})
      .where("library", req.librarian.managedLibrary)
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
  "accept/:requestId",
  cors.corsWithOptions,
  //authenticate.verifyLibrarian,
  (req, res, next) => {
    BorrowRequest.findOneAndUpdate(
      { _id: req.params.requestId },
      { $set: { borrow: true } }
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
