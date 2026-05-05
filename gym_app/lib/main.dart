import 'package:flutter/material.dart';
// Note: Import your constants here once you start using them in the UI
// import 'package:gym_app/constants/app_constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Updated to your project identity
      title: 'Kihlot',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        // Using the primary color from your Event Hub requirements
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF9E2A2B),
          brightness: Brightness.light,
        ),
        // Applying your custom button height globally via theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(56.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0), // borderRadiusPill
            ),
          ),
        ),
      ),
      // Placeholder home screen to avoid router import errors for now
      home: const Scaffold(
        body: Center(
          child: Text(
            'Kihlot App',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
