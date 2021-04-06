class Post {
  String title;
  String description;

  Post({
    this.title,
    this.description,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
      };
}
