import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medical_blog/logic/model/user_data.dart';

class Comment {
  String commentId;
  String commentText;
  Timestamp timestamp;
  int noOfLikes;
  int noOfDislikes;
  UserData userData;

  Comment({
    this.commentId,
    this.commentText,
    this.timestamp,
    this.noOfLikes = 0,
    this.noOfDislikes = 0,
    this.userData,
  });

  Map<String, dynamic> toJson() => {
        'id': commentId,
        'commentText': commentText,
        'timestamp': timestamp,
        'noOfLikes': noOfLikes,
        'noOfDislikes': noOfDislikes,
        'userData': userData,
      };

  factory Comment.fromJson(Map<dynamic, dynamic> parsedJson) {
    if (parsedJson == null || parsedJson.isEmpty) {
      return Comment();
    }

    return Comment(
      commentId: parsedJson['id'],
      commentText: parsedJson['commentText'],
      timestamp: parsedJson['timestamp'],
      noOfLikes: parsedJson['noOfLikes'],
      noOfDislikes: parsedJson['noOfDislikes'],
      userData: parsedJson['userData'],
    );
  }
}
