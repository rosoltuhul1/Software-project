const express = require('express');
const mongoose = require('../database');
const app = express.Router();
const bcrypt = require('bcrypt');
//const Favorite = require("../models/favourit"); 
const User = require("../models/signups");
//const Profile = require("../models/Profile"); 
const Photographer = require("../models/signupp");
const Admin = require("../models/loginA");
//const Post = require("../models/post");
const multer = require('multer');
const Item = require('../models/item');
const jwt = require('jsonwebtoken');
const crypto = require('crypto');
const secret = crypto.randomBytes(64).toString('hex');
console.log(secret); 
const session = require('express-session');
const SECRET_KEY = process.env.SECRET_KEY || '732d01adc9e6b7ccdc878b148c9624b47c3c69d4e2ed8bcf3d88de9ada1fa761ca86a90ad48184b93b29a916c86a72e95f4242fe7927d658c6408a519a35c558';
const { ObjectId } = require('mongoose').Types;
const { MongoClient } = require('mongodb');


const storage = multer.diskStorage({
  destination: function(req, file, cb) {
    cb(null, './uploads');  // Path relative to where your server.js runs
  },
  filename: function(req, file, cb) {
    // Naming the file uniquely: prefix with the timestamp
    cb(null, new Date().toISOString().replace(/:/g, '-') + '-' + file.originalname);
  }
});

const upload = multer({ storage: storage });


app.post('/upload', upload.single('profileImage'), (req, res) => {
  if (!req.file) {
    return res.status(400).send('No file uploaded.');
  }
  const fileUrl = `${req.protocol}://${req.get('host')}/uploads/${req.file.filename}`;
  res.send({ url: fileUrl });
});


app.get('/profileInfo/:registerID', async (req, res) => {
  const registerID = req.params.registerID;

  try {
    const photographer = await Photographer.findOne({ registerID: registerID }, 'fname lname profilePicture');

    if (!photographer) {
      return res.status(404).json({ error: 'Photographer not found' });
    }

    res.json({
      Fname: photographer.fname,
      Lname: photographer.lname,
      profileimage: photographer.profilePicture // Ensure this is a valid URL
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});




//100%
app.post('/editprofileinfo', async (req, res) => {
  try {
    const { registerID, fname, lname ,proficiencyLevel} = req.body;
    const photographer = await Photographer.findOne({ registerID });
    
    if (!photographer) {
        return res.status(404).send('Photographer not found');
    }

    if (fname) photographer.fname = fname;
    if (lname) photographer.lname = lname;
    if (proficiencyLevel) photographer.proficiencyLevel = proficiencyLevel; 
    console.log(fname);
    console.log(lname);
    console.log(proficiencyLevel);
    // Save the updated photographer profile
    await photographer.save();
    res.status(200).send('Profile updated successfully');
} catch (error) {
    console.error('Error updating profile:', error);
    res.status(500).send('Internal Server Error');
}
});



const path = require('path');

app.get('/profileImage/:registerID', async (req, res) => {
  console.log("let's get pic");
  try {
    const { registerID } = req.params;
    const photographer = await Photographer.findOne({ registerID }, 'profilePicture');
    if (!photographer) {
      console.log('Photographer not found');
      return res.status(404).send('Photographer not found');
    }
    console.log('Found photographer:', photographer);

    const imagePath = path.join(__dirname, '..', photographer.profilePicture);
    // Send the image file
    res.sendFile(imagePath);
  } catch (error) {
    console.error('Error fetching profile:', error);
    res.status(500).send('Internal Server Error');
  }
});



// app.get('/profileInfo/:registerID', async (req, res) => {
//   console.log("let's get info");
//   try {
//     const { registerID } = req.params;

//     // Find the photographer by registerID and include the profilePicture field
//     const photographer = await Photographer.findOne({ registerID }, 'fname lname');
//     if (!photographer) {
//       console.log('Photographer not found');
//       return res.status(404).send('Photographer not found');
//     }
//     console.log('Found photographer:', photographer);
//     res.status(200).json({
//       _id: photographer._id,
//       fname: photographer.fname,
//       lname: photographer.lname,
//       profilePicture: photographer.profilePicture
//     });
//   } catch (error) {
//     console.error('Error fetching profile:', error);
//     res.status(500).send('Internal Server Error');
//   }
// });






  //////100%working
app.post('/image', upload.single('profileimage'), async (req, res) => {
  console.log('********* Request body:', req.body);
  console.log('********* Request file:', req.file); // This will log the uploaded file information

  const { registerID } = req.body;
  const profilePicture = req.file.path; // Use req.file.path to get the path of the uploaded file

  try {
    const updatedProfile = await Photographer.findOneAndUpdate(
      { registerID: parseInt(registerID, 10) },
      { profilePicture },
      { new: true, upsert: true } // upsert: true will create a new document if one doesn't exist
    );

    if (updatedProfile) {
      res.status(200).send('Image updated successfully');
    } else {
      res.status(404).send('Profile not found');
    }
  } catch (err) {
    console.error('Error updating image in the database:', err.message);
    res.status(500).send('Error updating image in the database: ' + err.message);
  }
});






function getStatusString(statusCode) {
  switch (statusCode) {
    case 1:
      return 'New';
    case 2:
      return 'Very Good';
    case 3:
      return 'Good';
    case 4:
      return 'Not Bad';
    default:
      return ''; // Handle unknown status codes as needed
  }
}

app.post('/additem', async (req, res) => {
  console.log('********* Request body:', req.body);
  const {
    registerID,
    idCategory,
    title,
    description,
    price,
    available,
    status,
    phoneNumber,
    faculty,
    major,
    image
  } = req.body;
  const parsedPrice = parseInt(price, 10);
  const parsedRegisterID = parseInt(registerID, 10);
  const parsedIdCategory = parseInt(idCategory, 10);
  const parsedStatus = parseInt(status, 10);
  const statusString = getStatusString(parsedStatus);
  const parsedAvailable = parseInt(available, 10);
  const parsedFaculty = parseInt(faculty, 10);
  const parsedMajor = parseInt(major, 10);

  try {
    const item = new Item({
      registerID: parsedRegisterID,
      idCategory: parsedIdCategory,
      title,
      description,
      price: parsedPrice,
      available: parsedAvailable,
      status: statusString,
      phoneNumber,
      faculty: parsedFaculty, 
      image
    });
    await item.save();
    res.status(200).send('Add item successful');
  } catch (err) {
    console.error('Error inserting data into the database:', err.message);
    res.status(500).send('Error inserting data into the database: ' + err.message);
  }
});



app.post('/addfavoriteController', async (req, res) => {
  console.log('********* Request body:', req.body);
  const { registerID, iditem, softCopy } = req.body;

  try {
    const favorite = new Favorite({ registerID, iditem, softCopy });
    await favorite.save();
    res.status(200).send('Add item successful');
  } catch (err) {
    console.error('Error inserting data into the database:', err.message);
    res.status(500).send('Error inserting data into the database: ' + err.message);
  }
});

/////checked////
app.post('/admin/login', async (req, res) => {
    console.log("Received data:", req.body); // Logs the entire body
    const { username, password } = req.body;

    // Here we'll log the specific username and password
    console.log("Username:", username);
    console.log("Password:", password); 

    const admin = await Admin.findOne({ username });

    if (!admin) {
        return res.status(401).json({ message: 'Authentication failed' });
    }

    const isMatch = await bcrypt.compare(password, admin.password);

    if (!isMatch) {
        return res.status(401).json({ message: 'Authentication failed' });
    }

    const token = jwt.sign({ id: admin._id }, SECRET_KEY, { expiresIn: '1h' });

    res.json({ message: 'Logged in successfully!', token });
});



////checked/////
app.post('/signups', upload.single('profilePicture'), async (req, res) => {
    const { username, email, bio, password } = req.body;
     // Handling if no file is uploaded

     

    try {
        // Check if user already exists
        const existingUser = await User.findOne({ $or: [{ username: username }, { email: email }] });
        if (existingUser) {
            return res.status(409).send('User already exists with the same username or email');
        }

        // If user does not exist, create a new one
        const saltRounds = 10;
        const hashedPassword = await bcrypt.hash(password, saltRounds);
        const newUser = new User({
            username,
            email,
            bio,
            password: hashedPassword,
             
        });
        await newUser.save();
        res.status(201).send('User created');
    } catch (error) {
        console.error("Error saving user:", error);
        res.status(500).send(error.message);
    }
});

/////checked/////////
app.post('/logins', async (req, res) => {
    const { email, password } = req.body;

    try {
        const user = await User.findOne({ email });
        if (!user) {
            return res.status(404).send('User not found');
        }

        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) {
            return res.status(401).send('Incorrect password');
        }

        res.status(200).send('User logged in successfully');
    } catch (error) {
        console.error("Login error:", error);
        res.status(500).send('Server error');
    }
});




/////checked/////////

app.post('/loginpho', async (req, res) => {
  console.log('********* Request body:', req.body);
  const { registerID, password } = req.body;

  try {
    const photographer = await Photographer.findOne({ registerID });

    if (photographer) {
      if (!photographer.approved) {
        return res.status(403).send('Photographer not approved by admin');
      }

      const match = await bcrypt.compare(password, photographer.password);
      if (match) {
        req.session.userId = photographer.registerID; // Example session management
        res.status(200).send('Login successful');
      } else {
        res.status(401).send('Incorrect password');
      }
    } else {
      res.status(404).send('User not found');
    }
  } catch (err) {
    console.error(err);
    res.status(500).send('Error querying the database');
  }
});







  


/////////checked/////
app.post('/photographer/signups', async (req, res) => { 
  const { registerID, fname, lname,linkToWork, phoneNO, email, password, location } = req.body;

  // Validate input data
  if (!lname || !fname || !registerID || !linkToWork || !phoneNO || !email || !password || !location) {
    
      res.status(400).send('Invalid or missing photographer data');
      return;
  }

  try {
      // Check if photographer already exists
      const existingPhotographer = await Photographer.findOne({ email: email });
      if (existingPhotographer) {
          return res.status(409).send('Photographer already exists with the same email');
      }

      // If photographer does not exist, create a new one
      const saltRounds = 10;
      const hashedPassword = await bcrypt.hash(password, saltRounds);
      const newPhotographer = new Photographer({
          registerID,
          fname,
          lname,
          linkToWork,
          phoneNO,
          email,
          password: hashedPassword,
          verified: false,
          type: 'photographer',
          approved: false ,
          location,
      });
      await newPhotographer.save();
      res.status(201).json({ message: "Photographer created. Pending approval." });
  } catch (error) {
      console.error("Error saving photographer:", error);
      res.status(500).send(error.message);
  }
});

app.post('/createprofile', async (req, res) => {
  console.log('********* Request body:', req.body);
  const { registerID, fname, lname,linkToWork, phoneNO, email, password, location } = req.body;

  try {
    // Check if the photographer exists and is approved
    const existingPhotographer = await Photographer.findOne({ registerID });

    if (!existingPhotographer) {
      return res.status(404).send('Photographer not found');
    }

    if (!existingPhotographer.approved) {
      return res.status(403).send('Photographer not approved by admin');
    }

    // If the photographer is approved, create the profile
    const newProfile = new Photographer({ registerID, fname, lname,createprofile, phoneNO, email, password, location });
    await newProfile.save();
    res.status(200).send('Profile created successfully');
  } catch (err) {
    console.error(err);
    res.status(500).send('Error inserting data into the database: ' + err.message);
  }
});





//////checked
app.get('/api/photographers', async (req, res) => {
    try {
      const photographers = await Photographer.find();
      res.json(photographers);
    } catch (error) {
      res.status(500).send(error.message);
    }
  });
  


////////
app.put('/api/photographers/:id', async (req, res) => {
    const { approved } = req.body;
    try {
      await Photographer.findByIdAndUpdate(req.params.id, { approved });
      res.send('Photographer status updated');
    } catch (error) {
      res.status(500).send(error.message);
    }
  });


app.delete('/api/photographers/:id', async (req, res) => {
  const { id } = req.params;

  if (!mongoose.Types.ObjectId.isValid(id)) {
      return res.status(400).send('Invalid ID format');
  }

  try {
      const result = await Photographer.findByIdAndDelete(id);
      if (!result) {
          return res.status(404).send('Photographer not found');
      }
      res.send('Photographer deleted successfully');
  } catch (error) {
      console.error("Error during deletion:", error);
      res.status(500).send('Error deleting photographer: ' + error.message);
  }
});

  


// Endpoint for updating photographer profile
app.put('/photographer/:id', async (req, res) => {
  try {
    const id = req.params.id;
    const updates = req.body;

    // You might want to validate updates here before applying them
    const updatedPhotographer = await Photographer.findByIdAndUpdate(id, updates, { new: true, runValidators: true });

    if (!updatedPhotographer) {
      return res.status(404).send({ message: 'Photographer not found' });
    }
    res.send(updatedPhotographer);
  } catch (error) {
    res.status(500).send({ message: 'Failed to update photographer', error: error.message });
  }
});


app.put('/photographer/:id/photo', upload.single('profilePicture'), async (req, res) => {
  if (!req.file) {
    return res.status(400).send({ message: 'No photo uploaded' });
  }

  try {
    const id = req.params.id;
    const profilePicture = req.file.path; // Ensure the file path is accessible

    const updatedPhotographer = await Photographer.findByIdAndUpdate(id, { profilePicture }, { new: true });

    if (!updatedPhotographer) {
      return res.status(404).send({ message: 'Photographer not found' });
    }
    res.send(updatedPhotographer);
  } catch (error) {
    res.status(500).send({ message: 'Error updating profile picture', error: error.message });
  }
});

  






app.get('/photographers/:userId', async (req, res) => {
  const { userId } = req.params;

  try {
    const photographer = await Photographer.findById(userId).exec();
    if (!photographer) {
      throw 'Photographer not found';
    }
    res.status(200).json(photographer);
  } catch (error) {
    res.status(404).send(error);
  }
});


app.patch('/photographers/:id', async (req, res) => {
  const { id } = req.params;
  try {
    const updatedPhotographer = await Photographer.findByIdAndUpdate(id, req.body, { new: true });
    res.status(200).json(updatedPhotographer);
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
});


///////////////checked for posts


app.post("/create", async (req, res) => {
  const { photographer, imagePath, caption } = req.body; // Changed 'photographerId' to 'photographer'
  console.log("Received request body:", req.body);

  try {
      if (!ObjectId.isValid(photographer)) { // Changed 'photographerId' to 'photographer'
          console.log("Invalid ID Format:", photographer);
          return res.status(400).send({ message: "Invalid photographer ID format" });
      }
      
      const photographerData = await Photographer.findById(photographer); // Changed 'photographerId' to 'photographer'
      if (!photographerData) {
          return res.status(404).send({ message: "Photographer not found" });
      }

      const newPost = new Post({
          photographer: photographer, // Changed 'photographerId' to 'photographer'
          imagePath: imagePath,
          caption: caption,
      });
      const savedPost = await newPost.save();
      photographerData.posts.push(savedPost._id);
      await photographerData.save();

      res.status(201).send({ message: "Post created successfully!", post: savedPost });
  } catch (error) {
      console.error('Error creating the post:', error);
      res.status(500).send({ message: "Error creating the post", error: error.toString() });
  }
});


  


app.get('/posts/:photographerId', async (req, res) => {
  const photographerId = req.params.photographerId;
  console.log("Fetching posts for photographer ID:", photographerId);

  try {
    const posts = await Post.find({ photographer: photographerId }).exec();
    console.log("Found posts:", posts.length);
    res.status(200).json(posts);
  } catch (error) {
    console.error('Error fetching posts:', error);
    res.status(500).json({ error: 'Failed to fetch posts', details: error.message });
  }
});



module.exports = app;
