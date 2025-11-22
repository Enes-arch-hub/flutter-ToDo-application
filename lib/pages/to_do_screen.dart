import 'package:flutter/material.dart';
import 'package:flutter_todo_application/database/database.dart';
import 'package:flutter_todo_application/widgets/dialog_box.dart';
import 'package:flutter_todo_application/widgets/to_do_tile.dart';
import 'package:hive/hive.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  final TextEditingController _controller = TextEditingController();
  final _myBox = Hive.box('mybox');
  ToDoDatabase db = ToDoDatabase();
  @override
  void initState() {
    //if this is the first time ever opening the app, then create default data
    if (_myBox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      //there already exists data
      db.loadData();
    }
    super.initState();
  }

  //checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDatabase();
  }

  //save new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }
  //create a new task

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          onSave: saveNewTask,
          text: 'Add Task',
          Controller: _controller,
        );
      },
    );
    // Function to create a new task
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.tealAccent,
        title: const Text('ToDo '),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add, color: Colors.tealAccent),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) {
              setState(() {
                db.toDoList.removeAt(index);
              });
              db.updateDatabase();
            },
          );
        },
      ),
    );
  }
}
