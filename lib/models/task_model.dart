class Task {
  final String id;
  String title;
  String status;
  Duration timeSpent;
  bool isTiming;
  DateTime? completionDate;
  List<String> comments;

  Task({
    required this.id,
    required this.title,
    required this.status,
    this.timeSpent = const Duration(),
    this.isTiming = false,
    this.completionDate,
    List<String>? comments,
  }) : comments = comments ?? [];
}

List<Task> tasks = [
  Task(id: '1', title: 'Task to do', status: 'todo'),
];
