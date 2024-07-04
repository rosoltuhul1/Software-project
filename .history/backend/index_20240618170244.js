

const express =require('express');
//const connection = require("./database");
const route = require('./crud/loginp.js');
const session = require('express-session');
var bodyParser=require('body-parser');
const mongoose = require('mongoose');
const editprofileP = require('./controllers/editprofileControllerP');
const sendVerificationController = require('./controllers/sendVerificationController'); 
const { handleInsertProfileImage, upload } = require('./controllers/insertimagephotog');
var urlencoderParser=bodyParser.urlencoded({extended:false});
const app = express();
const { getProfileInfo } = require('./controllers/getprofileinf'); // Adjust the path as necessary
const Photographer = require('./models/signupp'); // Adjust the path as necessary
//const Favorite = require('./models/favorite');
const Favorite = require('./models/favorite');
const User = require('./models/signups');
const Profile = require('./models/signupp');
const Post = require('./models/postt');
const { handleaddItem } = require('./controllers/addpost');
app.use(session({
  secret: '732d01adc9e6b7ccdc878b148c9624b47c3c69d4e2ed8bcf3d88de9ada1fa761ca86a90ad48184b93b29a916c86a72e95f4242fe7927d658c6408a519a35c558', // Replace with your own secret
  resave: false,
  saveUninitialized: true,
  cookie: { secure: false } // Set to true if using https
}));


app.use((req, res, next) => {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
  next();
});


// app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.json());

app.put('/Photographer/profile', editprofileP.updateProfile);

//app.use('/uploads', express.static('uploads'));

app.use('/lens', route);
app.use('/verification', sendVerificationController); // Add this line
app.post('/insertprofileimage', upload.single('profileimage'), handleInsertProfileImage);
app.get('/profileInfo/:registerID', getProfileInfo);
app.post('/addItem', handleaddItem);
app.get('/profileInfo/:registerID', async (req, res) => {
  const registerID = req.params.registerID;
  console.log(`Received request for registerID: ${registerID}`); // Add this line

  try {
    const photographer = await Photographer.findOne({ registerID: registerID }).select('fname lname major about');

    if (!photographer) {
      return res.status(404).json({ error: 'Photographer not found' });
    }

    res.json(photographer);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});
const path = require('path');

// Assuming Profile is your mongoose model for profiles
app.get('/profileimage/:registerID', async (req, res) => {
  const { registerID } = req.params;

  try {
    const profile = await Profile.findOne({ registerID });
    if (!profile || !profile.profilePicture) {
      return res.status(404).json({ error: 'Profile not found or image not available' });
    }

    const imagePath = profile.profilePicture;
    // Sending the image path as JSON
    res.status(200).json({ profilePicture: imagePath });

  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});



app.get('/admin/pendingPhotographers', async (req, res) => {
  console.log("approved fun");
  try {
    const photographers = await Photographer.find({ approved: false });
    res.status(200).json(photographers);
  } catch (err) {
    console.error(err);
    res.status(500).send('Error fetching pending photographers');
  }
});



app.get('/admin/allUsers', async (req, res) => {
  console.log("getting all users");
  try {
    const users = await User.find({}).sort({ date: -1 }); // Sort by date in descending order
    console.log(users);
    res.status(200).json(users);
  } catch (err) {
    console.error(err);
    res.status(500).send('Error fetching users');
  }
});


app.get('/admin/allphotog', async (req, res) => {
  console.log("getting all users");
  try {
    const users = await Photographer.find({}).sort({ date: -1 }); // Sort by date in descending order
    console.log(users);
    res.status(200).json(users);
  } catch (err) {
    console.error(err);
    res.status(500).send('Error fetching users');
  }
});



app.post('/admin/approvePhotographer', async (req, res) => {
  console.log("photographer approved");
  const { photographerId } = req.body;

  try {
    const photographer = await Photographer.findById(photographerId);

    if (photographer) {
      photographer.approved = true;
      await photographer.save();
      res.status(200).send('Photographer approved');
    } else {
      res.status(404).send('Photographer not found');
    }
  } catch (err) {
    console.error(err);
    res.status(500).send('Error approving photographer');
  }
});



app.post('/admin/denyPhotographer', async (req, res) => {
  console.log("photographer denied");
  const { photographerId } = req.body;

  try {
    const photographer = await Photographer.findById(photographerId);

    if (photographer) {
      await sendEmail(photographer.email, 'Denial Notification', 'Your account has been denied. Please contact support for more information.');
      await photographer.remove(); // Assuming you want to delete the photographer's account when denied
      res.status(200).send('Photographer denied');
    } else {
      res.status(404).send('Photographer not found');
    }
  } catch (err) {
    console.error(err);
    res.status(500).send('Error denying photographer');
  }
});


app.get('/graduationspage/:registerID', (req, res) => {
  const registerID = req.params.registerID;

  Post.find({ registerID: registerID }, 'date image description')
    .then(posts => {
      res.json(posts);
    })
    .catch(err => {
      res.status(500).json({ error: 'Internal Server Error' });
      console.error(err);
    });
});
//idpost

app.post('/deleteitem', async (req, res) => {
  console.log('********* Request body:', req.body);
  const { iditem } = req.body;

  // Print statement to log the request data
  console.log(`Request received to delete item with id: ${iditem}`);

  try {
    const result = await Post.findOneAndDelete({ _id: new mongoose.Types.ObjectId(iditem) });
    if (!result) {
      res.status(404).send('Item not found');
    } else {
      res.status(200).send('Delete item successful');
    }
  } catch (err) {
    console.error(err);
    res.status(500).send('Error deleting data from the database: ' + err.message);
  }
});

app.get('/userItems/:registerID', async (req, res) => {
  try {
    const registerID = req.params.registerID;
    const posts = await Post.find({ registerID: registerID }, '_id image description'); // Fetch only image and description
    console.log(posts);
    res.json(posts);
  } catch (err) {
    console.error("Error fetching user items:", err);
    res.status(500).json({ message: err.message });
  }
});



app.get('/postdetails', async (req, res) => {
  try {
    const posts = await Post.find({}, '_id image description date phoneNumber Fname Lname registerID'); // Fetch all necessary fields
    console.log(posts); // Logging the posts instead of res
    res.json(posts);
  } catch (err) {
    console.error("Error fetching user items:", err);
    res.status(500).json({ message: err.message });
  }
});




app.get('/getfavorites/:registerID', async (req, res) => {
  const registerID = req.params.registerID;

  try {
    // Find all favorites for the given registerID
    const favorites = await Favorite.find({ registerID })
      .populate({
        path: '_id',
        model: 'Post'
      })
      .exec();

    // Format the response
    const response = favorites.map(fav => ({
      _id: fav._id._id,
      title: fav._id.title,
      price: fav._id.price,
      image: fav._id.image,
      softCopy: fav.softCopy
    }));

    res.json(response);
  } catch (err) {
    console.error('Error fetching favorites:', err);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});


app.post('/addfavorite', async (req, res) => {
  console.log('********* Request body:', req.body);
  const { registerID, _id, softCopy } = req.body;
console.log(req.body);
console.log(_id);
console.log(registerID);
  // Check if iditem is a valid ObjectId
  

  try {
    // Create a new favorite document
    const newFavorite = new Favorite({
      registerID,
      _id, // Convert iditem to a valid ObjectId
      softCopy,
    });

    // Save the favorite to the database
    await newFavorite.save();

    res.status(200).send('Add item successful');
  } catch (err) {
    console.error('Error inserting data into the database:', err);
    res.status(500).send('Error inserting data into the database: ' + err.message);
  }
});





app.get('/receiverinfo/:idpost', async (req, res) => {
  const idpost = req.params.idpost;
console.log();
  try {
  console.log('Searching for photographer with registerID:', idpost);

    // Find the post by its unique _id
    const post = await Post.findById(idpost);
    
    if (post) {
      const registerID = post.registerID;
      // Find the photographer using the registerID from the post
      const photographer = await Photographer.findOne({ registerID: registerID });
      
      if (photographer) {
        res.json({
          registerID: photographer.registerID,
          Fname: photographer.fname,
          Lname: photographer.lname,
        });
      } else {
        res.json({ registerID: '' });
      }
    } else {
      res.json({ registerID: '' });
    }
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});



app.get('/checkFavorite/:iditem/:registerID', async (req, res) => {
  const iditem = req.params._id;
  const registerID = req.params.registerID;

  try {//Favorite
    // Query to check if the itemID and registerID exist in the favorite collection
    const favorite = await Favorite.findOne({ iditem, registerID });

    // If favorite is found, it means both itemID and registerID are found in the favorite collection
    const isFavorite = favorite !== null;

    console.log(isFavorite);
    res.json({ isFavorite });
  } catch (err) {
    console.error('Error checking favorite:', err);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

app.post('/deletefavorite', async (req, res) => {
  console.log('********* Request body:', req.body);
  const { iditem, registerID } = req.body;
  const parsedIditem = parseInt(iditem, 10);
  const parsedregisterID = parseInt(registerID, 10);

  try {
      // Find and delete the favorite document
      const result = await Favorite.deleteOne({ _id: parsedIditem, registerID: parsedregisterID });
      if (result.deletedCount === 1) {
          res.status(200).send('Delete item successful');
      } else {
          res.status(404).send('Item not found');
      }
  } catch (err) {
      console.error('Error deleting data from the database:', err);
      res.status(500).send('Error deleting data from the database: ' + err.message);
  }
});

app.get('/checkReserved/:iditem/:registerID', async (req, res) => {
  const { iditem, registerID } = req.params;

  try {
    // Query MongoDB to check if the item is reserved by the specified registerID
    const reservedItem = await Post.findOne({ iditem, reservedBy: registerID });

    // If reservedItem is not null, the item is reserved
    const isReserved = reservedItem !== null;
    console.log(isReserved);
    res.json({ isReserved });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});




app.get('/posts', async (req, res) => {
  try {
    const posts = await Post.find();
    res.json(posts);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});


app.get('/Graduationposts', async (req, res) => {
  try {console.log('graduation');
    // Fetch posts of type "Wedding"
    const GraduationPosts = await Post.find({ type: "Graduation" }).select('_id image description photographerId');

    res.status(200).json(GraduationPosts);
  } catch (err) {
    console.error(err);
    res.status(500).send('Error fetching wedding posts: ' + err.message);
  }
});

app.get('/otherposts', async (req, res) => {
  try {
    console.log('others');
    // Fetch posts of type "Others"
    const OtherPosts = await Post.find({ type: "Others" }).select('image description registerID');

    console.log(OtherPosts); // Log the fetched posts
    // console.log('end for queries others');
    res.status(200).json(OtherPosts);
  } catch (err) {
    console.error(err);
    res.status(500).send('Error fetching other posts: ' + err.message);
  }
});


app.get('/Birthposts', async (req, res) => {
  try {console.log('birthdays');
    // Fetch posts of type "Wedding"
    const BirthPosts = await Post.find({ type: "Birth" }).select('image description photographerId');

    res.status(200).json(BirthPosts);
  } catch (err) {
    console.error(err);
    res.status(500).send('Error fetching Birth posts: ' + err.message);
  }
});


//////////100%
app.use('/upload', express.static(path.join(__dirname, 'upload')));


// Endpoint to get profile data

app.get('/api/profile', async (req, res) => {
  try {
    const profile = await Photographer.findOne({ registerID: req.query.id }); // Use req.query.id to get the registerID from query parameters
    if (profile) {
      const relativePath = path.relative(__dirname, profile.profilePicture).replace(/\\/g, '/');
      res.json({
        registerID: profile.registerID,
        fname: profile.fname,
        lname: profile.lname,
        level: profile.level,
        profilePicture: relativePath,
      });
    } else {
      res.status(404).json({ message: 'Profile not found' });
    }
  } catch (error) {
    res.status(500).json({ message: 'Server error' });
  }
});

// app.get('/api/profile', async (req, res) => {
//   try {
//     const id = req.query.id; // Get the ID parameter from the query string
//     const profile = await Photographer.findOne({ registerID: id }); // Find the profile by the ID
//     if (profile) {
//       const relativePath = path.relative(__dirname, profile.profilePicture).replace(/\\/g, '/');
//       res.json({
//         registerID: profile.registerID,
//         profilePicture: relativePath,
//       });
//     } else {
//       res.status(404).json({ message: 'Profile not found' });
//     }
//   } catch (error) {
//     res.status(500).json({ message: 'Server error' });
//   }
// });



module.exports = app;






// // const express = require('express');
// // const session = require('express-session');
// // const mongoose = require('mongoose');
// // const path = require('path');
// // const Photographer = require("./models/signupp");
// // const route = require('./crud/loginp.js');
// // const { handleInsertProfileImage, upload } = require('./imageprofile');

// // const app = express();

// // // Set up session middleware
// // app.use(session({
// //   secret: '732d01adc9e6b7ccdc878b148c9624b47c3c69d4e2ed8bcf3d88de9ada1fa761ca86a90ad48184b93b29a916c86a72e95f4242fe7927d658c6408a519a35c558', // Replace with your own secret
// //   resave: false,
// //   saveUninitialized: true,
// //   cookie: { secure: false } // Set to true if using https
// // }));

// // // CORS setup
// // app.use((req, res, next) => {
// //   res.setHeader('Access-Control-Allow-Origin', '*');
// //   res.setHeader('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept');
// //   res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
// //   next();
// // });

// // app.use(express.urlencoded({ extended: true }));
// // app.use(express.json());

// // // Serve static files from the "uploads" directory
// // app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

// // // Route to handle profile image update
// // app.post('/updateProfileImage', upload.single('profileimage'), handleInsertProfileImage);

// // // Route to handle other CRUD operations
// // app.use('/lens', route);

// // // Route to fetch photographer profile information


// // module.exports = app;