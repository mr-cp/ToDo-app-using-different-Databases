import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final TextEditingController _date = TextEditingController();

  final batchList = [
    'Computer Science',
    'Science',
    'Commerce',
    'Humanities',
    'Home Science'
  ];
  String? selectedBatch;

  final CollectionReference student =
      FirebaseFirestore.instance.collection('student');

  final TextEditingController studentName = TextEditingController();
  final TextEditingController studentEnrolment = TextEditingController();

  // addData:
  addStudent() {
    final data = {
      'name': studentName.text,
      'enrolment number': studentEnrolment.text,
      'date': _date.text,
      'stream': selectedBatch
    };
    student.add(data);  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Student List',
          style: TextStyle(fontSize: 27),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple[200],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: studentName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Student name'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: studentEnrolment,
                keyboardType: TextInputType.number,
                maxLength: 2,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Enrollment number'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                readOnly: true,
                controller: _date,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'DOB',
                  suffixIcon: Icon(Icons.calendar_month),
                ),
                onTap: () async {
                  DateTime initialDate = DateTime(2020, 01, 01);
                  DateTime firstDate = DateTime(2000, 01, 01);
                  DateTime lastDate = DateTime(2022, 01, 01);

                  DateTime? datePicker = await showDatePicker(
                    context: context,
                    initialDate:
                        initialDate.isAfter(lastDate) ? initialDate : lastDate,
                    firstDate: firstDate,
                    lastDate: lastDate,
                  );
                  if (datePicker != null) {
                    final formattedDate =
                        DateFormat('dd/MM/yyyy').format(datePicker);
                    setState(
                      () {
                        _date.text = formattedDate;
                      },
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DropdownButtonFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Select Stream'),
                ),
                items: batchList
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ),
                    )
                    .toList(),
                onChanged: (val) {
                  selectedBatch = val as String;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  addStudent();

                  const snackBar = SnackBar(
                    content: Text(
                      'Studnet Added!!',
                      textAlign: TextAlign.center,
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                        const Size(double.infinity, 50)),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.purple[200])),
                child: const Text(
                  'Add Student',
                  style: TextStyle(fontSize: 22),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
