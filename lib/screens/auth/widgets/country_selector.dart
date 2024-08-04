import 'package:flutter/material.dart';
import '../../../utils/colors.dart';
import '../../../utils/fonts.dart';

class CountrySelector extends StatelessWidget {
  final String selectedCountry;
  final String selectedCountryIso;
  final VoidCallback onTap;

  const CountrySelector({
    super.key,
    required this.selectedCountry,
    required this.selectedCountryIso,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(

      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: AppColors.activeButton, width: 2),
        ),
      ),
      width: double.infinity,
      child: InkWell(
        splashColor: AppColors.activeButton,
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Row(
            children: [
              selectedCountry == 'Error'
                  ? const SizedBox.shrink()
                  : Image.asset(
                      'icons/flags/png/$selectedCountryIso.png',
                      package: 'country_icons',
                      width: 24,
                      height: 24,
                    ),
              const SizedBox(width: 10),
              Text(
                selectedCountry == 'Error' ? 'Select Country' : selectedCountry,
                style: AppTypography.fontHeadlineW17w400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
