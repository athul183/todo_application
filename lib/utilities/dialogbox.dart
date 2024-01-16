import 'package:flutter/material.dart';
import 'package:todo_application/utilities/myButtons.dart';

class DialogBox extends StatelessWidget {
  final controlller;
  VoidCallback onSave;
  VoidCallback onCancel;
  DialogBox({
    super.key,
    required this.controlller,
    required this.onSave,
    required this.onCancel
    });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: Container(height: 120,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextField(
            controller: controlller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Add a new task"
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyButton(text: "Save", onPressed: onSave),

              const SizedBox(width: 8,),

              MyButton(text: "Cancel", onPressed: onCancel)
            ],
          )
        ],
      ),
      ),
      
    );
  }
}