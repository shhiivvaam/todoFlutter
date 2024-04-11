import "package:hive_flutter/hive_flutter.dart";

class ToDoDataBase {
  List toDoList = [];

  // referecne the box
  final _myBox = Hive.box('mybox');

  // run this method if this is the 1st time ever opening this app
  void createInitialData() {
    toDoList = [
      ["Make Tutorial", false],
      ["Do Excercise", true]
    ];
  }

  // load the data from the database
  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  // update the database -> if its being updated by the user (means if the user has modified some contect(added/deleted))
  void updateDataBase() {
    _myBox.put("TODOLIST", toDoList);
  }
}
