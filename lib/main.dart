import 'package:flutter/material.dart';
import 'screens/login.dart';

void main() {
  runApp(const PetCareApp());
}

class PetCareApp extends StatelessWidget {
  const PetCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PetCare',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF673D17),
          primary: const Color(0xFF673D17),
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7EEDD),
      ),
      home: const LoginScreen(),
    );
  }
}
