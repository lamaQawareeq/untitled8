const express = require('express');
const bodyParser = require('body-parser');
const authRoutes = require('.\backend\screen/routes/authRoutes');  // استيراد المسارات

const app = express();
const port = 3001;

app.use(bodyParser.json());

// استخدام نقاط النهاية الخاصة بتسجيل الدخول
app.use('/auth', authRoutes);

// تشغيل الخادم
app.listen(port, () => {
    console.log(`Server running on http://localhost:${port}`);
});
