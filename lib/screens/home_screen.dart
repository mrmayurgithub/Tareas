import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tareas/models/todo.dart';
import 'package:tareas/screens/addtask_screen.dart';
import 'package:tareas/screens/developer_screen.dart';
import 'package:tareas/screens/no_task.dart';
import 'package:tareas/themes/theme.dart';
import 'package:tareas/utils/database_helper.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();

  List<Todo> todoList;

  int count = 0;

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    String newTaskTitle;

    if (todoList == null) {
      todoList = List<Todo>();
      updateListView();
    }
    final key = GlobalKey<ScaffoldState>();

    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(width: width / 100),
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.square,
                  size: height / 40,
                  color: isDarkTheme ? Colors.white : Colors.black,
                ),
                onPressed: () => Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => MenuScreen()),
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width - width / 4),
              GestureDetector(
                onTap: () => isDarkTheme
                    ? _themeChanger.setTheme(ThemeData.light())
                    : _themeChanger.setTheme(ThemeData.dark()),
                child: Container(
                  padding: EdgeInsets.all(3),
                  height: height / 20,
                  width: width / 20,
                  child: isDarkTheme
                      ? Image.asset('assets/b.png')
                      : Image.asset('assets/a.png'),
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: AddTask(
                  key: key,
                  todo: Todo('', '', false),
                ),
                //**************ADD TASK CHECK FUCNTION************************/
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'My Tasks',
                        style: TextStyle(
                          fontSize: height / 25,
                        ),
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '${todoList.length} tasks',
                      //  '${Provider.of<Todo>(context).todo.length} Tasks',
                      style: TextStyle(fontSize: height / 60),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Divider(
                //color: Colors.white,
                height: 8.0,
              ),
            ),
            Flexible(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  // color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: todoList.isEmpty ? NoTask() : getTodoList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListView getTodoList() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 2.0,
          child: ListTile(
            leading: Checkbox(
              activeColor: Colors.blue,
              value: todoList[index].isDone,
              onChanged: (bool value) => {
                //************change isDone value****************/
              },
            ),
            title: Text(todoList[index].todo),
            subtitle: Text(todoList[index].date),
            trailing: IconButton(
              icon: Icon(Icons.delete_forever),
              onPressed: () => {
                //********implemenet delete*************/
                _delete(context, todoList[index]),
              },
            ),
          ),
        );
      },
    );
  }

  void _delete(BuildContext context, Todo todo) async {
    int result = await databaseHelper.deleteTodo(todo.id);
    if (result != 0) {
      updateListView();
    }
  }

  void navigateToDetail(Todo todo, String task) async {
    updateListView();
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) async => {
          await databaseHelper.getTodoList().then((todoList) {
            setState(() {
              this.todoList = todoList;
              this.count = todoList.length;
            });
          })
        });
  }
}
