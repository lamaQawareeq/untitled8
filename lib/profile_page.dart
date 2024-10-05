import 'package:flutter/material.dart';
// تأكد من استيراد واجهة تعديل الملف الشخصي

import 'dart:convert';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  final String email;

  const ProfilePage({super.key, required this.email});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String firstName = '';
  String lastName = '';
  String? profileImage;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    print('Fetching data for email: ${widget.email}');
    try {
      var response = await http.post(
        Uri.parse(
            'http://10.0.2.2:3001/auth/updateprofile'), // تأكد من صحة الرابط
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': widget.email,
        }),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data); // اضف هذا السطر لطباعة البيانات
        setState(() {
          firstName =
              data['first_name'] ?? ''; // تأكد من أن الحقول موجودة في الاستجابة
          lastName = data['last_name'] ?? '';
        });
      } else {
          print('Failed to load user data, status code: ${response.statusCode}'); 
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    String? profileImage;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            fontFamily: 'Philosopher',
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.home),
          color: const Color.fromARGB(150, 170, 0, 113),
          iconSize: 37,
          onPressed: () {
            // تنفيذ ما تريده عند الضغط على أيقونة الصفحة الرئيسية
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.chat),
            color: const Color.fromARGB(150, 170, 0, 113),
            iconSize: 30,
            onPressed: () {
              // تنفيذ ما تريده عند الضغط على أيقونة الرسائل
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 90,
                  backgroundColor: Colors.grey[300],
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.grey[700],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      // يمكنك إضافة كود لتعديل الصورة هنا
                    },
                    color: const Color.fromARGB(150, 170, 0, 113),
                    iconSize: 30,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              '$firstName $lastName',
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                fontFamily: 'Philosopher',
              ),
            ),
            Text(
              widget.email,
              style: const TextStyle(
                fontSize: 20,
                fontFamily: 'Philosopher',
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
               // Navigator.push(
                 // context
                  //,
               //   MaterialPageRoute(
                   //   builder: (context) => const EditProfilePage()),
              //  );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(150, 170, 0, 113),
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Edit Profile',
                style: TextStyle(
                  fontFamily: 'Philosopher',
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 42),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.language,
                        color: Color.fromARGB(150, 170, 0, 113), size: 30),
                    title: const Text(
                      'Multi Language',
                      style: TextStyle(fontFamily: 'Philosopher', fontSize: 18),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        color: Color.fromARGB(150, 170, 0, 113), size: 30),
                    onTap: () {
                      // تنفيذ ما تريده عند الضغط على "Multi Language"
                    },
                  ),
                  const SizedBox(height: 14),
                  ListTile(
                    leading: const Icon(Icons.info,
                        color: Color.fromARGB(150, 170, 0, 113), size: 30),
                    title: const Text(
                      'Informations',
                      style: TextStyle(fontFamily: 'Philosopher', fontSize: 18),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        color: Color.fromARGB(150, 170, 0, 113), size: 30),
                    onTap: () {
                      // تنفيذ ما تريده عند الضغط على "Informations"
                    },
                  ),
                  const SizedBox(height: 14),
                  ListTile(
                    leading: const Icon(Icons.person,
                        color: Color.fromARGB(150, 170, 0, 113), size: 30),
                    title: const Text(
                      'About Us',
                      style: TextStyle(fontFamily: 'Philosopher', fontSize: 18),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        color: Color.fromARGB(150, 170, 0, 113), size: 30),
                    onTap: () {
                      // تنفيذ ما تريده عند الضغط على "About Us"
                    },
                  ),
                  const SizedBox(height: 14),
                  ListTile(
                    leading: const Icon(Icons.logout,
                        color: Color.fromARGB(150, 170, 0, 113), size: 30),
                    title: const Text(
                      'Log Out',
                      style: TextStyle(fontFamily: 'Philosopher', fontSize: 18),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        color: Color.fromARGB(150, 170, 0, 113), size: 30),
                    onTap: () {
                      // تنفيذ ما تريده عند الضغط على "Log Out"
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
