import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Tasks {
  String? id;
  String? description;
  DateTime? dueDate;
  TimeOfDay? dueTime;
  bool? isFinish;

  Tasks(
      {required this.id,
      required this.description,
      this.dueDate,
      this.dueTime,
      this.isFinish = false});
}

class TaskProvider with ChangeNotifier {
  List<Tasks> get itemList {
    return _taskList;
  }

  List<Tasks> _taskList = [];

  void newTask(Tasks task) {
    final newTask = Tasks(
      id: task.id,
      description: task.description,
      dueDate: task.dueDate,
      dueTime: task.dueTime,
    );
    _taskList.add(newTask);
    notifyListeners();
  }

  void editTask(Tasks task) {
    removeTask(task.id!);
    newTask(task);
  }

  void removeTask(String id) {
    _taskList.removeWhere((task) => task.id! == id);
    notifyListeners();
  }
}
