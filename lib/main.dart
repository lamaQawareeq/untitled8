import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // استيراد Firebase Core
import 'login.dart'; // استيراد صفحة تسجيل الدخول

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // إخفاء شارة الـ debug
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal, // تغيير اللون الرئيسي للتطبيق
      ),
      home: LoginScreen(), // تعيين صفحة تسجيل الدخول كصفحة البداية
    );
  }
}