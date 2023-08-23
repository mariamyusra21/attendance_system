import 'package:attendance_sys/screens/login_Screen.dart';
import 'package:flutter/material.dart';

class WebScreen extends StatefulWidget {
  const WebScreen({super.key});

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  @override
  Widget build(BuildContext context) {
    return LoginScreen();
  }
}
