import 'package:attendance_sys/Response/mobile_screen.dart';
import 'package:attendance_sys/Response/response.dart';
import 'package:attendance_sys/Response/web_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Responsive(mobileScreen: MobileScreen(), webScreen: WebScreen()),
      debugShowCheckedModeBanner: false,
    );
  }
}
