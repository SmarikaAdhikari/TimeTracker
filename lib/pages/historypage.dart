// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:timetracker/constants/colors.dart';
import 'package:timetracker/models/task_model.dart'; 

class HistoryPage extends StatelessWidget {
  final List<Task> completedTasks;

  HistoryPage({required this.completedTasks});

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
            'Completed Tasks History',
          ),
          titleTextStyle: Apptheme().titleappbar,
          backgroundColor: Colors.blueGrey,
          iconTheme: const IconThemeData(
            color: Colors.white,
          )),
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 224, 224, 224),
        ),
        child: ListView(
          padding: const EdgeInsets.only(bottom: 60),
          children: completedTasks.map((task) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                contentPadding: const EdgeInsets.only(left: 15.0, right: 10),
                title: Text(task.title, style: Apptheme().title),
                subtitleTextStyle: Apptheme().subtitle,
                subtitle: Row(
                  children: [
                    if (task.comments.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: task.comments
                            .map((comment) => Text('Cmt- $comment',
                                style: const TextStyle(fontSize: 15)))
                            .toList(),
                      ),
                    const Spacer(),
                    Column(
                      children: [
                        Text('Time: ${formatDuration(task.timeSpent)}'),
                        Text(
                            'Date: ${task.completionDate?.toLocal().toString().split(' ')[0]}'),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
