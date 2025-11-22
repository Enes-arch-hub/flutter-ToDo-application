import 'package:hive/hive.dart';

class ToDoDatabase {
  //initialize empty list
  List toDoList = [];

  final _myBox = Hive.box('mybox');

  //create initial data
  void createInitialData() {
    toDoList = [
      ['Welcome to your ToDo App', false],
      ['Tap + button to add a new task', false],
      ['Swipe a task to the left to delete it', false],
    ];
  }

  //load data from database
  void loadData() {
    toDoList = _myBox.get('TODOLIST');
  }

  //update database
  void updateDatabase() {
    _myBox.put('TODOLIST', toDoList);
  }
}
