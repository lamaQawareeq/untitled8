import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final Color iconColor = const Color.fromARGB(118, 170, 0, 116);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text('Edit Profile',
            style: TextStyle(fontFamily: 'Philosopher', fontSize: 30)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // إضافة الصورة في بداية الواجهة
              Container(
                height: 100,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image:
                        AssetImage('lib/images/1.jpg'), // تأكد من مسار الصورة
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // SizedBox(height: 20),
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
                      color: iconColor,
                      onPressed: () {
                        // تنفيذ الكود لتعديل الصورة
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // حقل الاسم الأول
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  style:
                      const TextStyle(fontFamily: 'Philosopher', fontSize: 16),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person, color: iconColor),
                    hintText: 'First Name',
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
                ),
              ),
              // حقل الاسم الأخير
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  style:
                      const TextStyle(fontFamily: 'Philosopher', fontSize: 16),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person, color: iconColor),
                    hintText: 'Last Name',
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
                ),
              ),
              // حقل البريد الإلكتروني
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  style:
                      const TextStyle(fontFamily: 'Philosopher', fontSize: 16),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email, color: iconColor),
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
                ),
              ),
              // حقل رقم الهاتف
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  style:
                      const TextStyle(fontFamily: 'Philosopher', fontSize: 16),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone, color: iconColor),
                    hintText: 'Phone Number',
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
                ),
              ),
              // حقل العنوان
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  style:
                      const TextStyle(fontFamily: 'Philosopher', fontSize: 16),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.location_on, color: iconColor),
                    hintText: 'Address',
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
                ),
              ),
              const SizedBox(height: 20),
              // زر تعديل الملف الشخصي
              ElevatedButton(
                onPressed: () {
                  // تنفيذ الكود لتحديث الملف الشخصي
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(150, 170, 0, 113),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 100),
                  child: Text(
                    'Update Profile',
                    style: TextStyle(
                      fontFamily: 'Philosopher',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
