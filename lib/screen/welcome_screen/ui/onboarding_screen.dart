
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:messenger_test/utils/fonts.dart';

import '../../../utils/assets.dart';
import '../../signin_or_signup/ui/signin_or_signup_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 70,
            ),
            Lottie.asset(Assets.images('Welcome.json')),
            Text("Welcome to our freedom \nmessaging app",
                textAlign: TextAlign.center,
                style: AppTypography.fontTitleW28w500),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Freedom talk any person of your \nmother language.",
              textAlign: TextAlign.center,
              style: AppTypography.fontSubtitleW13w400,
            ),
            const Spacer(),
            SizedBox(
              width: 100,
              child: TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SigninOrSignupScreen(),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Skip", style: AppTypography.fontSubtitleW13w400),
                      const SizedBox(width: 20 / 4),
                      const Icon(Icons.arrow_forward_ios,
                          size: 16, color: Colors.white)
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
