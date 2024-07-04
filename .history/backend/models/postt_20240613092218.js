// models/Post.js
const mongoose = require('mongoose');

const postSchema = new mongoose.Schema({
  registerID: {
    type: Number,
    required: true
  },
  idpost: {
    type: Number,
    required: true
  },
  description: {
    type: String,
    required: true
  },
  phoneNumber: { 
    type: String, 
    required: true 
  },

  date: {
    type: Date,
    default: Date.now
  },
  image: {
    type: String,
    required: true
  },
  type: {
    type: String,
    enum: ['Wedding', 'Graduation', 'Birth', 'Others'],
    required: true
  }
});

module.exports = mongoose.model('Post', postSchema);
