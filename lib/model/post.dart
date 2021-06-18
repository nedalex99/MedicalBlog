import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medical_blog/model/user_data.dart';

class Post {
  String uid;
  String title;
  String description;
  List<String> tags;
  int noOfLikes;
  int noOfDislikes;
  int noOfComments;
  int timestamp;
  List<String> likedBy;
  List<String> dislikedBy;
  List<String> savedBy;
  UserData userData;
  String image;

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
    this.image,
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

  factory Post.fromJson(DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.data() == null || documentSnapshot.data().isEmpty) {
      return Post();
    }

    UserData userData = UserData(
      id: documentSnapshot.data()['userData']['id'],
      firstName: documentSnapshot.data()['userData']['firstName'],
      lastName: documentSnapshot.data()['userData']['lastName'],
      profession: documentSnapshot.data()['userData']['profession'],
    );

    return Post(
      uid: documentSnapshot.id,
      title: documentSnapshot.data()['title'],
      description: documentSnapshot.data()['description'],
      tags: (documentSnapshot.data()['tags'] as List).map((e) => e.toString()).toList(),
      noOfLikes: documentSnapshot.data()['noOfLikes'],
      noOfDislikes: documentSnapshot.data()['noOfDislikes'],
      noOfComments: documentSnapshot.data()['noOfComments'],
      timestamp: documentSnapshot.data()['timeStamp'] as int,
      likedBy: (documentSnapshot.data()['likedBy'] as List).map((e) => e.toString()).toList(),
      dislikedBy:
          (documentSnapshot.data()['dislikedBy'] as List).map((e) => e.toString()).toList(),
      savedBy:
          (documentSnapshot.data()['savedBy'] as List).map((e) => e.toString()).toList(),
      userData: userData,
    );
  }
}
