const db = require('../config/db');

class UserModel {
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
    static async updatepass(email, password) {
        return new Promise((resolve, reject) => {
            db.query('UPDATE login SET password = ? WHERE email = ?', [password, email], (error, result) => {
                if (error) {
                    return reject(error);
                }
                if (result.affectedRows > 0) {
                    resolve(true);
                } else {
                    resolve(false);
                }
            });
        });
    }

    static async getFamousFoodsByCountry(countryId) {
        return new Promise((resolve, reject) => {
            db.query(
                "SELECT name, ingredients, image_url AS image, comments FROM famous_foods WHERE country_id = ?",
                [countryId],
                (error, results) => {
                    if (error) {
                        return reject(error);
                    }
                    resolve(results);
                }
            );
        });
    }

    static async updateProfile(email, first_name, last_name, phone, address, imagePath) {
        return new Promise((resolve, reject) => {
            db.query("UPDATE login SET first_name = ?, last_name = ?, phone = ?, address = ?, profile_picture = ? WHERE email = ?", 
            [first_name, last_name, phone, address, imagePath, email], 
            (error, result) => {
                if (error) {
                    console.error("Error editing user:", error);
                    resolve(false); 
                } else {
                    resolve(true); 
                }
            });
        });
    }
    
    




static async getUserByEmails(email) {
    return new Promise((resolve, reject) => {
      db.query(
       'SELECT first_name, last_name, email FROM login WHERE email = ?',
        [email],
        (error, results) => {
          if (error) {
            return reject(error);
          }
          if (results.length > 0) {
            resolve(results[0]);
          } else {
            resolve(null);
          }
        }
      );
    });
  
 


} 
static async getUserByEmailss(email) {
    return new Promise((resolve, reject) => {
        db.query(
            'SELECT email, profile_picture FROM login WHERE email = ?',
            [email],
            (error, results) => {
                if (error) {
                    return reject(error);
                }
                if (results.length > 0) {
                    resolve(results[0]);
                } else {
                    resolve(null);
                }
            }
        );
    });
}


}

module.exports = UserModel;
