import 'package:flutter/material.dart';
import 'models/pet_data.dart';
import 'screens/login.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PetDataStore.loadFromStorage();
  runApp(const PetCareApp());
}

class PetCareApp extends StatelessWidget {
  const PetCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Check if user is already logged in from previous session
    final bool isAlreadyLoggedIn = PetDataStore.currentUserAccount != null;

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
      home: isAlreadyLoggedIn ? const HomeScreen() : const LoginScreen(),
    );
  }
}
