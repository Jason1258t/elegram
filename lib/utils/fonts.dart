import 'package:flutter/material.dart';

import 'colors.dart';

abstract class AppTypography {
  static const _font = TextStyle(
    fontFamily: 'Roboto',
    color: AppColors.textColor,
  );

  static final fontTitle28w500 = _font.copyWith(
    fontSize: 28,
    fontWeight: FontWeight.w500,
  );
  static final fontTitleW28w500 = _font.copyWith(
    color: Colors.white,
    fontSize: 28,
    fontWeight: FontWeight.w500,
  );
  static final fontTitle20w500 = _font.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );
  static final fontTitle17w500 = _font.copyWith(
    fontSize: 17,
    fontWeight: FontWeight.w500,
  );
  static final fontHeadline17w400 = _font.copyWith(
    fontSize: 17,
    fontWeight: FontWeight.w400,
  );

  static final fontHeadlineW17w400 = _font.copyWith(
    color: Colors.white,
    fontSize: 17,
    fontWeight: FontWeight.w400,
  );

  static final fontHeadlineBlue17w400 = _font.copyWith(
    color: AppColors.activeButton,
    fontSize: 17,
    fontWeight: FontWeight.w400,
  );

  static final fontHeadline16w500 = _font.copyWith(
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );
  static final fontHeadline15w500 = _font.copyWith(
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );

  static final fontRegular16w400 = _font.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
  static final fontRegular15w400 = _font.copyWith(
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );
  static final fontRegular14w400 = _font.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static final fontSubtitle14w500 = _font.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static final fontSubtitle13w400 = _font.copyWith(
    fontSize: 13,
    fontWeight: FontWeight.w400,
  );
  static final fontSubtitleW13w400 = _font.copyWith(
    color: Colors.white,
    fontSize: 13,
    fontWeight: FontWeight.w400,
  );
  static final fontCaption13w500 = _font.copyWith(
    fontSize: 13,
    fontWeight: FontWeight.w500,
  );
  static final fontCaption12w400 = _font.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static final fontCaption11w400 = _font.copyWith(
    fontSize: 11,
    fontWeight: FontWeight.w400,
  );
  static final fontCaption11w500 = _font.copyWith(
    fontSize: 11,
    fontWeight: FontWeight.w500,
  );
}
