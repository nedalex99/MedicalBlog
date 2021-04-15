import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medical_blog/logic/model/user_data.dart';

class Post {
  String uid;
  String title;
  String description;
  List<String> tags;
  int noOfLikes;
  int noOfDislikes;
  int noOfComments;
  Timestamp timestamp;
  List<String> likedBy;
  List<String> dislikedBy;
  List<String> savedBy;
  UserData userData;

  Post({
    this.uid,
    this.title,
    this.description,
    this.tags,
    this.noOfLikes = 0,
    this.noOfDislikes = 0,
    this.noOfComments = 0,
    this.timestamp,
    this.likedBy = const [],
    this.dislikedBy = const [],
    this.savedBy = const [],
    this.userData,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'tags': tags,
        'noOfLikes': noOfLikes,
        'noOfDislikes': noOfDislikes,
        'noOfComments': noOfComments,
        'timeStamp': timestamp,
        'likedBy': likedBy,
        'dislikedBy': dislikedBy,
        'savedBy': savedBy,
        'userData': userData.toJson(),
      };

  factory Post.fromJson(Map<dynamic, dynamic> parsedJson) {
    if (parsedJson == null || parsedJson.isEmpty) {
      return Post();
    }

    return Post(
      uid: parsedJson['uid'],
      title: parsedJson['title'],
      description: parsedJson['title'],
      tags: parsedJson['tags'],
      noOfLikes: parsedJson['noOfLikes'],
      noOfDislikes: parsedJson['noOfDislikes'],
      noOfComments: parsedJson['noOfComments'],
      timestamp: parsedJson['timeStamp'],
      likedBy: parsedJson['liked'],
      dislikedBy: parsedJson['disliked'],
      savedBy: parsedJson['savedBy'],
      userData: parsedJson['userData'],
    );
  }
}
