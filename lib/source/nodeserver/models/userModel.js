const db = require('../config/db');

// وظيفة للتحقق من بيانات المستخدم
const findUserByEmailAndPassword = (email, password, callback) => {
    const query = 'SELECT * FROM login WHERE email = ? AND password = ?';
    db.query(query, [email, password], (err, results) => {
        if (err) {
            return callback(err, null);
        }
        if (results.length > 0) {
            return callback(null, results[0]);
        } else {
            return callback(null, null);
        }
    });
};

module.exports = { findUserByEmailAndPassword };
