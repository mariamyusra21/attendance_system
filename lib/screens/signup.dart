import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Response/utilities.dart';
import '../widgets/round_button.dart';
import 'login_Screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool loading = false;
  late String name = '';
  late String email = '';
  late String password = '';
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference students =
      FirebaseFirestore.instance.collection('students');

  // createUser(StudentModel student) async {
  //   await students.add(student.toJson()).whenComplete(() {
  //     Utilities().toastMessage('User Added');
  //   }).catchError((e) {
  //     Utilities().toastMessage(e);
  //   });
  createUser() {
    _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      FirebaseFirestore.instance
          .collection('Users')
          .doc(value.user?.uid)
          .set({'email': value.user?.email});
      Utilities().toastMessage('User Added');
    }).catchError((e) => Utilities().toastMessage(e));

    // return students.add(
    //     {'name': name, 'email': email, 'password': password}).then((value) {
    //   Utilities().toastMessage('User Added');

    //}).catchError((e) => Utilities().toastMessage(e));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  clearTextField() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  void signup() {
    setState(() {
      loading = true;
    });
    _auth
        .createUserWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((value) {
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      Utilities().toastMessage(error.toString());
      setState(() {
        loading = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SIGN UP",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            )),
        backgroundColor: Colors.lightGreen,
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          hintText: 'Roll No:',
                          helperText: 'Enter your roll number',
                          prefixIcon: Icon(Icons.note_add)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter a valid roll number';
                        }
                        return null;
                      },
                    ), // This is TextFormField for Roll No
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          hintText: 'Email',
                          helperText: 'Enter a valid email e.g john@gmail.com',
                          prefixIcon: Icon(Icons.email)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ), // This is TextFormField for Email
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: const InputDecoration(
                            hintText: 'Password',
                            helperText: 'Enter a valid password',
                            prefixIcon: Icon(Icons.lock_open)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter a valid password';
                          }
                          return null;
                        }), // This is TextFormField for Password
                  ],
                )),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: RoundButton(
                loading: loading,
                title: 'SIGN UP',
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      name = nameController.text;
                      email = emailController.text;
                      password = passwordController.text;
                      // createUser(student)
                      createUser();
                      clearTextField();
                    });
                  }
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Already have an Account?",
                  style: TextStyle(fontSize: 18),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.deepOrange, fontSize: 18),
                  ),
                )
              ],
            )
          ]),
    );
  }
}
