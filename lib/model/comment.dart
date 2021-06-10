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

  factory Comment.fromJson(DocumentSnapshot parsedJson) {
    if (parsedJson.data() == null || parsedJson.data().isEmpty) {
      return Comment();
    }

    UserData userData = UserData(
      firstName: parsedJson.data()['userData']['firstName'],
      lastName: parsedJson.data()['userData']['lastName'],
      profession: parsedJson.data()['userData']['profession'],
    );

    return Comment(
      commentText: parsedJson.data()['commentText'],
      timestamp: parsedJson.data()['timestamp'],
      noOfLikes: parsedJson.data()['noOfLikes'],
      noOfDislikes: parsedJson.data()['noOfDislikes'],
      likedBy: (parsedJson.data()['likedBy'] as List)
          .map((e) => e.toString())
          .toList(),
      dislikedBy: (parsedJson.data()['dislikedBy'] as List)
          .map((e) => e.toString())
          .toList(),
      userData: userData,
    );
  }
}
