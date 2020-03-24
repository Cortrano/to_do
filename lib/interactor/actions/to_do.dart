import 'package:to_do/interactor/entities/to_do_item.dart';
import 'action_base.dart';
import '../accessor.dart';

class AddToDoItem extends ActionBase {
  ToDoItem item;
  final String title;
  final String description;
  final bool done;
  final int count;

  AddToDoItem(
      {this.title, this.description, this.done = false, this.count = 1});

  @override
  void doAction(IAccessor accessor, void onComplete(ActionBase result)) async {
    IDatabase storage = accessor.database;
    IToDoList toDoList = accessor.toDoList;

    for (int i = 0; i < count; ++i) {
      item = toDoList.addItem(
          title: title, description: description, done: done);
      await storage.toDoItemRepository.add(item);
    }

    onComplete(this);
  }
}

class EditToDoItem extends ActionBase {
  ToDoItem item;
  final String itemId;
  final String title;
  final String description;
  final bool done;

  EditToDoItem(this.itemId,
      {this.title, this.description, this.done});

  @override
  void doAction(IAccessor accessor, void onComplete(ActionBase result)) async {
    IDatabase storage = accessor.database;
    IToDoList toDoList = accessor.toDoList;
    item = toDoList.changeItem(itemId,
        title: title, description: description, done: done);
    await storage.toDoItemRepository.edit(item);
    onComplete(this);
  }
}

class RemoveToDoItem extends ActionBase {
  final String itemId;
  RemoveToDoItem(this.itemId);

  @override
  void doAction(IAccessor accessor, void onComplete(ActionBase result)) async {
    IDatabase storage = accessor.database;
    IToDoList toDoList = accessor.toDoList;
    ToDoItem item = toDoList.removeItem(itemId);
    await storage.toDoItemRepository.remove(item);
    onComplete(this);
  }
}

class RemoveAllToDoItem extends ActionBase {
  RemoveAllToDoItem();

  @override
  void doAction(IAccessor accessor, void onComplete(ActionBase result)) async {
    IDatabase storage = accessor.database;
    IToDoList toDoList = accessor.toDoList;
    toDoList.removeAll();
    await storage.toDoItemRepository.removeAll();
    onComplete(this);
  }
}

class GetToDoItem extends ActionBase {
  ToDoItem item;
  final String itemId;

  GetToDoItem(this.itemId);
  @override
  void doAction(IAccessor accessor, void onComplete(ActionBase result)) {
    IToDoList toDoList = accessor.toDoList;
    item = toDoList.toDoList.firstWhere((ToDoItem currentItem) {
      return currentItem.id == itemId;
    });
    onComplete(this);
  }
}

class GetToDoList extends ActionBase {
  final bool done;
  List<ToDoItem> items = [];

  GetToDoList({this.done});
  @override
  void doAction(IAccessor accessor, void onComplete(ActionBase result)) {
    if(done == null){
    IToDoList toDoList = accessor.toDoList;
    items = toDoList.toDoList;
    onComplete(this);
    return;
    } else {
      for(ToDoItem item in accessor.toDoList.toDoList){
        if(item.done == done){
          items.add(item);
        }
      }
      onComplete(this);
      return;
    }
  }
}
