class Todo {
  int _id;
  String _todo;
  String _date;
  bool _isDone;
  Todo(this._todo, this._date, this._isDone);
  Todo.withId(this._id, this._todo, this._date, this._isDone);

  int get id => _id;
  String get todo => _todo;
  String get date => _date;
  bool get isDone => _isDone;

  set isDone(bool isCheck) {
    this._isDone = isCheck;
  }

  set todo(String todo) {
    this._todo = todo;
  }

  set date(String newdate) {
    this._date = newdate;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['todo'] = _todo;
    map['isDone'] = _isDone;
    map['date'] = _date;
  }

  Todo.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._todo = map['todo'];
    this._isDone = map['isDone'];
    this._date = map['date'];
  }
}
