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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Student Database',
          style: TextStyle(fontSize: 27),
        ),
        backgroundColor: Colors.purple[200],
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        backgroundColor: Colors.purple[200],
        child: const Icon(
          Icons.add,
          size: 35,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: StreamBuilder(
          stream: student.snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.docs.length ?? 0,
                itemBuilder: (context, index) {
                  final DocumentSnapshot studentSnap = snapshot.data.docs[index];
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      height: 120,
                      color: Colors.white70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.purple[200],
                            radius: 30,
                            child: Text(
                              studentSnap['enrolment number'].toString(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 22),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  studentSnap['name'],
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  studentSnap['stream'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  studentSnap['date'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.edit),
                                color: Colors.purple[200],
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.delete),
                                  color: Colors.purple[200]),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              print('error occured');
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
