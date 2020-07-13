import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';
import 'package:async/async.dart';
import 'package:tareas/models/todo.dart';
import 'dart:io';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  String todoTable = 'todo_table';
  String colId = 'id';
  String colTitle = 'todo';
  String colDate = 'date';
  String colisDone = 'isDone';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }
  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'todo.db';

    var todoDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return todoDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $todoTable($colId INTEGER PRIMARY KEY AUTOINCREMENT,)'

        //***************************check******************************
        '$colTitle TEXT, $colisDone BOOL');
  }

  Future<List<Map<String, dynamic>>> getTodoMapList() async {
    Database db = await this.database;

    //******************CHECK ORDER BY*************************
    var result = await db.query(todoTable);
    return result;
  }

  Future<int> insertTodo(Todo todo) async {
    Database db = await this.database;
    var result = await db.insert(todoTable, todo.toMap());
    return result;
  }

  Future<int> upDateTodo(Todo todo) async {
    var db = await this.database;
    var result = await db.update(todoTable, todo.toMap(),
        where: '$colId = ?', whereArgs: [todo.id]);
    return result;
  }

  Future<int> deleteTodo(int id) async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $todoTable WHERE $colId = $id');
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $todoTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Todo>> getTodoList() async {
    var todoMapList = await getTodoMapList();
    int count = todoMapList.length;

    List<Todo> todoList = List<Todo>();
    for (int i = 0; i < count; i++) {
      todoList.add(Todo.fromMapObject(todoMapList[i]));
    }

    return todoList;
  }
}
