import 'package:flutter/material.dart';
import '../../../utils/colors.dart';
import '../../../utils/fonts.dart';

InputDecoration buildInputDecoration({
  String labelText = 'Search',
  String hintText = 'Start typing to search',
  Color labelColor = Colors.white,
  Color hintColor = Colors.white,
  Color iconColor = Colors.white,
  Color enabledBorderColor = Colors.white,
  Color focusedBorderColor = AppColors.activeButton,
  IconData icon = Icons.search,
}) {
  return InputDecoration(
    labelText: labelText,
    hintText: hintText,
    hintStyle: AppTypography.fontHeadlineW17w400.copyWith(color: hintColor),
    labelStyle: AppTypography.fontHeadlineW17w400.copyWith(color: labelColor),
    prefixIcon: Icon(
      icon,
      color: iconColor,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
          color: enabledBorderColor, width: 2, style: BorderStyle.solid),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    ),
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(
          color: Colors.red, width: 2, style: BorderStyle.solid),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    focusedErrorBorder:const OutlineInputBorder(
      borderSide: BorderSide(
          color: Colors.red, width: 2, style: BorderStyle.solid),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
          color: focusedBorderColor, width: 2, style: BorderStyle.solid),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    ),
  );
}
