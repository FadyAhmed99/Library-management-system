const cloudinary = require('cloudinary').v2;
const { CloudinaryStorage } = require('multer-storage-cloudinary');
const multer = require('multer');

exports.upload = (destination , allowedTypes)=>{
    const storage = new CloudinaryStorage({
        cloudinary: cloudinary,
        params:{
            folder: destination
        }
    });

    const imgFileFilter = (req,file,cb)=>{  // cb(err, fileAcceptState)
        if(!file.originalname.match(allowedTypes)){    // check if the original name of the uploaded files doen't have the extensions mentioned
            req.wrongFormat = true;
            return cb(null , false);
        }
        else{
            cb(null,true);
        }
    }

    const upload = multer({
        storage : storage, 
        fileFilter: imgFileFilter
    });

    return upload;
}





