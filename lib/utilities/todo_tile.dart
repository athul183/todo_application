import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDOTile extends StatelessWidget {
  final String taskname;
  final bool taskCompleted;
  Function(bool ?) ? onChanged;
  Function(BuildContext)? deleteFunction;

  ToDOTile({super.key, 
  required this.taskname, 
  required this.taskCompleted,
  required this.onChanged,
  required this.deleteFunction
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 25 , right: 25),
      child: Slidable(
        endActionPane: ActionPane(motion:const StretchMotion(),  
        children: [
          SlidableAction(onPressed: deleteFunction,
          icon: Icons.delete,
          backgroundColor: Colors.red.shade300,
          borderRadius: BorderRadius.circular(12),
          )
        ]),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Checkbox(value: taskCompleted, onChanged: onChanged,
              activeColor: Colors.black,
              ),
              Text(taskname, style: TextStyle(
                decoration: taskCompleted ? TextDecoration.lineThrough : TextDecoration.none
              ),)
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}