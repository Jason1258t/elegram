import 'package:flutter/material.dart';
import '../../../utils/colors.dart';
import '../../../utils/fonts.dart';

class PhoneButton extends StatelessWidget {
  final String text;
  final VoidCallback? press;
  final bool isActive;

  const PhoneButton({
    super.key,
    required this.text,
    required this.press,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: ShapeDecoration(
        color: isActive ? AppColors.activeButton : AppColors.buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),

        ),
      ),
      child: InkWell(
        onTap: isActive ? press : null,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.center,
          child: Text(
            text,
            style: AppTypography.fontHeadlineW17w400,
          ),
        ),
      ),
    );
  }
}
