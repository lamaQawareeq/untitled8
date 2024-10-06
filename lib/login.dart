import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';
import 'signup.dart';
import 'reset_pass.dart';
import 'EditProfilePage.dart'; 
import 'FoodPage.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Function to get device ID
  Future<String> _getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.id; // This will return the device ID
  }

  Future<void> _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showError('Please enter both email and password.');
      return;
    }

    print('Attempting to log in with email: $email'); // إضافة طباعة هنا

    try {
      var response = await http.post(
        Uri.parse(
            'http://10.0.2.2:3001/auth/login'), // تأكد من صحة هذا الرابط
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      print('Response status: ${response.statusCode}'); // إضافة طباعة هنا
      print('Response body: ${response.body}'); // إضافة طباعة هنا

      if (response.statusCode == 200) {
        // إذا كانت حالة الاستجابة 200 (نجاح)
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
          //  builder: (context) => ProfilePage(email: email),
              // builder: (context) =>  EditProfilePage(),
              //builder: (context) => HomePage()
             builder: (context) =>   MyMenuScreen(email: email), 
              ), // انتقل إلى صفحة الرئيسية
        );
      } else {
        // إذا كانت هناك مشكلة
        var errorResponse = jsonDecode(response.body);
        _showError(
            errorResponse['message'] ?? 'Login failed. Please try again.');
      }
    } catch (e) {
      print('Error occurred: $e');
      _showError('An error occurred: $e');
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
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
            Container(
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/images/1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Text(
              "Project Name",
              style: TextStyle(
               fontFamily: 'Pacifico',

                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(150, 170, 0, 113),
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _emailController,
                style: const TextStyle(
                   fontFamily: 'Philosopher',
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email),
                  hintText: 'Your Email',
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _passwordController,
                style: const TextStyle(
                   fontFamily: 'Philosopher',
                  fontSize: 16,
                ),
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    child: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                  hintText: 'Password',
                  filled: true,
                  fillColor: const Color.fromARGB(118, 240, 240, 240),
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
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ResetPasswordScreen()),
                    );
                  },
                  child: const Text(
                    "Forget Your password?",
                    style: TextStyle(
                      fontFamily: 'Philosopher',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(118, 170, 0, 116),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ), // استدعاء دالة تسجيل الدخول
              child: const Text(
                "Login",
                style: TextStyle(
                  fontFamily: 'Philosopher',
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't Have An Account?",
                  style: TextStyle(
                    fontFamily: 'Philosopher',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUpScreen()),
                    );
                  },
                  child: const Text(
                    "Sign up",
                    style: TextStyle(
                      fontFamily: 'Philosopher',
                      fontSize: 20,
                      color: Color.fromARGB(255, 170, 0, 113),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              "OR",
              style: TextStyle(
                fontFamily: 'Philosopher',
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.facebook),
                  onPressed: () {
                    
                  },
                  color: const Color.fromARGB(255, 170, 0, 113),
                  iconSize: 32,
                ),
                const SizedBox(width: 30),
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.twitter),
                  onPressed: () {},
                  color: const Color.fromARGB(255, 170, 0, 113),
                  iconSize: 32,
                ),
                const SizedBox(width: 30),
                IconButton(
                  icon: const Icon(Icons.email),
                  onPressed: () {},
                  color: const Color.fromARGB(255, 170, 0, 113),
                  iconSize: 32,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}