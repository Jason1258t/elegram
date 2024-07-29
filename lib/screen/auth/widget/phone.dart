import 'package:flutter/material.dart';
import 'package:messenger_test/screen/auth/widget/phone_number.dart';



import '../../../data/fetchCountryData.dart';
import '../../../widgets/button/primary_button.dart';
import 'country_dropdown.dart';

class PhoneNumberInput extends StatefulWidget {
  const PhoneNumberInput({super.key});

  @override
  createState() => _PhoneNumberInputState();
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
            press: () {
              validatePhoneNumber(context, _phoneController.text);
            },
          ),
        ],
      ),
    );
  }


}
