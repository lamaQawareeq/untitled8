const db = require('../config/db');

class UserModel {
    // Static async method to get user by email
    static async getUserByEmail(email) {
        return new Promise((resolve, reject) => {
            db.query("SELECT * FROM login WHERE email = ?", [email], (error, results) => {
                if (error) {
                    return reject(error);
                }
                if (results.length > 0) {
                    resolve(results[0]);
                } else {
                    resolve(null);
                }
            });
        });
    }
}

module.exports = UserModel;
