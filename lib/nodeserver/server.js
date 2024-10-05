const express = require('express');
const bodyParser = require('body-parser');
const authRoutes = require('./routes/authRoutes');
const { UserController } = require('./controllers/authController');
const app = express();
const port = 3001;

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.use('/auth', authRoutes);
const multer = require('multer');
const upload = multer({ storage: multer.memoryStorage() });

app.put('/auth/updateProfile', upload.single('profile_picture'), UserController.updateProfile);

// تشغيل الخادم
app.listen(port, '0.0.0.0', () => {
    console.log(`Server is running on port ${port}`);
});
