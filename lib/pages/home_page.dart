import "package:flutter/material.dart";
// import "package:hive/hive.dart";
import "package:hive_flutter/hive_flutter.dart";
import "package:todo_flutter/utils/database.dart";
import "package:todo_flutter/utils/dialog_box.dart";
import "package:todo_flutter/utils/todo_tile.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the HIVE box
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  // if this is the first time ever openign this app, then create some default data
  @override
  void initState() {
    if (_myBox.get("TODLIST") == null) {
      db.createInitialData();
    } else {
      // there already exists the data, and user is not first time visitng
      db.loadData();
    }
    super.initState();
  }

  // text Controller
  final _controller = TextEditingController();

  // removed -> since we change teh db to HIVE
  // list of Todo Tasks
  // List toDoList = [
  //   ["Make Tutorial", false],
  //   ["Do Excercise", true],
  // ];

  // checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });

    // update the HIVE database -> anytime the user has made any changes
    db.updateDataBase();
  }

  // delete a task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }
  
  // save a new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  // create a new task
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text('TO DO'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
        itemCount: db.toDoList.length,
      ),
    );
  }
}
