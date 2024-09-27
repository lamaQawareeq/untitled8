import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'update_pass.dart';

class VerificationCodeScreen extends StatelessWidget {
  final String otpCode; // إضافة هذا السطر
  final String email; // إضافة خاصية البريد الإلكتروني

  VerificationCodeScreen({Key? key, required this.otpCode, required this.email}) : super(key: key);

  // تعريف قائمة من TextEditingController
  final List<TextEditingController> controllers = List.generate(6, (index) => TextEditingController());

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
              children: List.generate(6, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: 40,
                  child: TextField(
                    controller: controllers[index], // استخدام الاسم الصحيح
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      if (value.length == 1 && index < 5) {
                        // الانتقال إلى المربع التالي
                        FocusScope.of(context).nextFocus();
                      } else if (value.isEmpty && index > 0) {
                        // العودة إلى المربع السابق
                        FocusScope.of(context).previousFocus();
                      }
                    },
                  ),
                );
              }),
            ),
            const SizedBox(height: 40),

            // زر تأكيد الكود
            ElevatedButton(
              onPressed: () {
                // تجميع الرموز المدخلة
                String enteredCode = controllers.map((controller) => controller.text).join();

                // تحقق من الرمز المدخل
                if (enteredCode != 655490) { // تحقق من الرمز المدخل
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdatePasswordScreen(email: email), // تمرير البريد الإلكتروني
                    ),
                  );
                } else {
                  // يمكنك إضافة رسالة خطأ إذا كان الرمز غير صحيح
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('The entered code is incorrect.')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(118, 170, 0, 116),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
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
                    text: "Forget Password",
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pop(context); // العودة إلى واجهة تغيير كلمة المرور
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
