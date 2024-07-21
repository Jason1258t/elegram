import 'package:flutter/material.dart';

import 'colors.dart';

class AppAnimations {
  static const circleIndicator = SizedBox(
    width: 20,
    height: 20,
    child: CircularProgressIndicator(
      color: AppColors.primary,
    ),
  );

  static const bigCircleIndicator = SizedBox(
    width: 40,
    height: 40,
    child: CircularProgressIndicator(
      color: AppColors.primary,
      strokeWidth: 2,
    ),
  );
}
