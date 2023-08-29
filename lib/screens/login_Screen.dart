import 'package:attendance_sys/Response/utilities.dart';
import 'package:attendance_sys/screens/signup.dart';
import 'package:attendance_sys/screens/student_home.dart';
import 'package:attendance_sys/screens/teacher_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/round_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final resetEmailController = TextEditingController();
  final passwordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    newPasswordController.dispose();
    resetEmailController.dispose();
  }

  // void signInAnonymously() {
  //   _auth.signInAnonymously().then((result) {
  //     setState(() {
  //       final User? user = result.user;
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => HomePage()));
  //     });
  //   });
  // }

  void login(email, password) async {
    setState(() {
      loading = true;
    });

    // signInAnonymously();

    // User Login...

    _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      if (_auth.currentUser!.email!.endsWith('.t@gmail.com')) {
        Utilities().toastMessage(value.user!.email.toString());
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => TeacherHomePage()));
        setState(() {
          loading = false;
        });
      } else if (_auth.currentUser!.email!.endsWith('.s@gmail.com')) {
        Utilities().toastMessage(value.user!.email.toString());
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    StudentHomePage(userId: _auth.currentUser!.uid)));
        setState(() {
          loading = false;
        });
      } else {
        Utilities().toastMessage(value.user!.email.toString());
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    StudentHomePage(userId: _auth.currentUser!.uid)));
        FirebaseFirestore.instance
            .collection('Users')
            .doc(_auth.currentUser!.uid)
            .update({
          "password": password,
        }).then((_) {
          Utilities().toastMessage('New Password Updated!');
        });
        setState(() {
          loading = false;
        });
      }
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      Utilities().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  clearTextField() {
    emailController.clear();
    passwordController.clear();
    newPasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("LOGIN",
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
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            hintText: 'Email',
                            helperText:
                                'Enter a valid email e.g john@gmail.com',
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
                  title: 'LOGIN',
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      login(emailController.text, passwordController.text);
                      clearTextField();
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
                    "Don't have an Account?",
                    style: TextStyle(fontSize: 18),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupScreen()));
                    },
                    child: Text(
                      "Sign up",
                      style: TextStyle(color: Colors.deepOrange, fontSize: 18),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Change Password'),
                            content: TextFormField(
                                controller: resetEmailController,
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                decoration: const InputDecoration(
                                    hintText: 'Email',
                                    helperText: 'Enter your Email',
                                    prefixIcon: Icon(Icons.lock_open)),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter a new valid password';
                                  }
                                  return null;
                                }),
                            actions: [
                              IconButton(
                                onPressed: () {
                                  resetPasswordEmail(resetEmailController.text);
                                  // if (_formKey.currentState!.validate()) {
                                  //   _formKey.currentState!.save();
                                  //   changePassword(
                                  //       newPasswordController.text);
                                  //   clearTextField();
                                  // }
                                  // changePassword(newPasswordController.text);
                                },
                                icon: Icon(Icons.mail_lock),
                              )
                            ],
                          );
                        });
                  },
                  child: Text(
                    "Forgot Password",
                    style: TextStyle(color: Colors.deepOrange, fontSize: 18),
                  ),
                ),
              )
            ]),
      ),
    );
  }

  void resetPasswordEmail(email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Utilities().toastMessage('Password Reset Email has been sent');
    } on FirebaseAuthException catch (e) {
      // TODO
      Utilities().toastMessage(e.toString());
    }

    // _auth.currentUser!.updatePassword(newPassword).then((value) {
    //   FirebaseFirestore.instance.doc(_auth.currentUser!.uid).update({
    //     "password": newPassword,
    //   }).then((_) {
    //     Utilities().toastMessage('Password Updated!');
    //   });
    // }).catchError((e) => Utilities().toastMessage(e));
  }
}
