import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/fonts.dart';

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