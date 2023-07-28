import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_todo_app/controller/functions.dart';
import 'package:flutter/material.dart';



class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final groups = ['BCA', 'BBA', 'BBM', 'B.Com', 'BSc', 'B.Ed', 'BTech'];

  TextEditingController studentName = TextEditingController();
  TextEditingController studentPhone = TextEditingController();
  String? selectedGroup;

final CollectionReference student = FirebaseFirestore.instance.collection('student');

// add function:
  addStudent(){
    final data = {
      'name': studentName.text,
      'phone': studentPhone.text,
      'stream': selectedGroup
    };
    student.add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Donors"),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: studentName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Donor Name'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: studentPhone,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Phone Number'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField(
                  decoration:
                      const InputDecoration(label: Text("Select Stream")),
                  items: groups
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (val) {
                    selectedGroup = val as String;
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  addStudent();
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                    const Size(double.infinity, 50),
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.amber),
                ),
                child: const Text(
                  'SUBMIT',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
