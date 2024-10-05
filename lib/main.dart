import 'package:flutter/material.dart';
// استيراد Firebase Core
import 'login.dart'; // استيراد صفحة تسجيل الدخول

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // إخفاء شارة الـ debug
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal, // تغيير اللون الرئيسي للتطبيق
      ),
      home:  const LoginScreen(), // تعيين صفحة تسجيل الدخول كصفحة البداية
    );
  }
}