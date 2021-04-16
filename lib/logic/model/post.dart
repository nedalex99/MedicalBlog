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

  factory Post.fromQuerySnapshot(QueryDocumentSnapshot querySnapshot) {
    if (querySnapshot == null || !querySnapshot.exists) {
      return Post();
    }

    return Post(
      title: querySnapshot['title'],
      description: querySnapshot['title'],
      tags: querySnapshot['tags'],
      noOfLikes: querySnapshot['noOfLikes'],
      noOfDislikes: querySnapshot['noOfDislikes'],
      noOfComments: querySnapshot['noOfComments'],
      timestamp: querySnapshot['timeStamp'],
      likedBy: querySnapshot['liked'],
      dislikedBy: querySnapshot['disliked'],
      savedBy: querySnapshot['savedBy'],
      userData: querySnapshot['userData'],
    );
  }

  factory Post.fromJson(Map<String, dynamic> parsedJson) {
    if (parsedJson == null || parsedJson.isEmpty) {
      return Post();
    }

    UserData userData = UserData(
      firstName: parsedJson['userData']['firstName'],
      lastName: parsedJson['userData']['lastName'],
    );

    return Post(
      uid: parsedJson['uid'],
      title: parsedJson['title'],
      description: parsedJson['description'],
      tags: (parsedJson['tags'] as List).map((e) => e.toString()).toList(),
      noOfLikes: parsedJson['noOfLikes'],
      noOfDislikes: parsedJson['noOfDislikes'],
      noOfComments: parsedJson['noOfComments'],
      timestamp: parsedJson['timeStamp'] as Timestamp,
      likedBy: (parsedJson['likedBy'] as List).map((e) => e.toString()).toList(),
      dislikedBy:
          (parsedJson['dislikedBy'] as List).map((e) => e.toString()).toList(),
      savedBy:
          (parsedJson['savedBy'] as List).map((e) => e.toString()).toList(),
      userData: userData,
    );
  }
}
