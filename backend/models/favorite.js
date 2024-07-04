const mongoose = require('mongoose');

const favoriteSchema = new mongoose.Schema({
  registerID: { type: Number, required: true, ref: 'Photographer' },
  _id: { type: String, required: true },
  softCopy: { type: String, required: true },
  // Other fields if needed...
});

const Favorite = mongoose.model('Favorite', favoriteSchema);

module.exports = Favorite;
