import 'package:flutter/material.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({super.key});

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("STUDENTS HOME PAGE",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            )),
        backgroundColor: Colors.lightGreen,
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}
