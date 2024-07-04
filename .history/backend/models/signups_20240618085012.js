const mongoose = require("mongoose");

const UserSchema = new mongoose.Schema({
    username: { type: String, required: true },
    email: {
        type: String,
        required: true
    },
    needsEmail: { type: Boolean, default: false },
    bio: { type: String },
    password: { type: String, required: true },
    profilePicture: { type: String },
    following: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Photographer' }] // Users can only follow Photographers
});

const User = mongoose.model('User', UserSchema);
module.exports = User;
