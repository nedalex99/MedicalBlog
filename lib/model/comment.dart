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
  String image;

  Comment({
    this.commentId,
    this.commentText,
    this.timestamp,
    this.noOfLikes = 0,
    this.noOfDislikes = 0,
    this.likedBy = const [],
    this.dislikedBy = const [],
    this.userData,
    this.image,
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
    if (parsedJson.data() == null || (parsedJson.data() as Map).isEmpty) {
      return Comment();
    }

    UserData userData = UserData(
      id: (parsedJson.data() as Map)['userData']['id'],
      firstName: (parsedJson.data() as Map)['userData']['firstName'],
      lastName: (parsedJson.data() as Map)['userData']['lastName'],
      profession: (parsedJson.data() as Map)['userData']['profession'],
    );

    return Comment(
      commentText: (parsedJson.data() as Map)['commentText'],
      timestamp: (parsedJson.data() as Map)['timestamp'],
      noOfLikes: (parsedJson.data() as Map)['noOfLikes'],
      noOfDislikes: (parsedJson.data() as Map)['noOfDislikes'],
      likedBy: (((parsedJson.data() as Map)['likedBy'] as List))
          .map((e) => e.toString())
          .toList(),
      dislikedBy: ((parsedJson.data() as Map)['dislikedBy'] as List)
          .map((e) => e.toString())
          .toList(),
      userData: userData,
    );
  }
}
