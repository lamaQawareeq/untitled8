const express = require('express');
const { UserController } = require('../controllers/authController');

const router = express.Router();

// استخدم دالة getUserByEmail كطلب POST
router.post("/login", UserController.getUserByEmail);

module.exports = router;
