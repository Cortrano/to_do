import 'package:uuid/uuid.dart';

class ToDoItem {
  String id = "todoitem_${Uuid().v4()}";
  String title = "";
  String description = "";
  bool done = false;
}