const mongoose = require("mongoose");
const adminSchema = new mongoose.Schema({
    username: { 
        type: String,
        default: "Admin", 
        immutable: true 
    }, // Set default and prevent changes
    password: String,
});

const Admin = mongoose.model("Admin", adminSchema);
module.exports = Admin;
