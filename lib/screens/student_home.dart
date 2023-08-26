import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({super.key});

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  late TextEditingController rollController = TextEditingController();
  late TextEditingController nameController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference students =
      FirebaseFirestore.instance.collection('students');

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
        body: Column(
          children: [
            TextFormField(
              controller: rollController,
              decoration: InputDecoration(hintText: 'Enter Roll No:'),
              // validator: (value) {
              //   if (condition) {

              //   }
              // },
            )
          ],
        ));
  }
}
