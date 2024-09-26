const UserModel = require('../models/userModel');

// دالة لتسجيل الدخول
const login = (req, res) => {
    const { email, password } = req.body;

    if (!email || !password) {
        return res.status(400).json({ message: 'Email and password are required' });
    }

    UserModel.findUserByEmailAndPassword(email, password, (err, user) => {
        if (err) {
            return res.status(500).json({ message: 'Internal server error' });
        }

        if (user) {
            return res.status(200).json({ message: 'Login successful' });
        } else {
            return res.status(401).json({ message: 'Invalid email or password' });
        }
    });
};

module.exports = { login };
