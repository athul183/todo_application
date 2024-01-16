import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_application/data/database.dart';
import 'package:todo_application/utilities/dialogbox.dart';
import 'package:todo_application/utilities/todo_tile.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {

  final _myBox = Hive.box('mybox');

  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    if(_myBox.get("TODOLIST") == null){

      db.createInititalData();

    }
    else{
      db.loadData();
    }
    super.initState();
  }

  final _controller = TextEditingController();


  void checkBoxChanged(bool? value , int index){
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDatabase();
  }

  void saveNewTask(){
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  void createNewTask(){
      showDialog(context: context, builder: (context){
        return DialogBox(
          controlller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      }
      );
  }

  void deleteTask(int index){
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade200,
      appBar: AppBar(title: Center(child: Text('To Do App')),
      elevation: 0.0,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
      child: const  Icon(Icons.add),
      ),

      body: ListView.builder(
        
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDOTile(
            taskname: db.toDoList[index][0], 
            taskCompleted: db.toDoList[index][1], 
            onChanged: (value) => checkBoxChanged(value , index),
            deleteFunction: (context) => deleteTask(index),
            
            );
        },
      ),
    );
  }
}