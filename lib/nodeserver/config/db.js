const mysql = require('mysql');

// إعداد اتصال بقاعدة البيانات
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'softProj'
});

// الاتصال بقاعدة البيانات
db.connect((err) => {
    if (err) {
        console.error('Error connecting to the database:', err);
    } else {
        console.log('Connected to the database.');
    }
});

module.exports = db;
