const cron = require("node-cron");

exports.deleteNonBorrowed = cron.schedule("* * 0/12 * * 1/2 *", function () {
  BorrowRequest.deleteMany({ borrowed: false })
    .then((response) => {
      console.log("Deleting Non-Borrowed Requests");
    })
    .catch(() => {
      console.log(err);
    });
});
