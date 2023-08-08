import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider_mvvm_hive/model/todo_model.dart';
import 'package:todo_provider_mvvm_hive/view/home_screen.dart';
import 'package:todo_provider_mvvm_hive/view_model/screen_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_provider_mvvm_hive/view_model/todo_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocDir = await getApplicationDocumentsDirectory();

  Hive.init(appDocDir.path);

  Hive.registerAdapter(TodoAdapter());

  await Hive.openBox<Todo>('containerBox');

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ScreenModel()),
      ChangeNotifierProvider(create: (_) => TodoModel()),
    ],
    child: const MyApp(),
  ));
}
