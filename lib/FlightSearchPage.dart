import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FlightSearchPage extends StatefulWidget {
  const FlightSearchPage({super.key});

  @override
  _FlightSearchPageState createState() => _FlightSearchPageState();
}

class _FlightSearchPageState extends State<FlightSearchPage> {
  final TextEditingController _countryCodeController = TextEditingController();
  List<dynamic> _flights = [];

  Future<void> _fetchFlights(String countryCode) async {
    if (countryCode.isEmpty) {
      // إظهار رسالة خطأ إذا كان حقل إدخال رمز الدولة فارغًا
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى إدخال رمز الدولة')),
      );
      return;
    }

    const String apiUrl = 'http://localhost:3001/flights'; // رابط الـ backend الخاص بك
    final response = await http.get(Uri.parse('$apiUrl?countryCode=$countryCode'));

    if (response.statusCode == 200) {
      setState(() {
        _flights = json.decode(response.body);
      });
    } else {
      // معالجة الخطأ
      print('فشل في تحميل الرحلات');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('فشل في تحميل الرحلات')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('بحث عن الرحلات')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _countryCodeController,
              decoration: const InputDecoration(
                labelText: 'رمز الدولة (مثل CAI)',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _fetchFlights(_countryCodeController.text);
              },
              child: const Text('بحث'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _flights.length,
                itemBuilder: (context, index) {
                  final flight = _flights[index];
                  return ListTile(
                    title: Text('رحلة: ${flight['flight']}, سعر: ${flight['price']}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
