import "dart:async";
import 'dart:isolate';
import 'package:gate/gate.dart';
import 'package:to_do/interactor/entities/to_do_item.dart';
import 'entities/index.dart' as entities;
import 'data_stores/index.dart' as data_stores;

import 'actions/action_base.dart';
import 'notifications/notification_base.dart';
export 'data_stores/index.dart';
export 'entities/index.dart';

abstract class IAccessor {
  data_stores.IDatabase get database;
  entities.IToDoList get toDoList;

  void initialize();
}

class Accessor extends Worker implements IAccessor {
  data_stores.IDatabase _database;
  entities.IToDoList _toDoList;
  List<NotificationBase> _notifications = [];
  StreamController<entities.EntityBase> _controller =
      StreamController<entities.EntityBase>.broadcast(onListen: () {
    print("Interactor: LISTEN");
  }, onCancel: () {
    print("Interactor: CANCEL");
  });
  Map<String, dynamic> mainThreadData;

  Accessor(SendPort sendPort) : super(sendPort);

  data_stores.IDatabase get database {
    if (_database == null) {
      _database = new data_stores.SembastDataBase();
    }
    return _database;
  }

  entities.IToDoList get toDoList {
    if (_toDoList == null) {
      _toDoList = new entities.ToDoList(_controller);
    }
    return _toDoList;
  }

  void initialize() async {
    data_stores.SembastToDoItemRepository repo =
        new data_stores.SembastToDoItemRepository(_database);
    List<ToDoItem> list = await repo.getAll();
    toDoList.reset(items: list);
  }

  onNewMessage(dynamic data) {
    print("New message from controller: $data");
    if (data is NotificationBase) {
      _notifications.add(data);
      // _testNotificationOnActiveModels(data);
    } else if (data is ActionBase) {
      ActionBase action = data;
      _runAction(action);
    } else if (data is int) {
      int notificationId = data;
      _notifications.removeWhere((item) {
        return item.id == notificationId;
      });
    }
  }

  onWork() {
    _controller.stream.listen((entities.EntityBase entity) {
      for (NotificationBase notification in _notifications) {
        _testNotification(notification, entity);
      }
    });
  }

  void _testNotification(
      NotificationBase notification, entities.EntityBase entity) {
    if (notification.whenNotify(entity)) {
      notification.grabData(entity);
      send(notification);
    }
  }

  void _runAction(ActionBase action){
          action.doAction(this, (ActionBase result) {
        send(result);
      }); 
  }

  void dispose(){
    _controller.close();
  }
}
