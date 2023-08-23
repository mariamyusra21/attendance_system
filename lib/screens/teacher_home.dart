import 'package:flutter/material.dart';

class TeacherHomePage extends StatefulWidget {
  const TeacherHomePage({super.key});

  @override
  State<TeacherHomePage> createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TEACHER HOME PAGE",
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
