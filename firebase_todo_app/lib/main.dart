import 'package:flutter/material.dart';
import 'view/home_screen.dart';
import 'view/add_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_todo_app/view/update_screen.dart';


Future<void> main ()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      routes: {
        '/':(context) => const HomePage(),
        '/add':(context) => const AddStudent(),
        '/update':(context) => const UpdateStudent(),

      },
      initialRoute: '/',
    );
  }
}