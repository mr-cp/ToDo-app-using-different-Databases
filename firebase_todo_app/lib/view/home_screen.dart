import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference student =
      FirebaseFirestore.instance.collection('student');

  // delete function
  deleteStudent(docId){
    student.doc(docId).delete();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Database "),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        backgroundColor: Colors.amber,
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: StreamBuilder(
        stream: student.orderBy('name').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot studentSnap =
                      snapshot.data!.docs[index];
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 10,
                              spreadRadius: 5)
                        ],
                      ),
                      height: 90,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Container(
                              child: CircleAvatar(
                                backgroundColor: Colors.amber,
                                radius: 30,
                                child: Text(studentSnap['stream']),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                studentSnap['name'],
                                style: const TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                studentSnap['phone'].toString(),
                                style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/update',
                                    arguments: {
                                      'name': studentSnap['name'],
                                      'phone': studentSnap['phone'].toString(),
                                      'stream': studentSnap['stream'],
                                      'id': studentSnap.id,
                                    },
                                  );
                                },
                                icon: const Icon(Icons.edit),
                                color: Colors.blue,
                                iconSize: 30,
                              ),
                              IconButton(
                                onPressed: () {
                                  deleteStudent(studentSnap.id);
                                },
                                icon: const Icon(Icons.delete),
                                color: Colors.red,
                                iconSize: 30,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
          }
          return Container();
        },
      ),
    );
  }
}
