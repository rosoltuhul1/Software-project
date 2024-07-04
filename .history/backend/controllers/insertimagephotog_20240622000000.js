const Photographer = require('../models/signupp'); // Import your Photographer model
const multer = require('multer');
const path = require('path');

// Set up multer for file uploads
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'C:/softwareGrad/backend/upload/'); // Set the upload directory
  },
  filename: function (req, file, cb) {
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
    cb(null, uniqueSuffix + path.extname(file.originalname)); // Generate a unique filename
  }
});

const upload = multer({ storage: storage });

async function handleInsertProfileImage(req, res) {
  try {
    console.log('********* Request body:', req.body);
    if (!req.file) {
      return res.status(400).send('No file uploaded.');
    }

    const { registerID } = req.body;
    const profilePicturePath = req.file.path; // Get the file path
console.log
    // Update the profile picture path for the photographer with the given registerID
    const photographer = await Photographer.findOneAndUpdate(
      { registerID: registerID },
      { profilePicture: profilePicturePath },
      { new: true }
    );

    if (!photographer) {
      return res.status(404).send('Photographer not found');
    }

    res.status(200).send('Image updated successfully');
  } catch (err) {
    console.error(err);
    res.status(500).send('Error updating image in the database: ' + err.message);
  }
}

module.exports = { handleInsertProfileImage, upload };
