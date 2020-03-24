import 'package:flutter/material.dart';
import 'presenter_base.dart';
import '../interactor/actions/to_do.dart' as actions;
import '../interactor/actions/action_base.dart' as actions;

class ToDoEditEvent extends BaseInputEvent {}

class SaveItem extends ToDoEditEvent {
  SaveItem();
}

class ChangeItemCount extends ToDoEditEvent {
  final int count;
  ChangeItemCount({@required this.count});
}

class ToDoEditWireframe extends WireframeBase {
  void hide() {
    navigator.pop();
  }
}

class ToDoEdit extends PresenterBase<ToDoEditEvent, ToDoEditWireframe> {
  String toDoItemId;
  ValueNotifier<int> itemCount = ValueNotifier(1);
  ValueNotifier<bool> busy = ValueNotifier(false);

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  ToDoEdit() : super(ToDoEditWireframe());
  ToDoEdit.edit(this.toDoItemId) : super(ToDoEditWireframe());
  @override
  void initiate() {
    addInputEventHandler<SaveItem>((event) {
      if (busy.value) return;
      busy.value = true;
      if (toDoItemId == null) {
        execute(actions.AddToDoItem(
                title: titleController.text,
                description: descriptionController.text,
                count: itemCount.value))
            .whenComplete(() {
          busy.value = false;
        });
      } else {
        execute(actions.EditToDoItem(
          toDoItemId,
          title: titleController.text,
          description: descriptionController.text,
        )).whenComplete(() {
          busy.value = false;
        });
      }
      wireframe.hide();
    });

    addInputEventHandler<ChangeItemCount>((event) {
      itemCount.value = itemCount.value + event.count;
    });

    if (toDoItemId != null) {
      busy.value = true;
      execute(actions.GetToDoItem(toDoItemId))
          .then((actions.ActionBase actionBase) {
        var action = actionBase as actions.GetToDoItem;
        titleController.text = action.item.title;
        descriptionController.text = action.item.description;
        busy.value = false;
      });
    }
  }
}
