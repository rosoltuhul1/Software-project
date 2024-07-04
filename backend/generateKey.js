const crypto = require('crypto');

function generateSecureKey() {
    const secretKey = crypto.randomBytes(64).toString('hex');
    console.log("Generated Secret Key:", secretKey);
}

generateSecureKey();
