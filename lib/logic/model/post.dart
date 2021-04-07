class Post {
  String title;
  String description;
  DateTime dateTime;
  List<String> tags;

  Post({
    this.title,
    this.description,
    this.dateTime,
    this.tags,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'dateTime': dateTime,
        'tags': tags,
      };
}
