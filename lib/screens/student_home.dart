import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Response/utilities.dart';
import 'student_attendance.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({super.key, required this.userId});

  final String userId;

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  late TextEditingController rollController = TextEditingController();
  late TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference student =
      FirebaseFirestore.instance.collection('Students');

  late String userId = widget.userId;

  Future<void> addUserData(rollNo, name) {
    return student.doc(userId).update({
      'RollNo': rollNo,
      'Name': name,
    }).then((value) {
      Utilities().toastMessage('User Updated');
    }).catchError((e) => Utilities().toastMessage(e));
  }

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
        body: Form(
            key: _formKey,
            child: FutureBuilder<DocumentSnapshot>(
                future: student.doc(userId).get(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    Utilities().toastMessage('Something went wrong!');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  // var data = snapshot.data!.data();
                  // var rollNo = data!['RollNo'];
                  // var name = data['Name'];

                  return ListView(children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      child: TextFormField(
                        controller: rollController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Roll Number:',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter your Roll Number.';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      child: TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Name:',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter your Full Name.';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    ElevatedButton(
                      child: Text("Update Data"),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          var name = nameController.text;
                          var rollNo = rollController.text;
                          addUserData(rollNo, name);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StudentAttendance()));
                        }
                      },
                    )
                  ]);
                })));
  }
}
