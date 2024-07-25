import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../data/fetchCountryData.dart';
import '../../../utils/colors.dart';
import '../../../utils/fonts.dart';
import '../../../widgets/button/primary_button.dart';

class PhoneNumberInput extends StatefulWidget {
  const PhoneNumberInput({super.key});

  @override
  _PhoneNumberInputState createState() => _PhoneNumberInputState();
}

class _PhoneNumberInputState extends State<PhoneNumberInput> {
  final TextEditingController _phoneController = TextEditingController();
  String _selectedCountry = 'Error';
  Map<String, String> _countryCodes = {};

  @override
  void initState() {
    super.initState();
    fetchCountryData().then((data) {
      setState(() {
        _countryCodes = data;
        _selectedCountry = data.keys.first;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CountryDropdown(
            countries: _countryCodes.keys.toList(),
            selectedCountry: _selectedCountry,
            onCountryChanged: (newCountry) {
              setState(() {
                _selectedCountry = newCountry;
              });
            },
          ),
          const SizedBox(height: 16),
          PhoneNumber(
              phoneController: _phoneController,
              countryCodes: _countryCodes,
              selectedCountry: _selectedCountry),
          const SizedBox(height: 16),
          PrimaryButton(
            text: 'Login',
            press: _validatePhoneNumber,
          ),
        ],
      ),
    );
  }

  void _validatePhoneNumber() {
    final phone = _phoneController.text;
    final regex = RegExp(r'^\(\d{3}\) \d{3} \d{2}-\d{2}$');
    if (regex.hasMatch(phone)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Phone number is valid')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Phone number is invalid')),
      );
    }
  }
}

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
        PhoneNumberFormatter(),
      ],
      decoration: InputDecoration(
        prefixText: '${_countryCodes[_selectedCountry]} ',
        labelText: 'Phone Number',
        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
        hintText: '(***) *** **-**',
        hintStyle: AppTypography.fontHeadlineW17w400,
        labelStyle: AppTypography.fontHeadlineW17w400,
      ),
    );
  }
}

class CountryDropdown extends StatelessWidget {
  final List<String> countries;
  final String selectedCountry;
  final ValueChanged<String> onCountryChanged;

  const CountryDropdown({
    super.key,
    required this.countries,
    required this.selectedCountry,
    required this.onCountryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedCountry,
      onChanged: (String? newValue) {
        onCountryChanged(newValue!);
      },
      dropdownColor: AppColors.buttonColor,
      items: countries.map<DropdownMenuItem<String>>((String country) {
        return DropdownMenuItem<String>(
          value: country,
          child: Row(
            children: [
              const SizedBox(width: 8),
              Text(
                country,
                style: AppTypography.fontHeadlineW17w400,
              ),
            ],
          ),
        );
      }).toList(),
      decoration: InputDecoration(
        labelText: 'Country',
        labelStyle: AppTypography.fontHeadlineW17w400,
        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
      ),
    );
  }
}

class PhoneNumberFormatter extends TextInputFormatter {
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
