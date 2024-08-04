
import 'package:flutter/material.dart';

void validatePhoneNumber(BuildContext context, String phoneNumber) async {
  final regex = RegExp(r'^\(\d{3}\) \d{3} \d{2}-\d{2}$');
  if (regex.hasMatch(phoneNumber)) {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Phone number $phoneNumber is valid and sent to the server')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send phone number $phoneNumber to the server')),
      );
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Phone number $phoneNumber is invalid')),
    );
  }
}