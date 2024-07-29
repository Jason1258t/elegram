import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../utils/fonts.dart';

class PhoneNumber extends StatelessWidget {
  final TextEditingController phoneController;
  final String selectedCountryCode;

  const PhoneNumber({super.key,
    required this.phoneController,
    required this.selectedCountryCode,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: phoneController,
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        _PhoneNumberFormatter(),
      ],
      decoration: InputDecoration(
        prefixText: '$selectedCountryCode ',
        labelText: 'Phone Number',
        hintText: '(***) *** **-**',
        hintStyle: AppTypography.fontHeadlineW17w400,
        labelStyle: AppTypography.fontHeadlineW17w400,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 3, style: BorderStyle.solid),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      style: AppTypography.fontHeadlineW17w400,
    );
  }
}

class _PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final text = newValue.text;
    if (text.length > 10) {
      return oldValue;
    }
    StringBuffer buffer = StringBuffer();
    int index = 0;
    for (int i = 0; i < text.length; i++) {
      if (index == 0) buffer.write('(');
      if (index == 3) buffer.write(') ');
      if (index == 6) buffer.write(' ');
      if (index == 8) buffer.write('-');
      buffer.write(text[i]);
      index++;
    }
    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}

