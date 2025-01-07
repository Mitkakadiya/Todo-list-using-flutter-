class GetListModel {
  String? title;
  String? description;
  String? date;
  String? id;

  GetListModel({this.title, this.description, this.date, this.id});

  Map<String, dynamic> toMap() {
    return {'title': title, 'description': description, 'date': date, 'id': id};
  }

  // Optional: Create a TodoModel object from a Map (for fetching data)
  factory GetListModel.fromMap(Map<String, dynamic> map, String id) {
    return GetListModel(
        title: map['title'],
        description: map['description'],
        date: map['date'],
        id: id);
  }

  @override
  String toString() {
    return 'GetListModel{title: $title, description: $description, date: $date, id: $id}';
  }
}
