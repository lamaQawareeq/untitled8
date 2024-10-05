import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';
import 'HomePage.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final Color iconColor = const Color.fromARGB(118, 170, 0, 116);
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  String? _profileImage; // متغير لحفظ مسار الصورة
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _profileImage = pickedFile.path;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No image selected')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Permission denied to access storage')));
    }
  }

  Future<void> _updateProfile() async {
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String email = _emailController.text;
    int phone = int.tryParse(_phoneController.text) ?? 0; // Default to 0 if parsing fails
    String address = _addressController.text;

    if (email.isEmpty) {
      _showError('Please enter email');
      return;
    }

    const url = 'http://10.0.2.2:3001/auth/updateProfile';
    
    // إنشاء طلب HTTP مع الصورة
    try {
      var request = http.MultipartRequest('PUT', Uri.parse(url))
        ..fields['email'] = email
        ..fields['first_name'] = firstName
        ..fields['last_name'] = lastName
        ..fields['phone'] = phone.toString()
        ..fields['address'] = address;

      // إذا كانت الصورة موجودة، نضيفها للطلب
      if (_profileImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'profile_image',
          _profileImage!,
        ));
      }

      final response = await request.send();
      final responseBody = await http.Response.fromStream(response);

      if (response.statusCode == 200) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
      } else {
        var errorResponse = jsonDecode(responseBody.body);
        _showError(errorResponse['message'] ?? 'Update failed. Please try again.');
      }
    } catch (e) {
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
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(fontFamily: 'Philosopher', fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('lib/images/1.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Stack(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 90,
                      backgroundColor: Colors.grey[300],
                      child: _profileImage != null
                          ? ClipOval(
                              child: Image.file(
                                File(_profileImage!),
                                fit: BoxFit.cover,
                                width: 180,
                                height: 180,
                              ),
                            )
                          : const Icon(
                              Icons.person,
                              size: 50,
                              color: Color.fromARGB(164, 97, 97, 97),
                            ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: const CircleAvatar(
                        radius: 25,
                        backgroundColor: Color.fromARGB(255, 170, 0, 116),
                        child: Icon(Icons.edit, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  controller: _firstNameController,
                  style: const TextStyle(fontFamily: 'Philosopher', fontSize: 16),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person, color: iconColor),
                    hintText: 'First Name',
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  controller: _lastNameController,
                  style: const TextStyle(fontFamily: 'Philosopher', fontSize: 16),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person, color: iconColor),
                    hintText: 'Last Name',
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  controller: _emailController,
                  style: const TextStyle(fontFamily: 'Philosopher', fontSize: 16),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email, color: iconColor),
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  controller: _phoneController,
                  style: const TextStyle(fontFamily: 'Philosopher', fontSize: 16),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone, color: iconColor),
                    hintText: 'Phone Number',
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  controller: _addressController,
                  style: const TextStyle(fontFamily: 'Philosopher', fontSize: 16),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.location_on, color: iconColor),
                    hintText: 'Address',
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
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateProfile,
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          backgroundColor: const Color.fromARGB(150, 170, 0, 113),
                ),
                child: const Text('Update Profile', style: TextStyle(fontFamily: 'Philosopher', fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 
