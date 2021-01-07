const config = require("./config");

exports.correctPath = (photo, hostname) => {
  console.log(hostname);
  if (photo.startsWith("http")) {
    return photo;
  } else {
    correctedPhoto =
      `https://${hostname}:3443/` + photo.substring(6, photo.length); //TODO: modify port before deploy
    return correctedPhoto;
  }
};
