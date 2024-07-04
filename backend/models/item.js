const mongoose = require('mongoose');

const itemSchema = new mongoose.Schema({
  registerID: {
    type: Number,
    required: true
  },
  idCategory: {
    type: Number,
    required: true
  },
  title: {
    type: String,
    required: true
  },
  description: {
    type: String,
    required: true
  },
  price: {
    type: Number,
    required: true
  },
  available: {
    type: Number,
    required: true
  },
  status: {
    type: String,
    enum: ['New', 'Very Good', 'Good', 'Not Bad'],
    required: true
  },
  phoneNumber: {
    type: String,
    required: true
  },
  faculty: {
    type: Number,
    required: true
  },
  Date: {
    type: Date,
    default: Date.now
  },
  image: {
    type: String,
    required: true
  }
});

const Item = mongoose.model('Item', itemSchema);

module.exports = Item;
