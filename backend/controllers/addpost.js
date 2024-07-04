const Post = require('../models/postt'); // Adjust the path as needed

var bodyParser = require('body-parser');
var urlencoderParser = bodyParser.urlencoded({ extended: false });

const handleaddItem = async (req, res) => {
  console.log('********* Request body:', req.body);
  const { registerID, idpost, description, image, type, phoneNumber } = req.body;

  const parsedRegisterID = parseInt(registerID, 10);
  const parsedIdpost = parseInt(idpost, 10);

  if (isNaN(parsedRegisterID) || isNaN(parsedIdpost)) {
    console.error('Error: Unable to parse registerID or idpost to number.');
    return res.status(400).send('Invalid registerID or idpost value.');
  }

  const newPost = new Post({
    registerID: parsedRegisterID,
    idpost: parsedIdpost,
    description: description,
    image: image,
    type:type,
    phoneNumber:phoneNumber

  });

  try {
    await newPost.save();
    res.status(200).send('Add item successful');
  } catch (err) {
    console.error(err);
    res.status(500).send('Error inserting data into the database: ' + err.message);
  }
}

module.exports = { handleaddItem };
