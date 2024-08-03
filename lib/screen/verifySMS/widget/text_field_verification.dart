import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:messenger_test/utils/fonts.dart';

class TextFieldVerification extends StatelessWidget {
  final TextEditingController controller;
  final InputDecoration decoration;

  const TextFieldVerification({
    super.key,
    required this.controller,
    required this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: decoration,
      textAlign: TextAlign.center,
      inputFormatters: [
        LengthLimitingTextInputFormatter(7), // maximum length including hyphen
        _PhoneNumberFormatter(),
      ],
      keyboardType: TextInputType.number,
      style: AppTypography.fontHeadlineW17w400,
    );
  }
}

class _PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {

    final String newText = newValue.text;

    if (newText.length > 7) {
      return oldValue;
    }


    final String digitsOnly = newText.replaceAll(RegExp(r'\D'), '');


    String formattedText;
    if (digitsOnly.length <= 3) {
      formattedText = digitsOnly;
    } else {
      formattedText = '${digitsOnly.substring(0, 3)}-${digitsOnly.substring(3)}';
    }


    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
