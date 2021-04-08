class Post {
  String title;
  String description;
  DateTime dateTime;
  List<String> tags;
  int noOfLikes;
  int noOfDislikes;
  int noOfComments;

  Post({
    this.title,
    this.description,
    this.dateTime,
    this.tags,
    this.noOfLikes = 0,
    this.noOfDislikes = 0,
    this.noOfComments = 0,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'dateTime': dateTime,
        'tags': tags,
        'noOfLikes': noOfLikes,
        'noOfDislikes': noOfDislikes,
        'noOfComments': noOfComments,
      };

  factory Post.fromJson(Map<dynamic, dynamic> parsedJson) {
    if (parsedJson == null || parsedJson.isEmpty) {
      return Post();
    }

    return Post(
      title: parsedJson['title'],
      description: parsedJson['title'],
      tags: parsedJson['title'],
      noOfLikes: parsedJson['noOfLikes'],
      noOfDislikes: parsedJson['noOfDislikes'],
      noOfComments: parsedJson['noOfComments'],
    );
  }
}
