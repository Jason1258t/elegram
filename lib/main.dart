import 'package:flutter/material.dart';
import 'package:messenger_test/screen/onboarding/onboarding.dart';
import 'package:messenger_test/utils/colors.dart';




void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Note App',
        theme: ThemeData(

          scaffoldBackgroundColor: AppColors.mainBackground,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const WelcomeScreen(),
        },
      );
  }
}
