const express = require('express');
const router = express.Router();
const nodemailer = require('nodemailer');
const mongoose = require('mongoose');
const Photographer = require('../models/signupp'); // Adjust the path as needed
//const Photographer = require('../models/signupp');
const transporter = nodemailer.createTransport({
    service: 'Gmail', 
    auth: {
        user: 'lensScout12@gmail.com', 
        pass: 'hqzq vhul amqv lxkt', 
    },
});

function generateVerificationCode() {
    return Math.floor(1000 + Math.random() * 9000);
}

router.post('/sendVerificationCode', async (req, res) => {
    const { email } = req.body;
    console.log('********* Request body:', req.body);
    const verificationCode = generateVerificationCode();

    try {
        const photographer = await Photographer.findOneAndUpdate(
            { email: email },
            { $set: { code: verificationCode } },
            { new: true, upsert: true }
        );

        const mailOptions = {
            from: 'lensScout12@gmail.com',
            to: email,
            subject: 'Verification Code',
            text: `Your verification code is: ${verificationCode}`,
        };

        transporter.sendMail(mailOptions, (error, info) => {
            if (error) {
                console.error('Email sending error:', error);
                res.status(500).json({ message: 'Failed to send verification code email' });
            } else {
                console.log('Email sent: ' + info.response);
                res.status(200).json({ message: 'Verification code sent successfully' });
            }
        });
    } catch (err) {
        console.error(err);
        res.status(500).send('Error saving verification code to the database');
    }
});

router.post('/verifyCode', async (req, res) => {
    const { email, code } = req.body;
    console.log(req.body);
    const parsedCode = parseInt(code, 10);

    try {
        const photographer = await Photographer.findOne({ email: email });

        if (photographer) {
            if (parsedCode === photographer.code) {
                res.status(200).send('Verification successful');
            } else {
                res.status(401).send('Incorrect verification code');
            }
        } else {
            res.status(404).send('User not found');
        }
    } catch (err) {
        console.error(err);
        res.status(500).send('Error querying the database');
    }
});
const bcrypt = require('bcrypt');
router.post('/resetPassword', async (req, res) => {
    const { email, password } = req.body;

    try {
        // Hash the password
        const hashedPassword = await bcrypt.hash(password, 10);

        // Update the user's password with the hashed password
        const photographer = await Photographer.findOneAndUpdate(
            { email: email },
            { $set: { password: hashedPassword } },
            { new: true }
        );

        if (photographer) {
            res.status(200).json({ message: 'Password updated successfully' });
        } else {
            res.status(404).json({ message: 'User not found' });
        }
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Internal Server Error' });
    }
});




router.post('/admin/approvePhotographer', async (req, res) => {
    console.log("photographer approved");
    const { photographerId } = req.body;
  
    try {
      const photographer = await Photographer.findById(photographerId);
  
      if (photographer) {
        photographer.approved = true;
        await photographer.save();
        await sendEmail(photographer.email, 'Approval Notification', 'Your account has been approved. You can now login.');
        res.status(200).send('Photographer approved');
      } else {
        res.status(404).send('Photographer not found');
      }
    } catch (err) {
      console.error(err);
      res.status(500).send('Error approving photographer');
    }
  });
  
  // Deny photographer
  router.post('/admin/denyPhotographer', async (req, res) => {
    console.log("photographer denied");
    const { photographerId } = req.body;
  
    try {
      const photographer = await Photographer.findById(photographerId);
  
      if (photographer) {
        await sendEmail(photographer.email, 'Denial Notification', 'Your account has been denied. Please contact support for more information.');
        await photographer.remove(); // Assuming you want to delete the photographer's account when denied
        res.status(200).send('Photographer denied');
      } else {
        res.status(404).send('Photographer not found');
      }
    } catch (err) {
      console.error(err);
      res.status(500).send('Error denying photographer');
    }
  });
  
module.exports = router;
