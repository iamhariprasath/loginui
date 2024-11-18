import 'package:flutter/material.dart';
import 'constant.dart';
import 'login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Ensure Firebase is initialized before runApp
  runApp(const InitialScreen());
}

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LoginScreen(),
      title: appName, // Ensure `appName` is defined in `constant.dart`
      debugShowCheckedModeBanner: false,
    );
  }
}
