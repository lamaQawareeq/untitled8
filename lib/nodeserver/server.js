const express = require('express');
const bodyParser = require('body-parser');
const authRoutes = require('./routes/authRoutes');  // استيراد المسارات

const app = express();
const port = 3001;

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.use('/auth', authRoutes); // استخدام المسارات

// تشغيل الخادم
app.listen(3001, '0.0.0.0', () => {
    console.log('Server is running on port 3001');
  });
  
