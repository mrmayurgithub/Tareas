import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tareas/models/todo.dart';
import 'package:tareas/utils/database_helper.dart';

class AddTask extends StatefulWidget {
  final Todo todo;

  AddTask({Key key, this.todo}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return AddTaskState(this.todo);
  }
}

class AddTaskState extends State<AddTask> {
  DatabaseHelper helper = DatabaseHelper();
  String task;
  Todo todo;
  TextEditingController todoController = TextEditingController();

  AddTaskState(this.todo);

  @override
  Widget build(BuildContext context) {
    String newTaskTitle;
    todoController.text = todo.todo;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return Container(
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          //color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Add a Todo',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: height / 30,
                //color: Colors.lightBlueAccent,
              ),
            ),
            SizedBox(height: height / 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: TextField(
                maxLines: 2,
                // textInputAction: TextInputAction.continueAction,
                autofocus: true,
                cursorColor: isDarkTheme ? Colors.white : Colors.black,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(width: width / 90),
                  ),
                ),
                textAlign: TextAlign.center,
                onChanged: (newText) {
                  todo.todo = newTaskTitle;
                  //**************************update todo***********************************/
                  updateTodo();
                },
              ),
            ),
            GestureDetector(
              onTap: () {
                todo.todo != null ? _save() : null;

                Navigator.pop(context);
              },
              child: CircleAvatar(child: Icon(Icons.check)),
            ),
          ],
        ),
      ),
    );
  }

  void updateTodo() {
    todo.todo = todoController.text;
  }

  void _save() async {
    todo.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (todo.id != null) {
      result = await helper.upDateTodo(todo);
    } else {
      result = await helper.insertTodo(todo);
    }

    ///***********show snackbarssss********************/
  }
}
