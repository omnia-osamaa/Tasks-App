import 'package:flutter/material.dart';
import 'package:tasky/feature/home/data/model/task_model.dart';
import 'package:tasky/feature/home/ui/widgets/container_prority_widget.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key,
    required this.taskModel,
    this.onToggleComplete,
  });
  
  final TaskModel taskModel;
  final VoidCallback? onToggleComplete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
      ),
      child: Row(
        children: [
          Radio(
            value: taskModel.isCompleted,
            groupValue: true,
            onChanged: (value) {
              if (onToggleComplete != null) {
                onToggleComplete!();
              }
            },
            activeColor: Color(0xff5F33E1),
            fillColor: MaterialStateProperty.resolveWith((states) {
              if (taskModel.isCompleted) {
                return Color(0xff5F33E1);
              }
              return Colors.grey;
            }),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  taskModel.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff24252C),
                    decoration: taskModel.isCompleted 
                        ? TextDecoration.lineThrough 
                        : TextDecoration.none,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "Today ${taskModel.date.day}/${taskModel.date.month}/${taskModel.date.year}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffAFAFAF),
                  ),
                ),
              ],
            ),
          ),
          ContainerPriorityWidget(
            index: taskModel.priority,
            isSelected: false,
          ),
        ],
      ),
    );
  }
}