import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'login.dart';
import 'HomePage.dart';
class UpdatePasswordScreen extends StatefulWidget {
  final String email; // إضافة البريد الإلكتروني كمتغير
  UpdatePasswordScreen({Key? key, required this.email}) : super(key: key);

  @override
  _UpdatePasswordScreenState createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
Future<void> updatePassword(String email, String password) async {
  final url = 'http://192.168.88.16:3001/auth/update_pass';

  try {
    final response = await http.put(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    ).timeout(const Duration(seconds: 10));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    print('Email: ${widget.email}');
    print('New Password: ${newPasswordController.text}');

    if (response.statusCode == 200) {
      print('Password updated successfully');
      // الانتقال إلى الصفحة الرئيسية بعد نجاح التحديث
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      print('Failed to update password: ${response.body}');
      _showError('Failed to update password. Please try again.');
    }
  } catch (e) {
    print('Error occurred: $e');
    _showError('An error occurred while updating the password. Please try again later.');
  }
}



  // دالة لعرض رسالة الخطأ
  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // تصميم الواجهة كما هو بدون تعديل
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/images/1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              "Update Password",
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(150, 170, 0, 113),
              ),
            ),
            SizedBox(height: 40),

            // حقل إدخال كلمة السر الجديدة
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: newPasswordController,
                obscureText: !_isNewPasswordVisible,
                style: TextStyle(
                  fontFamily: 'Philosopher',
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  labelText: "New Password",
                  prefixIcon: Icon(Icons.lock,
                      color: const Color.fromARGB(150, 170, 0, 113)),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isNewPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: const Color.fromARGB(150, 170, 0, 113),
                      size: 24,
                    ),
                    onPressed: () {
                      setState(() {
                        _isNewPasswordVisible = !_isNewPasswordVisible;
                      });
                    },
                  ),
                  filled: true,
                  fillColor: const Color.fromARGB(0, 0, 0, 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // حقل تأكيد كلمة السر
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: confirmPasswordController,
                obscureText: !_isConfirmPasswordVisible,
                style: TextStyle(
                  fontFamily: 'Philosopher',
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  prefixIcon: Icon(Icons.lock,
                      color: const Color.fromARGB(150, 170, 0, 113)),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isConfirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: const Color.fromARGB(150, 170, 0, 113),
                      size: 24,
                    ),
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                  ),
                  filled: true,
                  fillColor: const Color.fromARGB(131, 240, 240, 240),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),

            // زر تحديث كلمة السر
          // زر تحديث كلمة السر
ElevatedButton(
  onPressed: () {
    if (newPasswordController.text.isEmpty || confirmPasswordController.text.isEmpty) {
      _showError('Please fill in both fields.');
    } else if (newPasswordController.text != confirmPasswordController.text) {
      _showError('Passwords do not match.');
    } else {
      updatePassword(widget.email, newPasswordController.text); // تمرير البريد الإلكتروني وكلمة المرور الجديدة
    }
  },
  child: Text(
    "Update Password",
    style: TextStyle(
      fontFamily: 'Philosopher',
      fontSize: 20,
    ),
  ),
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color.fromARGB(118, 170, 0, 116),
    foregroundColor: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
  ),
),

          ],
        ),
      ),
    );
  }
}
