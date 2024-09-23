const express = require('express');
const mysql = require('mysql');

const app = express();

// إنشاء اتصال باستخدام createConnection
const db = mysql.createConnection({
    host: "localhost", 
    user: "root",
    password: "",
    database: "softProj"
});

// الاتصال بقاعدة البيانات
db.connect((err) => {
    if (err) {
        console.error('Error connecting to database:', err);
    } else {
        console.log('Connected to database successfully');
    }
});

app.listen(3001, () => {
    console.log('Server is running now');
});

module.exports = db;
