import 'package:flutter/material.dart';
import 'package:messenger_test/screen/auth/widget/phone_number.dart';
import 'package:country_picker/country_picker.dart';
import 'package:messenger_test/screen/auth/widget/validate_phone_number.dart';

import '../../../utils/fonts.dart';
import '../../../widgets/button/primary_button.dart';
import 'country_selector.dart';

class PhoneNumberInput extends StatefulWidget {
  const PhoneNumberInput({super.key});

  @override
  createState() => _PhoneNumberInputState();
}

class _PhoneNumberInputState extends State<PhoneNumberInput> {
  final TextEditingController _phoneController = TextEditingController();
  String _selectedCountry = 'Russia';
  String _selectedCountryCode = '+7';
  String _selectedCountryIso = 'ru';

  void _selectCountry(BuildContext context) {
    showCountryPicker(
      context: context,
      useSafeArea: true,
      showPhoneCode: true,
      onSelect: (Country country) {
        setState(() {
          _selectedCountry = country.name;
          _selectedCountryCode = '+${country.phoneCode}';
          _selectedCountryIso = country.countryCode.toLowerCase();
          _phoneController.clear();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CountrySelector(
            selectedCountry: _selectedCountry,
            selectedCountryIso: _selectedCountryIso,
            onTap: () => _selectCountry(context),
          ),
          const SizedBox(height: 16),
          PhoneNumber(
            phoneController: _phoneController,
            selectedCountryCode: _selectedCountryCode,
          ),
          const SizedBox(height: 16),
          PrimaryButton(
            text: 'Login',
            press: () {
              validatePhoneNumber(
                  context, '$_selectedCountryCode ${_phoneController.text}');
            },
          ),
        ],
      ),
    );
  }
}
