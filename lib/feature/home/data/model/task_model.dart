class TaskModel {
  final String id;
  final String title;
  final String description;
  final int priority;
  final DateTime date;
  final bool isCompleted; 

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.date,
    this.isCompleted = false,   
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'priority': priority,
      'date': date.millisecondsSinceEpoch,
      'isCompleted': isCompleted, 
      "dateCreated": DateTime.now().millisecondsSinceEpoch,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] ?? '',
      title: json['title'],
      description: json['description'],
      priority: json['priority'],
      date: DateTime.fromMillisecondsSinceEpoch(json['date']),
      isCompleted: json['isCompleted'] ?? false, 
    );
  }

  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    int? priority,
    DateTime? date,
    bool? isCompleted,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      date: date ?? this.date,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}