import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:messenger_test/screen/onboarding/widget/text_field_name.dart';

import '../../utils/assets.dart';
import '../auth/widget/button_phone.dart';
import '../auth/widget/search_Input_decoration.dart';

class CreateNewAccount extends StatefulWidget {
  const CreateNewAccount({super.key});

  @override
  createState() => _CreateNewAccountState();
}

final List<String> takenNames = ['Alice', 'Bob', 'Pidoras'];

class _CreateNewAccountState extends State<CreateNewAccount> {
  final TextEditingController _nameController = TextEditingController();
  final bool _isButtonActive = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    final name = _nameController.text;

    setState(() {});
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
              Lottie.asset(Assets.images('Username.json'),
                  height: 300,repeat: false),
              TextFieldName(
                controller: _nameController,
                decoration: buildInputDecoration(
                    labelText: 'Enter Your Username',
                    hintText: 'Username',
                    icon: Icons.people),
                takenNames: takenNames,
              ),
              const SizedBox(height: 16),
              PhoneButton(
                text: 'Sign Up',
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
