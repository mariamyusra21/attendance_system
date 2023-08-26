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
      body: StudentItem(),
    );
  }
}

class StudentItem extends StatelessWidget {
  StudentItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Roll No', style: TextStyle(fontSize: 15)),
      subtitle: Text('Name', style: TextStyle(fontSize: 15)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            child: Text(
              "Active",
              style: TextStyle(color: Colors.blue, fontSize: 15),
            ),
            onPressed: () {},
          ),
          TextButton(
            child: Text("InActive",
                style: TextStyle(color: Colors.red, fontSize: 15)),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
