import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:messenger_test/utils/fonts.dart';


import '../../utils/assets.dart';
import 'widget/phone.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Lottie.asset(Assets.images('phone.json'),
                    height: 200, repeat: false),
                const SizedBox(
                  height: 22,
                ),
                Text(
                  'Login',
                  style: AppTypography.fontTitleW28w500,
                ),
                Text(
                  'To fully use our application,\nyou need to log in:',
                  style: AppTypography.fontHeadlineW17w400,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 22),
                const PhoneNumberInput(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
