const Photographer = require('../models/signupp'); // Adjust the path as necessary

async function getProfileInfo(req, res) {
  const registerID = req.params.registerID;
  console.log(`Received request for registerID: ${registerID}`);

  try {
    const photographer = await Photographer.findOne({ registerID: registerID }).select('fname lname level  profilePicture');
    console.log('Photographer found:', photographer); // Add this line to log the found photographer

    if (!photographer) {
      return res.status(404).json({ error: 'Photographer not found' });
    }

    res.json(photographer);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Internal Server Error' });
  }
}


module.exports = { getProfileInfo };
