import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPDialog extends StatefulWidget {
  final Function(String) onOTPConfirmed;
  OTPDialog({required this.onOTPConfirmed});

  @override
  _OTPDialogState createState() => _OTPDialogState();
}

class _OTPDialogState extends State<OTPDialog> {

  late TextEditingController _otpController;
  final _formKey = GlobalKey<FormState>();

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
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _otpController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(6)],
          decoration: InputDecoration(
            hintText: 'Enter OTP',
          ),
          validator: (value) {
            if (value == null || value.isEmpty || value.length != 6) {
              return 'Enter a 6-digit OTP';
            }
            return null;
          },
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
            if (_formKey.currentState!.validate()) {
              String otp = _otpController.text;
              widget.onOTPConfirmed(otp);
              Navigator.of(context).pop();
            }
          },
          child: Text('Confirm'),
        ),
      ],
    );
  }
}
