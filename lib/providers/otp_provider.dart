import 'package:flutter/material.dart';

class OTPMismatchProvider with ChangeNotifier {
  bool _otpMismatch = false;

  bool get otpMismatch => _otpMismatch;

  void setOTPMismatch(bool value) {
    _otpMismatch = value;
    notifyListeners();
  }
}
