import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:messenger_test/screens/onboarding/onboarding.dart';
import 'package:messenger_test/utils/colors.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        '/': (context) => const OboaringScreen(),
      },
    );
  }
}
