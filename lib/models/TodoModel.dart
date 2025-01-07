class TodoModel {
  String title;
  String description;
  String date;

  TodoModel(
      {required this.title, required this.description, required this.date});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'date': date,
    };
  }

  // Optional: Create a TodoModel object from a Map (for fetching data)
  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      title: map['title'],
      description: map['description'],
      date: map['date'],
    );
  }

  @override
  String toString() {
    return 'TodoModel{title: $title, description: $description, date: $date}';
  }
}