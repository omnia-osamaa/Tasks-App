import 'package:flutter/material.dart';
import 'package:tasky/core/utils/appDialog_widget.dart';
import 'package:tasky/feature/home/data/firebase/task_firebase.dart';
import 'package:tasky/feature/home/data/model/task_model.dart';
import 'package:tasky/feature/home/ui/view/home_screen.dart';
import 'package:tasky/feature/home/ui/widgets/alert_dialog_widget.dart';
import 'package:tasky/feature/home/ui/widgets/show_modal_bottom_widget.dart';

class UpdateTaskScreen extends StatefulWidget {
  const UpdateTaskScreen({super.key, required this.taskModel});
  static String routeName = 'UpdateTaskScreen';
  final TaskModel taskModel;

  @override
  State<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late DateTime selectedDate;
  late int selectedPriority;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.taskModel.title);
    descriptionController = TextEditingController(
      text: widget.taskModel.description,
    );
    selectedDate = widget.taskModel.date;
    selectedPriority = widget.taskModel.priority;
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void _showEditBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) {
          return ShowBottomSheetWidget(
            dialogTitle: "Edit Task",
            titleTask: titleController,
            descriptionTask: descriptionController,
            selectedDate: selectedDate,
            priority: selectedPriority,
            onTapTimer: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: selectedDate,
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
              );
              if (picked != null && picked != selectedDate) {
                setModalState(() {
                  selectedDate = picked;
                });
                setState(() {
                  selectedDate = picked;
                });
              }
            },
            onTapFlag: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialogwidget(
                  onTap: (priority) {
                    setModalState(() {
                      selectedPriority = priority;
                    });
                    setState(() {
                      selectedPriority = priority;
                    });
                  },
                ),
              );
            },
            onTapSend: () async {
              if (titleController.text.isEmpty) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Please enter a title')));
                return;
              }

              AppDialog.showDialogLoading(context);

              final updatedTask = widget.taskModel.copyWith(
                title: titleController.text,
                description: descriptionController.text,
                priority: selectedPriority,
                date: selectedDate,
              );

              await FirebaseUserDatabase.updateTask(updatedTask);

              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.red),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.taskModel.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                widget.taskModel.description,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Image.asset("assets/icons/timer.png", width: 24, height: 24),
                const SizedBox(width: 10),
                const Text("Task Time :"),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                  ),
                  child: Text(
                    "${widget.taskModel.date.day}/${widget.taskModel.date.month}/${widget.taskModel.date.year}",
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Image.asset(
                  "assets/icons/flag_icon.png",
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: 10),
                const Text("Task Priority :"),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                  ),
                  child: Text(
                    widget.taskModel.priority.toString(),
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            GestureDetector(
              onTap: () {
                AppDialog.showDialogLoading(context);
                FirebaseUserDatabase.deleteTask(widget.taskModel).then((_) {});
                Navigator.pop(context);
                Navigator.of(
                  context,
                ).pushReplacementNamed(HomeScreen.routeName);
              },
              child: Row(
                children: [
                  Image.asset(
                    "assets/icons/trash_icon.png",
                    width: 24,
                    height: 24,
                  ),
                  SizedBox(width: 10),
                  Text("Delete Task", style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _showEditBottomSheet,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff5F33E1),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Edit Task",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
