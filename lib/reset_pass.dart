import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'ver_code.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

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
              "Forget Password",
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(150, 170, 0, 113),
              ),
            ),
            const SizedBox(height: 40),

            // حقل البريد الإلكتروني
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                style: const TextStyle(
                  fontFamily: 'Philosopher',
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email),
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

            const SizedBox(height: 40),

            // زر إرسال رمز التحقق
            ElevatedButton(
              onPressed: () {
                // الانتقال إلى واجهة إدخال كود التحقق
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VerificationCodeScreen()),
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
                "Send Verification Code",
                style: TextStyle(
                  fontFamily: 'Philosopher',
                  fontSize: 20,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // رابط العودة إلى تسجيل الدخول
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontFamily: 'Philosopher',
                  fontSize: 20,
                  color: Colors.black,
                ),
                children: [
                  const TextSpan(text: "Back to "),
                  TextSpan(
                    text: "Login",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 170, 0, 113),
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pop(context);
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
