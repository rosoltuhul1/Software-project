const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');
const Admin = require('../models/loginA');  // Adjust the path as necessary

mongoose.connect('mongodb+srv://rosol:roro123@atlascluster.lgxoufm.mongodb.net/?retryWrites=true&w=majority', {
    useNewUrlParser: true,
    useUnifiedTopology: true 
});

async function createAdmin() {
    try {
        const existingAdmin = await Admin.findOne({ username: 'Admin' });
        if (existingAdmin) {
            console.log('Admin already exists!');
            return;
        }

        const hashedPassword = await bcrypt.hash('AdminAdmin', 10);
        const admin = new Admin({
            username: 'Admin', // Ensure this field is included if your schema requires it
            password: hashedPassword
        });

        await admin.save();
        console.log('Admin created successfully!');
    } catch (error) {
        console.error('Error creating admin:', error);
    }
}

createAdmin().then(() => {
    console.log('Finished creating admin');
    mongoose.disconnect(); // Ensure to disconnect mongoose after done
});
