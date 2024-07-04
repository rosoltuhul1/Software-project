const mongoose = require("mongoose");

const UserSchema = new mongoose.Schema({
  username: { type: String, required: true },
  email: { type: String, required: true },
  needsEmail: { type: Boolean, default: false },
  bio: { type: String },
  password: { type: String, required: true },
  profilePicture: { type: String },
  following: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Photographer' }],
  date: { type: Date, default: Date.now },
  location: { type: String } // Add this line
});

const User = mongoose.model('User', UserSchema);
module.exports = User;
