const UserModel = require('../models/userModel');
const { validationResult } = require("express-validator");

class UserController {
    static async getUserByEmail(req, res) {
        const { email, password } = req.body;
        try {
            const user = await UserModel.getUserByEmail(email);
            if (user) {
                if (user.password === password) {
                    if (user.role === 'admin') {
                        res.status(200).json({ success: true, message: 'Login successful! You are an admin.' });
                    } else {
                        res.status(200).json({ success: true, message: 'Login successful! You are a user.' });
                    }
                } else {
                    res.status(401).json({ success: false, message: 'Incorrect password.' });
                }
            } else {
                res.status(404).json({ success: false, message: 'User not found.' });
            }
        } catch (error) {
            console.error("Error during login:", error);
            res.status(500).json({ success: false, message: 'Internal Server Error' });
        }
    }

    static async updatepass(req, res) {
        const { email, password } = req.body;

        if (!email || !password) {
            return res.status(400).send("Email and new password are required");
        }

        try {
            const result = await UserModel.updatepass(email, password);
            if (result) {
                return res.status(200).send("Password updated successfully");
            } else {
                return res.status(404).send("User not found or password update failed");
            }
        } catch (error) {
            console.error("Error during password update:", error);
            return res.status(500).send("Internal server error");
        }
    }

    static async getFamousFoods(req, res) {
        const { countryId } = req.params;
        try {
            const foods = await UserModel.getFamousFoodsByCountry(countryId);
            if (foods.length > 0) {
                res.status(200).json({ success: true, data: foods });
            } else {
                res.status(404).json({ success: false, message: 'No foods found for this country.' });
            }
        } catch (error) {
            console.error("Error fetching famous foods:", error);
            res.status(500).json({ success: false, message: 'Internal Server Error' });
        }
    }

    static async updateProfile(req, res) {
        const { email, first_name, last_name, phone, address } = req.body;
        const profileImage = req.file; // الحصول على الصورة المرفوعة
    
        const user = await UserModel.getUserByEmail(email);
        if (!user) {
            return res.status(400).send("User not found !!!");
        }
    
        if (user.email !== email) {
            return res.status(400).send("Email is required");
        }
    
        try {
            let imagePath = null;
            if (profileImage) {
                // يمكنك حفظ الصورة هنا في مسار معين
                imagePath = `path/to/images/${profileImage.originalname}`; // عدل المسار حسب الحاجة
                // fs.writeFileSync(imagePath, profileImage.buffer); // حفظ الصورة إذا كنت تستخدم التخزين المحلي
            }
    
            const result = await UserModel.updateProfile(email, first_name, last_name, phone, address, imagePath);
            if (result) {
                return res.status(200).send("Profile updated successfully");
            } else {
                return res.status(404).send("User not found or update failed");
            }
        } catch (error) {
            console.error("Error during profile update:", error);
            return res.status(500).send("Internal server error");
        }
    }
    
    
    static async getUserByEmails(req, res) {
        const { email } = req.body;
        try {
            const user = await UserModel.getUserByEmails(email);
            if (user) {
                res.status(200).json({
                    first_name: user.first_name,
                    last_name: user.last_name,
                    email: user.email,
                    //profile_picture: user.profile_picture // Include the profile picture in the response
                });
            } else {
                res.status(404).json({ message: 'User not found' });
            }
        } catch (error) {
            console.error('Error fetching user:', error);
            res.status(500).json({ message: 'Internal Server Error' });
        }
    }
    static async updateProfiles(req, res) {
        const { email, first_name, last_name, phone, address } = req.body;
        let profilePicturePath = req.file ? `path/to/images/${req.file.filename}` : null; // مسار الصورة إذا كانت موجودة
    
        try {
            // قم بتحديث المستخدم في قاعدة البيانات مع المسار الجديد للصورة
            await UserModel.updateUserProfile(email, first_name, last_name, phone, address, profilePicturePath);
            res.status(200).json({ message: 'Profile updated successfully' });
        } catch (error) {
            console.error('Error updating profile:', error);
            res.status(500).json({ message: 'Internal Server Error' });
        }
    }
    static async getProfilePicture(req, res) {
        const { email } = req.query; // الحصول على البريد الإلكتروني من الاستعلام
        try {
            const user = await UserModel.getUserByEmailss(email);
            if (user) {
                res.status(200).json({ profile_picture: user.profile_picture });
            } else {
                res.status(404).json({ message: 'User not found' });
            }
        } catch (error) {
            console.error('Error fetching user profile picture:', error);
            res.status(500).json({ message: 'Internal Server Error' });
        }
    }

    static async getCommentsByFoodId(req, res) {
        const { foodId } = req.params;
        const { email } = req.body; // الحصول على البريد الإلكتروني من الطلب
    
        try {
            const comments = await UserModel.getCommentsByFoodId(foodId);
            if (comments.length > 0) {
                // احصل على اسم المستخدم من البريد الإلكتروني
                const user = await UserModel.getUserByEmail(email);
                const username = user ? user.first_name : null;
    
                // إضافة أيقونة سلة المهملات إلى التعليقات التي تخص المستخدم
                const commentsWithDeleteIcon = comments.map(comment => {
                    return {
                        ...comment,
                        showDeleteIcon: `${comment.first_name} ${comment.last_name}` === username // تحقق مما إذا كان اسم المستخدم يطابق
                    };
                });
    
                res.status(200).json({ success: true, data: commentsWithDeleteIcon });
            } else {
                res.status(404).json({ success: false, message: 'لا توجد تعليقات لهذا العنصر الغذائي.' });
            }
        } catch (error) {
            console.error("Error fetching comments:", error);
            res.status(500).json({ success: false, message: 'خطأ داخلي في الخادم' });
        }
    }
    
    static async addComment(req, res) {
        const { email, food_id, comment } = req.body;

        try {
            // احصل على userId من البريد الإلكتروني
            const user = await UserModel.getUserByEmail(email);
            if (!user) {
                return res.status(404).json({ error: 'User not found' });
            }

            const userId = user.id;

            // أضف التعليق إلى قاعدة البيانات
            const result = await UserModel.addComment(userId, food_id, comment);
            if (result) {
                return res.status(201).json({ message: 'Comment added successfully' });
            } else {
                return res.status(500).json({ error: 'Failed to add comment' });
            }
        } catch (error) {
            console.error(error);
            return res.status(500).json({ error: 'Internal server error' });
        }
    }
    static async deleteComment(req, res) {
        const { commentId } = req.params; // الحصول على commentId من معلمات الطلب
        
        try {
            const result = await UserModel.deleteComment(commentId);
            if (result) {
                return res.status(200).json({ message: 'Comment deleted successfully' });
            } else {
                return res.status(404).json({ message: 'Comment not found or delete failed' });
            }
        } catch (error) {
            console.error('Error deleting comment:', error);
            return res.status(500).json({ message: 'Internal Server Error' });
        }
    }
    static async signup(req, res) {
        const { first_name, last_name, email, password, phone_number, address, date_of_birth, gender } = req.body;

        try {
            // تشفير كلمة المرور
          //  const hashedPassword = await bcrypt.hash(password, 10);

            // إضافة المستخدم لقاعدة البيانات
            const result = await UserModel.createUser(first_name,last_name, email, password, phone_number, address, date_of_birth, gender);

            // تحقق من نجاح العملية
            if (result) {
                res.send("add success"); // إذا كانت النتيجة غير فارغة، تعتبر العملية ناجحة
            } else {
                res.send("add failed");
            }
        } catch (error) {
            // التعامل مع الأخطاء
            console.error('Error during signup:', error);
            res.status(500).send("An error occurred during signup."); // إرسال رسالة خطأ
        }
    }
    
}



module.exports = { UserController };
