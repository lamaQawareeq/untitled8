const express = require('express');
const authController = require('../controllers/authController');

const router = express.Router();

// نقطة نهاية لتسجيل الدخول
router.post('/login', authController.login);

module.exports = router;
