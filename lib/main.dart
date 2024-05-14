import 'package:babysitter/screens/onboarding_screen/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:babysitter/theme/theme.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BabySitterApp',
      theme: lightMode,
      home: const OnboardingScreen(),
    );
  }
}
