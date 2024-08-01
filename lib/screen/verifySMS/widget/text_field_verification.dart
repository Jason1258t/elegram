import 'package:flutter/cupertino.dart';
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
        FilteringTextInputFormatter.allow(RegExp(r'^\d{0,3}-?\d{0,3}$')),
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
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;

    if (text.length > 7) {
      return oldValue;
    }

    String newText = text;
    if (text.length > 3 ) {
      newText = '${text.substring(0, 3)}-${text.substring(3)}';
    }
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
