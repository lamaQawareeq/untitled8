import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:email_otp/email_otp.dart';
import 'ver_code.dart';
import 'dart:math'; // إضافة المكتبة لرؤية دالة العشوائية

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // إعدادات مكتبة Email OTP بدون appEmail و appPassword
  late EmailOTP emailOtp;

  @override
  void initState() {
    super.initState();
    // تهيئة EmailOTP هنا
    emailOtp = EmailOTP();
  }

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

            // حقل البريد الإلكتروني مع التحقق
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // حقل إدخال البريد الإلكتروني
                    TextFormField(
                      controller: emailController,
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
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 2),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),

            // زر إرسال رمز التحقق
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState != null &&
                    _formKey.currentState!.validate()) {
                  String userEmail = emailController.text;

                  // إنشاء رمز تحقق مكون من 4 أرقام
                  String otp = _generateOtp(4);

                  // محاولة إرسال OTP
                  try {
                    // إرسال OTP
                     bool success = await EmailOTP.sendOTP(email: userEmail);
                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("OTP has been sent")),
                      );
                      // الانتقال إلى واجهة إدخال كود التحقق
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VerificationCodeScreen(otpCode: otp)),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Failed to send OTP")),
                      );
                    }
                  } catch (e) {
                    print("Error sending OTP: $e");
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                              "Error sending OTP. Please try again later.")),
                    );
                  }
                }
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
              child: const Text(
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

  String _generateOtp(int length) {
    final random = Random();
    String otp = '';
    for (int i = 0; i < length; i++) {
      otp += random.nextInt(10).toString(); // الحصول على رقم عشوائي بين 0-9
    }
    return otp;
  }
}
