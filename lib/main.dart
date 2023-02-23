import 'package:doomi/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DoomiApp());
}

class DoomiApp extends StatelessWidget {
  const DoomiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}
