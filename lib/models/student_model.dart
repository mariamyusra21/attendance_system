import 'package:cloud_firestore/cloud_firestore.dart';

class StudentModel {
  final String id;
  final String name;
  final String email;
  final String password;
  // final String presentClass;

  // final bool isPresent;

  const StudentModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    // required this.presentClass,
  });

  toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'name': name,
      // 'presentClass': presentClass
    };
  }

  factory StudentModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return StudentModel(
      id: document.id,
      name: data['name'],
      email: data['email'],
      password: data['password'],
      // presentClass: data['presentClass']
    );
  }
}
