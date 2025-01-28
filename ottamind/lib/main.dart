import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:ottamind/pages/splash.dart';
import 'package:ottamind/screens/splash.dart';
//import 'package:travel_guide/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Guide',
      theme: ThemeData(
        primaryColor: const Color(0xFF4156A3),
        scaffoldBackgroundColor: const Color(0xFF292929),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF4156A3),
          secondary: Color(0xFFF0EA99),
          tertiary: Color(0xFF24848D),
          surface: Color(0xFFB1E3D3),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      home: const SplashScreen()
    );
  }
}