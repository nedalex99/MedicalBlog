import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medical_blog/model/user_data.dart';

class Comment {
  String commentId;
  String commentText;
  Timestamp timestamp;
  int noOfLikes;
  int noOfDislikes;
  List<String> likedBy;
  List<String> dislikedBy;
  UserData userData;

  Comment({
    this.commentId,
    this.commentText,
    this.timestamp,
    this.noOfLikes = 0,
    this.noOfDislikes = 0,
    this.likedBy = const [],
    this.dislikedBy = const [],
    this.userData,
  });

  Map<String, dynamic> toJson() => {
        'commentText': commentText,
        'timestamp': timestamp,
        'noOfLikes': noOfLikes,
        'noOfDislikes': noOfDislikes,
        'likedBy': likedBy,
        'dislikedBy': dislikedBy,
        'userData': userData.toJson(),
      };

  factory Comment.fromJson(Map<dynamic, dynamic> parsedJson) {
    if (parsedJson == null || parsedJson.isEmpty) {
      return Comment();
    }

    UserData userData = UserData.fromJson(parsedJson['userData']);

    return Comment(
      commentText: parsedJson['commentText'],
      timestamp: parsedJson['timestamp'],
      noOfLikes: parsedJson['noOfLikes'],
      noOfDislikes: parsedJson['noOfDislikes'],
      likedBy: (parsedJson['likedBy'] as List).map((e) => e.toString()).toList(),
      dislikedBy: (parsedJson['dislikedBy'] as List).map((e) => e.toString()).toList(),
      userData: userData,
    );
  }
}
