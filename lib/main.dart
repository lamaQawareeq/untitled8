import 'package:flutter/material.dart';
import 'login.dart'; // استيراد صفحة تسجيل الدخول

//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
void main() {
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
