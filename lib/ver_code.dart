import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'update_pass.dart';

class VerificationCodeScreen extends StatelessWidget {
  const VerificationCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // صورة الخلفية
            Container(
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/images/1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // شعار التطبيق
            Padding(
              padding: const EdgeInsets.all(20),
              child: Image.asset(
                'lib/images/q1.jpeg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 120,
              ),
            ),
            const SizedBox(height: 30),

            // عنوان التطبيق
            const Text(
              "Enter Verification Code",
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(150, 170, 0, 113),
              ),
            ),
            const SizedBox(height: 40),

            // مربعات إدخال كود التحقق
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: 60,
                  child: const TextField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 40),

            // زر تأكيد الكود
            // زر تأكيد الكود
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          UpdatePasswordScreen()), // الانتقال إلى واجهة تحديث كلمة السر
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(118, 170, 0, 116),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                "Confirm Code",
                style: TextStyle(
                  fontFamily: 'Philosopher',
                  fontSize: 20,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // رابط العودة إلى واجهة تغيير كلمة المرور
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontFamily: 'Philosopher',
                  fontSize: 22, // حجم "Reset Password"
                  color: Color.fromARGB(255, 170, 0, 113), // اللون الزهري
                ),
                children: [
                  const TextSpan(
                    text: "Back to ",
                    style: TextStyle(
                      fontSize: 20, // حجم "Back to"
                      color: Colors.black, // اللون الأسود
                    ),
                  ),
                  TextSpan(
                    text: "Foreget Password",
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pop(
                            context); // العودة إلى واجهة تغيير كلمة المرور
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
