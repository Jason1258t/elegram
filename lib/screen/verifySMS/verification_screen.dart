import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:messenger_test/screen/verifySMS/widget/text_field_verification.dart';
import 'package:messenger_test/utils/fonts.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../utils/assets.dart';
import '../auth/widget/button_phone.dart';
import '../auth/widget/search_Input_decoration.dart';
import '../auth/widget/validate_phone_number.dart';

class SMSVerificationScreen extends StatefulWidget {
  const SMSVerificationScreen({super.key});

  @override
  createState() => _SMSVerificationScreenState();
}

class _SMSVerificationScreenState extends State<SMSVerificationScreen> {
  final TextEditingController _smsController = TextEditingController();
  bool _isButtonActive = false;
  @override
  void initState() {
    super.initState();
    _smsController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    final phone = _smsController.text;
    final regex = RegExp(r'^\d{0,3}-?\d{0,3}$');
    setState(() {
      _isButtonActive = regex.hasMatch(phone);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              Lottie.asset(Assets.images('VerificationAnimation.json'),
                  height: 300),
              TextFieldVerification(
                controller: _smsController,
                decoration: buildInputDecoration(
                    labelText: 'SMS',
                    hintText: 'Typing your sms',
                    icon: Icons.message),
              ),
              const SizedBox(height: 16),
              PhoneButton(
                text: 'Verification',
                onPress: _isButtonActive ? () {} : null,
                isActive: _isButtonActive,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
