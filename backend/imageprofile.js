
const User = require('../models/signupp'); // Adjust the path as needed
const multer = require('multer');
const path = require('path');
const fs = require('fs');

// Set storage engine
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        const uploadDir = './uploads/';
        fs.mkdirSync(uploadDir, { recursive: true });
        cb(null, uploadDir);
    },
    filename: (req, file, cb) => {
        cb(null, file.fieldname + '-' + Date.now() + path.extname(file.originalname));
    }
});


const upload = multer({
    storage: storage,
    limits: { fileSize: 1000000 }, 
    fileFilter: (req, file, cb) => {
        checkFileType(file, cb);
    }
}).single('image');


function checkFileType(file, cb) {
    const filetypes = /jpeg|jpg|png|gif/;
    const extname = filetypes.test(path.extname(file.originalname).toLowerCase());
    const mimetype = filetypes.test(file.mimetype);

    if (mimetype && extname) {
        return cb(null, true);
    } else {
        cb('Error: Images Only!');
    }
}

const getProfileData = async (req, res) => {
    const userId = req.user;

    try {
        const user = await User.findById(userId).select('-password'); // Exclude password from the result
        if (!user) {
            console.error('User not found');
            return res.status(404).json({ error: 'User not found' });
        }
        console.log('User fetched successfully');
        return res.status(200).json({ success: 'User fetched successfully', data: user });
    } catch (error) {
        console.error('Error fetching user profile data:', error.message);
        return res.status(500).json({ error: 'Error fetching user profile data' });
    }
};

const uploadProfilePicture = (req, res) => {
    upload(req, res, (err) => {
        if (err) {
            return res.status(400).json({ success: false, message: err });
        }
        if (req.file == undefined) {
            return res.status(400).json({ success: false, message: 'No file selected' });
        }

        const imageUrl = `http://10.0.2.2:${process.env.PORT || 3000}/uploads/${req.file.filename}`;
        res.status(200).json({
            success: true,
            imageUrl: imageUrl
        });
    });
};


module.exports = { getProfileData, uploadProfilePicture };
