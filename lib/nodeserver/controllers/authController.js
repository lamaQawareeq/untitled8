const UserModel = require('../models/userModel');

class UserController {
    // دالة getUserByEmail لتحديد المستخدم عن طريق البريد الإلكتروني
    static async getUserByEmail(req, res) {
        const { email, password } = req.body;  // استرجاع البيانات
        try {
            // تحقق من البيانات هنا (مثلاً، من قاعدة البيانات)
            const user = await UserModel.getUserByEmail(email);

            if (user) {
                // تحقق من كلمة المرور هنا (يمكنك تشفير كلمة المرور للمقارنة)
                if (user.password === password) {
                    // تسجيل الدخول ناجح
                    res.status(200).json({ success: true, message: 'Login successful!' });
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
}
module.exports = { UserController };
