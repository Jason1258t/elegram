
import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/fonts.dart';

InputDecoration buildInputDecoration() {
  return InputDecoration(
    labelText: 'Search',
    hintText: 'Start typing to search',
    hintStyle: AppTypography.fontHeadlineW17w400,
    labelStyle: AppTypography.fontHeadlineW17w400,
    prefixIcon: const Icon(
      Icons.search,
      color: Colors.white,
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide:
          BorderSide(color: Colors.white, width: 2, style: BorderStyle.solid),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
          color: AppColors.activeButton, width: 2, style: BorderStyle.solid),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  );
}
