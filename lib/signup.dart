import 'package:flutter/material.dart';
import 'login.dart'; // تأكد من تعديل المسار حسب مكان ملف واجهة تسجيل الدخول

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? _gender; // متغير لتخزين الجنس
  final Color iconColor =
      const Color.fromARGB(118, 170, 0, 116); // اللون المستخدم للأيقونات

  bool _isPasswordVisible = false; // متغير للتحكم في إظهار كلمة المرور

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color.fromARGB(255, 255, 255, 255), // لون الخلفية الأبيض
      body: SingleChildScrollView(
        child: Column(
          children: [
            // صورة الخلفية
            Container(
              height: 100,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/images/1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // شعار التطبيق
            const Text(
              "Signed up",
              style: TextStyle(
                fontFamily: 'Pacifico', // استخدام الخط الثاني
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(150, 170, 0, 113),
              ),
            ),
            const SizedBox(height: 5),
            // حقل الاسم الأول
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                style: const TextStyle(fontFamily: 'Philosopher', fontSize: 16),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person,
                      color: iconColor), // تغيير لون الأيقونة
                  hintText: 'First Name',
                  filled: true,
                  fillColor: const Color.fromARGB(131, 240, 240, 240),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // حقل الاسم الأخير
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                style: const TextStyle(fontFamily: 'Philosopher', fontSize: 16),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person,
                      color: iconColor), // تغيير لون الأيقونة
                  hintText: 'Last Name',
                  filled: true,
                  fillColor: const Color.fromARGB(131, 240, 240, 240),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // حقل البريد الإلكتروني
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                style: const TextStyle(fontFamily: 'Philosopher', fontSize: 16),
                decoration: InputDecoration(
                  prefixIcon:
                      Icon(Icons.email, color: iconColor), // تغيير لون الأيقونة
                  hintText: 'Email',
                  filled: true,
                  fillColor: const Color.fromARGB(131, 240, 240, 240),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // حقل كلمة المرور مع أيقونة العين
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                style: const TextStyle(fontFamily: 'Philosopher', fontSize: 16),
                obscureText:
                    !_isPasswordVisible, // التحكم في إخفاء/إظهار كلمة المرور
                decoration: InputDecoration(
                  prefixIcon:
                      Icon(Icons.lock, color: iconColor), // أيقونة القفل
                  hintText: 'Password',
                  filled: true,
                  fillColor: const Color.fromARGB(118, 240, 240, 240),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility // أيقونة العين المفتوحة
                          : Icons.visibility_off, // أيقونة العين مع شحطة
                      color: iconColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible =
                            !_isPasswordVisible; // تغيير الحالة عند الضغط
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // حقل رقم الهاتف
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                style: const TextStyle(fontFamily: 'Philosopher', fontSize: 16),
                decoration: InputDecoration(
                  prefixIcon:
                      Icon(Icons.phone, color: iconColor), // تغيير لون الأيقونة
                  hintText: 'Phone Number',
                  filled: true,
                  fillColor: const Color.fromARGB(131, 240, 240, 240),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // حقل العنوان
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                style: const TextStyle(
                  fontFamily: 'Philosopher', // استخدام الخط الأول
                  fontSize: 16, // حجم الخط
                ),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.location_on,
                      color: iconColor), // تغيير لون الأيقونة
                  hintText: 'Address',
                  filled: true,
                  fillColor: const Color.fromARGB(131, 240, 240, 240),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // حقل تاريخ الميلاد
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                style: const TextStyle(
                  fontFamily: 'Philosopher', // استخدام الخط الأول
                  fontSize: 16, // حجم الخط
                ),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.calendar_today,
                      color: iconColor), // تغيير لون الأيقونة
                  hintText: 'Date of Birth',
                  filled: true,
                  fillColor: const Color.fromARGB(131, 240, 240, 240),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // خيار اختيار الجنس
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Radio(
                        value: 'male',
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value;
                          });
                        },
                        activeColor: const Color.fromARGB(
                            118, 170, 0, 116), // لون الدائرة عند الاختيار
                      ),
                      const Text('Male', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 'female',
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value;
                          });
                        },
                        activeColor: const Color.fromARGB(
                            118, 170, 0, 116), // لون الدائرة عند الاختيار
                      ),
                      const Text('Female', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // زر تسجيل الدخول
            ElevatedButton(
              onPressed: () {
                // تنقل المستخدم إلى صفحة تسجيل الدخول عند النقر على الزر
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) =>   const LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(150, 170, 0, 113),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 100),
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    fontFamily: 'Philosopher',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // رابط لتسجيل الدخول إذا كان لديك حساب
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontFamily: 'Philosopher',
                      fontSize: 20,
                      color: Color.fromARGB(255, 170, 0, 113),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
