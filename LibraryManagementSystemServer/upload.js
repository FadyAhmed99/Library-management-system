const multer = require('multer');

exports.upload = (destination , allowedTypes)=>{
    const storage = multer.diskStorage({
        destination: (req,file,cb)=>{  // cb is callback fn
            cb(null , destination);  // cb(err, destination)   states where the uploaded files are stored in the server
        } ,
        filename: (req,file,cb)=>{
            cb(null, file.originalname);   // file.originalname ensures that the uploaded file keeps its original name
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





