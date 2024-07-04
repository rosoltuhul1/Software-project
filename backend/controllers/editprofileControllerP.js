const photographer = require('../models/signupp'); // Adjust the path as needed

const updateProfile = async (req, res) => {
    const { profilePicture } = req.body;

    try {
        const updatedProfile = await photographer.findOneAndUpdate({ email }, {
            profilePicture
        }, { new: true });

        if (!updatedProfile) {
            console.error('photographer not found');
            return res.status(404).json({ error: 'photographer not found' });
        }
        console.log('Profile updated successfully');
        return res.status(200).json({ success: 'Profile updated successfully', data: updatedProfile });
    } catch (error) {
        console.error('Error updating profile:', error.message);
        return res.status(500).json({ error: 'Error updating profile' });
    }
};
module.exports = { updateProfile };
