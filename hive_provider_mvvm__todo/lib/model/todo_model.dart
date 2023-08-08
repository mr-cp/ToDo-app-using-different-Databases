import 'package:hive/hive.dart';

part 'todo_model.g.dart';


@HiveType(typeId: 1)
class Todo extends HiveObject {
  @HiveField(1)
  late String title;

  @HiveField(2)
  late bool isComplete;

  Todo({required this.title, this.isComplete=false});
}
