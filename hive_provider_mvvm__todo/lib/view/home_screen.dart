import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider_mvvm_hive/view_model/screen_model.dart';
import 'package:todo_provider_mvvm_hive/view_model/todo_model.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final screenModel = Provider.of<ScreenModel>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: screenModel.liteMode ? ThemeData.dark() : ThemeData.light(),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final TextEditingController taskController = TextEditingController();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('build');
    final screenModel = Provider.of<ScreenModel>(context);
    final todoModel = Provider.of<TodoModel>(context);
    final todos = todoModel.todoBox;

    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        title: const Text(
          'Todo APP',
        ),
        actions: [
          InkWell(
            child: const Icon(Icons.nights_stay_outlined),
            onTap: () {
              screenModel.toggleMode();
              print('action tapped');
            },
          ),
          const SizedBox(
            width: 30,
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              onSubmitted: (value) {
                print('$taskController.text');
                todoModel.addTodo(value);
                taskController.clear();
              },
              controller: taskController,
              decoration: const InputDecoration(
                hintText: 'Enter Task',
                hintStyle: TextStyle(color: Colors.blue),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (BuildContext context, int index) {
                final todu = todos[index];
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Card(
                    elevation: 5,
                    shadowColor: Colors.grey,
                    child: ListTile(
                        title: Text(todu.title),
                        trailing: Checkbox(
                          value: todu.isComplete,
                          onChanged: (_) => todoModel.isCompleted(todu),
                        ),
                        onLongPress: () {
                          todoModel.deleteTodo(todu);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Deleted succefully'),
                            duration: Duration(seconds: 1),
                          ));
                        }),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
