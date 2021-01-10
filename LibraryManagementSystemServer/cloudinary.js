const cloudinary = require('cloudinary').v2;
const config = require('./config');

cloudinary.config({
   cloud_name: config.cloudName,
   api_key: config.cloudAPIKey,
   api_secret: config.cloudAPISecret
});


module.exports = cloudinary;