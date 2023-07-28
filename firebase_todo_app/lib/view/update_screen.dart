import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_todo_app/controller/functions.dart';
import 'package:flutter/material.dart';

class UpdateStudent extends StatefulWidget {
  const UpdateStudent({super.key});

  @override
  State<UpdateStudent> createState() => _UpdateStudentState();
}

class _UpdateStudentState extends State<UpdateStudent> {
  final groups = ['BCA', 'BBA', 'BBM', 'B.Com', 'BSc', 'B.Ed', 'BTech'];

  TextEditingController studentName = TextEditingController();
  TextEditingController studentPhone = TextEditingController();
  String? selectedGroup;

  // update function:
  updateStudent(docId){
    final data = {
    'name': studentName.text,
    'phone': studentPhone.text,
    'stream': selectedGroup, 
    };
    student.doc(docId).update(data);
  }
  

  final CollectionReference student =
      FirebaseFirestore.instance.collection('student');

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    studentName.text = args['name'];
    studentPhone.text = args['phone'];
    selectedGroup = args['stream'];
    final docId = args['id'];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Student"),
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
                value: selectedGroup,
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
                  updateStudent(docId);
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                    const Size(double.infinity, 50),
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.amber),
                ),
                child: const Text(
                  'UPDATE',
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
