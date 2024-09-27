const express = require('express');
const { UserController } = require('../controllers/authController');

const router = express.Router();

// استخدم دالة getUserByEmail كطلب POST
router.post("/login", UserController.getUserByEmail);
router.put("/update_pass", UserController.updatepass)

module.exports = router;
