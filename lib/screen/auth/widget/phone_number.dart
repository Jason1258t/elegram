import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utils/fonts.dart';

class PhoneNumber extends StatelessWidget {
  const PhoneNumber({
    super.key,
    required TextEditingController phoneController,
    required Map<String, String> countryCodes,
    required String selectedCountry,
  })  : _phoneController = phoneController,
        _countryCodes = countryCodes,
        _selectedCountry = selectedCountry;

  final TextEditingController _phoneController;
  final Map<String, String> _countryCodes;
  final String _selectedCountry;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      style: AppTypography.fontHeadlineW17w400,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        _PhoneNumberFormatter(),
      ],
      decoration: InputDecoration(
        prefixText: '${_countryCodes[_selectedCountry]} ',
        labelText: 'Phone Number',
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        hintText: '(***) *** **-**',
        hintStyle: AppTypography.fontHeadlineW17w400,
        labelStyle: AppTypography.fontHeadlineW17w400,
      ),
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

void validatePhoneNumber(BuildContext context, String phoneNumber) {
  final regex = RegExp(r'^\(\d{3}\) \d{3} \d{2}-\d{2}$');
  if (regex.hasMatch(phoneNumber)) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Phone number is valid')),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Phone number is invalid')),
    );
  }
}
