import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../model/todo_model.dart';

class TodoModel with ChangeNotifier {
  final Box<Todo> _todoBox = Hive.box<Todo>('containerBox');

  List<Todo> get todoBox => _todoBox.values.toList();

  // add todo:
  void addTodo(String title) {
    final newTodo = Todo(title: title);
    _todoBox.add(newTodo);

    notifyListeners();
  }

  // Delete Todo:
   void deleteTodo(Todo todo) {
    todo.delete();
    notifyListeners();
  }

  void isCompleted(Todo todo) {
    todo.isComplete = !todo.isComplete;
    todo.save();
    
    notifyListeners();
  }
}
