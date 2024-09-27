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
    
        static async updatepass(email,password) {
            return new Promise((resolve, reject) => {
                db.query(
                    'UPDATE login SET password = ? WHERE email = ?',
                    [password, email],
                    (error, result) => {
                        if (error) {
                            return reject(error);
                        }
                        // تحقق مما إذا تم تحديث السجل بنجاح
                        if (result.affectedRows > 0) {
                            resolve(true);
                        } else {
                            resolve(false); // يعني أن المستخدم لم يُوجد
                        }
                    }
                );
            });
        }
    }
    
  


module.exports = UserModel;
