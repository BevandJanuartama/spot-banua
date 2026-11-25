import 'package:flutter/material.dart';
import 'package:spotbanua/pages/admin/mainnavigation.dart';
// import 'pages/splash_screen.dart'; // nanti aktifkan ini kalau splashnya sudah siap
import 'package:firebase_core/firebase_core.dart';
import 'pages/admin/crud/firebase_options.dart'; // auto-generated file dari Firebase CLI

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // memastikan binding Flutter siap sebelum async code
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const SpotBanuaApp());
}

class SpotBanuaApp extends StatelessWidget {
  const SpotBanuaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpotBanua',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      home: const MainNavigation(),
      // Kalau splash screen sudah siap, ganti ke:
      // home: const SplashScreen(),
    );
  }
}
