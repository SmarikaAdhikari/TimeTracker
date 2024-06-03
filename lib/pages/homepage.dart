// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:timetracker/constants/colors.dart';
import 'package:timetracker/pages/historypage.dart';
import 'package:timetracker/screens/loginpage.dart';
import 'package:uuid/uuid.dart';

import '../models/task_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  List<Task> completedTasks = [];
  final TextEditingController taskController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  late TabController _tabController;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Time tracker',
        ),
        titleTextStyle: Apptheme().titleappbar,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined,
              color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history, color: Colors.white, size: 30),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        HistoryPage(completedTasks: completedTasks)),
              );
            },
          ),
        ],
        backgroundColor: Colors.blueGrey,
        bottom: TabBar(
          indicatorColor: Colors.black,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          controller: _tabController,
          tabs: const [
            Tab(text: 'To Do'),
            Tab(text: 'In Progress'),
            Tab(text: 'Done'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildTaskList('todo', mainColor),
          buildTaskList('in_progress', mainColor),
          buildTaskList('done', mainColor),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddDialog(),
        backgroundColor: Colors.blueGrey,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget buildTaskList(String status, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
      ),
      child: ListView(
        padding: const EdgeInsets.only(bottom: 60),
        children: tasks.where((task) => task.status == status).map((task) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              contentPadding: const EdgeInsets.only(left: 15.0),
              title: Text(task.title),
              titleTextStyle: Apptheme().title,
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  if (task.comments.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: task.comments
                          .map((comment) => Text('Cmt- $comment'))
                          .toList(),
                    ),
                  Text('Time: ${formatDuration(task.timeSpent)}'),
                ],
              ),
              subtitleTextStyle: Apptheme().subtitle,
              onTap: () => showEditDialog(task),
              trailing: Wrap(
                spacing: 0,
                children: <Widget>[
                  IconButton(
                    icon: Icon(task.isTiming ? Icons.pause : Icons.play_arrow,
                        color: Colors.black54),
                    onPressed: () => toggleTimer(task),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) => moveTask(task, value),
                    itemBuilder: (context) => [
                      if (status != 'todo')
                        const PopupMenuItem(
                            value: 'todo', child: Text('Move to To Do')),
                      if (status != 'in_progress')
                        const PopupMenuItem(
                            value: 'in_progress',
                            child: Text('Move to In Progress')),
                      if (status != 'done')
                        const PopupMenuItem(
                            value: 'done', child: Text('Move to Done')),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.black54),
                    onPressed: () => deleteTask(task),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  void showAddDialog() {
    taskController.clear();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Task'),
          content: TextField(
            controller: taskController,
            decoration: const InputDecoration(hintText: 'Enter task title'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                addTask(taskController.text);
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void showEditDialog(Task task) {
    taskController.text = task.title;
    commentController.text =
        task.comments.isNotEmpty ? task.comments.first : '';
    showDialog(
      context: context,
      builder: (context) {
        return Theme(
          data: Theme.of(context).copyWith(dialogBackgroundColor: Colors.white),
          child: AlertDialog(
            title: const Text('Edit Task'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: taskController,
                  decoration:
                      const InputDecoration(hintText: 'Enter task title'),
                ),
                TextField(
                  controller: commentController,
                  decoration: const InputDecoration(hintText: 'Add a comment'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    task.title = taskController.text;
                    task.comments.clear(); // Clear existing comments
                    if (commentController.text.isNotEmpty) {
                      task.comments
                          .add(commentController.text); // Add new comment
                    }
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('Save'),
              ),
            ],
          ),
        );
      },
    );
  }

  void toggleTimer(Task task) {
    setState(() {
      if (task.isTiming) {
        _timer?.cancel();
        task.isTiming = false;
      } else {
        _timer?.cancel();
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          setState(() {
            task.timeSpent += const Duration(seconds: 1);
          });
        });
        task.isTiming = true;
      }
    });
  }

  void moveTask(Task task, String newStatus) {
    setState(() {
      if (newStatus == 'done' && task.status != 'done') {
        task.completionDate = DateTime.now();
        completedTasks.add(task);
      }
      task.status = newStatus;
    });
  }

  void deleteTask(Task task) {
    setState(() {
      if (task.status != 'done') {
        task.completionDate = DateTime.now();
        completedTasks.add(task);
      }
      tasks.remove(task);
    });
  }

  void addTask(String text) {
    if (text.isNotEmpty) {
      setState(() {
        tasks.add(Task(
          id: Uuid().v4(),
          title: text,
          status: 'todo',
        ));
      });
    }
  }
}
