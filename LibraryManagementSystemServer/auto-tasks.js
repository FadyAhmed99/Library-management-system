const cron = require("node-cron");
const BorrowRequest = require("./models/physicalBorrowRequestSchema");

exports.deleteNonBorrowed = () =>
  cron.schedule("0 12 * * */1", function () {
    console.log("Deleting Fake Requests");
    var date = new Date();
    BorrowRequest.deleteMany({ deadline: { $lt: date }, borrowed: false })
      .then((requests) => {
        console.log("Deleting Non-Borrowed Requests");
      })
      .catch(() => {
        console.log(err);
      });
  });
