import 'package:attendance_sys/Response/utilities.dart';
import 'package:attendance_sys/screens/signup.dart';
import 'package:attendance_sys/screens/student_home.dart';
import 'package:attendance_sys/screens/teacher_home.dart';
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
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
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

  void login() async {
    setState(() {
      loading = true;
    });

    // signInAnonymously();

    // User Login...

    _auth
        .signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((value) {
      if (_auth.currentUser!.email!.contains('t')) {
        Utilities().toastMessage(value.user!.email.toString());
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => TeacherHomePage()));
        setState(() {
          loading = false;
        });
      } else if (_auth.currentUser!.email!.contains('s')) {
        Utilities().toastMessage(value.user!.email.toString());
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => StudentHomePage()));
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
                      login();
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
            ]),
      ),
    );
  }
}
