const mongoose = require("mongoose");

const photographerSchema = new mongoose.Schema({
    registerID: { type: String, required: true },
    fname: { type: String, required: true },
    lname: { type: String, required: true },
    phoneNO: { type: String, required: true },
    email: { type: String, required: true, unique: true },
    password: { type: String, required: true },
    profilePicture: { type: String },
    linkToWork: { type: String },
    proficiencyLevel: { type: String },
    verified: { type: Boolean, default: false },
    approved: { type: Boolean, default: false },
    posts: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Post' }],
    followers: [{ type: mongoose.Schema.Types.ObjectId, ref: 'User' }],
    following: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Photographer' }],
    location: { type: String },
    code: { type: Number } // Add this line
});

const Photographer = mongoose.model('Photographer', photographerSchema);

module.exports = Photographer;
