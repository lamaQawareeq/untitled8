import 'package:flutter/material.dart';

class OtpProvider with ChangeNotifier {
  String _otpCode = '';

  String get otpCode => _otpCode;

  void setOtpCode(String code) {
    _otpCode = code;
    notifyListeners();
  }
}
