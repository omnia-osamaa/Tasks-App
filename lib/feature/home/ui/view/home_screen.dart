import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasky/core/utils/appDialog_widget.dart';
import 'package:tasky/feature/auth/ui/view/login_screen.dart';
import 'package:tasky/feature/home/data/firebase/task_firebase.dart';
import 'package:tasky/feature/home/data/model/task_model.dart';
import 'package:tasky/feature/home/ui/view/detalies_task_screen.dart';
import 'package:tasky/feature/home/ui/view/empty_screen.dart';
import 'package:tasky/feature/home/ui/widgets/alert_dialog_widget.dart';
import 'package:tasky/feature/home/ui/widgets/dayPicker_widget.dart';
import 'package:tasky/feature/home/ui/widgets/show_modal_bottom_widget.dart';
import 'package:tasky/feature/home/ui/widgets/task_item_widget.dart';
import 'package:tasky/feature/home/ui/widgets/task_search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String routeName = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var titleTask = TextEditingController();
  var descriptionTask = TextEditingController();
  var searchController = TextEditingController();
  int priority = 1;
  DateTime selectedDate = DateTime.now();
  DateTime filterDate = DateTime.now();
  String searchQuery = "";
  List<TaskModel> tasks = [];
  List<TaskModel> allTasks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getTasks();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    final incompleteTasks = tasks.where((task) => !task.isCompleted).toList();
    final completedTasks = tasks.where((task) => task.isCompleted).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("assets/images/tasky_logo.png"),
                  InkWell(
                    onTap: () async {
                      try {
                        await FirebaseAuth.instance.signOut();
                      } catch (e) {
                        print('Error signing out: $e');
                      }
                      Navigator.pushReplacementNamed(
                        context,
                        LoginScreen.routeName,
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset("assets/icons/logout_icon.png"),
                        SizedBox(width: 4),
                        Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xffFF4949),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              TaskSearchBar(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                    filterTasksByDate();
                  });
                },
              ),
              SizedBox(height: 10),
              DayPickerWidget(
                currentDate: now,
                selectedDate: filterDate,
                onDateSelected: (date) {
                  setState(() {
                    filterDate = date;
                    filterTasksByDate();
                  });
                },
              ),
              SizedBox(height: 10),
              Expanded(
                child: isLoading
                    ? Center(child: CircularProgressIndicator())
                    : tasks.isEmpty
                    ? EmptyScreen()
                    : ListView.builder(
                        itemCount:
                            incompleteTasks.length +
                            completedTasks.length +
                            (completedTasks.isNotEmpty ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index < incompleteTasks.length) {
                            final task = incompleteTasks[index];
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        UpdateTaskScreen(taskModel: task),
                                  ),
                                );
                              },
                              child: TaskItemWidget(
                                taskModel: task,
                                onToggleComplete: () async {
                                  await FirebaseUserDatabase.toggleTaskCompletion(
                                    task,
                                  );
                                  await getTasks();
                                },
                              ),
                            );
                          }

                          if (index == incompleteTasks.length &&
                              completedTasks.isNotEmpty) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Container(
                                child: Text(
                                  'Completed',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            );
                          }

                          final completedIndex =
                              index - incompleteTasks.length - 1;
                          final task = completedTasks[completedIndex];
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      UpdateTaskScreen(taskModel: task),
                                ),
                              );
                            },
                            child: TaskItemWidget(
                              taskModel: task,
                              onToggleComplete: () async {
                                await FirebaseUserDatabase.toggleTaskCompletion(
                                  task,
                                );
                                await getTasks();
                              },
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Color(0xff24252C),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => StatefulBuilder(
              builder: (context, setModalState) => ShowBottomSheetWidget(
                dialogTitle: 'Add Task',
                titleTask: titleTask,
                descriptionTask: descriptionTask,
                selectedDate: selectedDate,
                priority: priority,
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
                      onTap: (index) {
                        setModalState(() {
                          priority = index;
                        });
                        setState(() {
                          priority = index;
                        });
                      },
                    ),
                  );
                },
                onTapSend: () async {
                  AppDialog.showDialogLoading(context);
                  await FirebaseUserDatabase.addTask(
                        title: titleTask.text,
                        description: descriptionTask.text,
                        priority: priority,
                        date: selectedDate,
                      )
                      .then((_) async {
                        if (Navigator.canPop(context))
                          Navigator.of(context).pop();

                        titleTask.clear();
                        descriptionTask.clear();
                        priority = 0;
                        selectedDate = DateTime.now();

                        await getTasks();
                      })
                      .catchError((error) {
                        if (Navigator.canPop(context))
                          Navigator.of(context).pop();
                        AppDialog.showDialogError(context, error);
                      });
                },
              ),
            ),
          );
        },
        child: Icon(Icons.add, color: Color(0xff5F33E1), size: 30),
      ),
    );
  }

  Future<void> getTasks() async {
    setState(() => isLoading = true);
    allTasks = await FirebaseUserDatabase.getAllTasks();
    filterTasksByDate();
    setState(() => isLoading = false);
  }

  void filterTasksByDate() {
    final filter = DateTime(filterDate.year, filterDate.month, filterDate.day);

    tasks = allTasks.where((task) {
      final taskDate = DateTime(task.date.year, task.date.month, task.date.day);
      final matchesDate = taskDate == filter;
      final matchesSearch = task.title.toLowerCase().contains(
        searchQuery.toLowerCase(),
      );
      return matchesDate && matchesSearch;
    }).toList();
  }
}
