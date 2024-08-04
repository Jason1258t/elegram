import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:messenger_test/utils/colors.dart';
import 'package:messenger_test/utils/fonts.dart';

import 'button_phone.dart';
import 'country_selector.dart';
import 'phone_number.dart';
import 'search_input_decoration.dart';
import 'validate_phone_number.dart';

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
  bool _isButtonActive = false;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    final phone = _phoneController.text;
    final regex = RegExp(r'^\(\d{3}\) \d{3} \d{2}-\d{2}$');
    setState(() {
      _isButtonActive = regex.hasMatch(phone);
    });
  }

  void _selectCountry(BuildContext context) {
    showCountryPicker(
      context: context,
      useSafeArea: true,
      showPhoneCode: true,
      countryListTheme: CountryListThemeData(
        padding: const EdgeInsets.all(11),
        bottomSheetHeight: MediaQuery.of(context).size.height*0.65,
        backgroundColor: AppColors.mainBackground,
        textStyle: AppTypography.fontHeadlineW17w400,
        searchTextStyle: AppTypography.fontHeadlineW17w400,
        inputDecoration: buildInputDecoration(),
      ),
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
          PhoneButton(
            text: 'Login',
            onPress: _isButtonActive
                ? () {
                    validatePhoneNumber(context,
                        '$_selectedCountryCode ${_phoneController.text}');
                  }
                : null,
            isActive: _isButtonActive,
          ),
        ],
      ),
    );
  }
}
