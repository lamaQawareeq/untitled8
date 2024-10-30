



const express = require('express');
const { UserController } = require('../controllers/authController');

const router = express.Router();
router.post("/updateprofile", UserController.getUserByEmails);
const multer = require('multer');
const upload = multer({ storage: multer.memoryStorage() }); 
router.post('/signup', UserController.signup);

router.post("/getProfilePicture", UserController.getProfilePicture);
router.post("/login", UserController.getUserByEmail);
router.put("/update_pass", UserController.updatepass);
router.get("/famous_foods/:countryId", UserController.getFamousFoods);
router.put("/updateProfile", upload.single('profile_image'), UserController.updateProfile); // إضافة multer
router.get('/comments/:foodId', UserController.getCommentsByFoodId);
router.post('/comments/add', UserController.addComment);
router.delete('/comments/delete/:commentId', UserController.deleteComment);

module.exports = router;


