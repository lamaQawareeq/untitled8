import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // استيراد المكتبة

class LoginScreen extends StatelessWidget {
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
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/images/1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // شعار التطبيق مع نوع الخط الثاني
            Text(
              "Project Name",
              style: TextStyle(
                fontFamily: 'Pacifico', // استخدام الخط الثاني
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(150, 170, 0, 113),
              ),
            ),
            SizedBox(height: 40),

            // حقل اسم المستخدم مع نوع الخط الأول
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                style: TextStyle(
                  fontFamily: 'Philosopher', // استخدام الخط الأول
                  fontSize: 16, // حجم الخط
                ),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person), // أيقونة بدون تأثير
                  hintText: 'UserName',
                  filled: true,
                  fillColor: const Color.fromARGB(
                      131, 240, 240, 240), // اللون الرمادي الفاتح
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 40),

            // حقل كلمة المرور مع نوع الخط الأول
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                style: TextStyle(
                  fontFamily: 'Philosopher', // استخدام الخط الأول
                  fontSize: 16, // حجم الخط
                ),
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock), // أيقونة بدون تأثير
                  suffixIcon: GestureDetector(
                    onTap: () {
                      // هنا يمكنك إضافة الوظيفة لتغيير حالة إظهار كلمة المرور
                    },
                    child:
                        Icon(Icons.visibility_off), // أيقونة العين مع خط عليها
                  ),
                  hintText: 'Password',
                  filled: true,
                  fillColor: const Color.fromARGB(
                      118, 240, 240, 240), // اللون الرمادي الفاتح
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 10),

            // رابط "هل نسيت كلمة المرور" مع نوع الخط الخاص بزر تسجيل الدخول
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forget Your password?",
                    style: TextStyle(
                      fontFamily:
                          'Philosopher', // نفس الخط المستخدم في زر تسجيل الدخول
                      fontSize: 16, // نفس حجم الخط
                      color:
                          Theme.of(context).primaryColor, // إعادة اللون السابق
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),

            // زر تسجيل الدخول مع نوع الخط الأول
            ElevatedButton(
              onPressed: () {},
              child: Text(
                "Login",
                style: TextStyle(
                  fontFamily: 'Philosopher', // استخدام الخط الأول
                  fontSize: 20, // حجم الخط
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color.fromARGB(118, 170, 0, 116), // لون الزر
                foregroundColor: Colors.white, // لون النص الأبيض
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // شكل دائري
                ),
              ),
            ),

            SizedBox(height: 20),

            // رابط التسجيل مع نفس نوع الخط الخاص بزر تسجيل الدخول
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't Have An Account?",
                  style: TextStyle(
                    fontFamily:
                        'Philosopher', // نفس الخط المستخدم في زر تسجيل الدخول
                    fontSize: 16, // نفس حجم الخط
                    color: Colors.black, // لون النص
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                      fontFamily:
                          'Philosopher', // نفس الخط المستخدم في زر تسجيل الدخول
                      fontSize: 20, // نفس حجم الخط
                      color: const Color.fromARGB(255, 170, 0, 113), // لون النص
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),

            // أو مع نوع الخط الأول
            Text(
              "OR",
              style: TextStyle(
                fontFamily: 'Philosopher', // استخدام الخط الأول
                fontSize: 18, // حجم الخط
              ),
            ),

            SizedBox(height: 20),
            // شعارات وسائل التواصل الاجتماعي
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.facebook), // أيقونة الفيسبوك
                  onPressed: () {},
                  color: const Color.fromARGB(255, 170, 0, 113),
                  iconSize: 32, // حجم الأيقونة
                ),
                SizedBox(width: 30), // مسافة أفقية بين الفيسبوك وتويتر
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.twitter), // أيقونة تويتر
                  onPressed: () {},
                  color: const Color.fromARGB(255, 170, 0, 113),
                  iconSize: 32, // حجم الأيقونة
                ),
                SizedBox(width: 30), // مسافة أفقية بين تويتر والايميل
                IconButton(
                  icon: Icon(Icons.email), // أيقونة الايميل
                  onPressed: () {},
                  color: const Color.fromARGB(255, 170, 0, 113),
                  iconSize: 32, // حجم الأيقونة
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
