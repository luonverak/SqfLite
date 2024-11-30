class Model {
  late int id;
  final String title;
  final String description;
  final String date;

  Model({required this.title, required this.description, required this.date});

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "date_time": date,
      };
}
