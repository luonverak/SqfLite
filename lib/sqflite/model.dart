class Model {
  late int? id;
  final String title;
  final String description;
  final String date;

  Model({this.id,required this.title, required this.description, required this.date});

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "date_time": date,
      };

  Model.fromJson(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        description = map['description'],
        date = map['date_time'];

  @override
  String toString() {
    return 'Model{id: $id, title: $title, description: $description, date: $date}';
  }
}
