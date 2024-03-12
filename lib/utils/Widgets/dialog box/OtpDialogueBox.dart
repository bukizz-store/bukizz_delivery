import 'package:flutter/material.dart';

class OTPDialog extends StatefulWidget {
  final Function(String) onOTPConfirmed;

  OTPDialog({required this.onOTPConfirmed});

  @override
  _OTPDialogState createState() => _OTPDialogState();
}

class _OTPDialogState extends State<OTPDialog> {
  late TextEditingController _otpController;

  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController();
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Enter OTP'),
      content: TextField(
        controller: _otpController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Enter OTP',
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            String otp = _otpController.text;
            if (otp.isNotEmpty) {
              widget.onOTPConfirmed(otp);
              Navigator.of(context).pop();
            } else {
              // Handle empty OTP input
              // You can show an error message or perform any other action
            }
          },
          child: Text('Confirm'),
        ),
      ],
    );
  }
}
