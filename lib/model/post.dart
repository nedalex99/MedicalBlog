import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medical_blog/model/report.dart';
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
  List<Report> reportList;

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
    this.reportList = const [],
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
        'reports': reportList,
      };

  factory Post.fromJson(DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.data() == null ||
        (documentSnapshot.data() as Map).isEmpty) {
      return Post();
    }

    UserData userData = UserData(
      id: (documentSnapshot.data() as Map)['userData']['id'],
      firstName: (documentSnapshot.data() as Map)['userData']['firstName'],
      lastName: (documentSnapshot.data() as Map)['userData']['lastName'],
      profession: (documentSnapshot.data() as Map)['userData']['profession'],
    );

    return Post(
      uid: documentSnapshot.id,
      title: (documentSnapshot.data() as Map)['title'],
      description: (documentSnapshot.data() as Map)['description'],
      tags: ((documentSnapshot.data() as Map)['tags'] as List)
          .map((e) => e.toString())
          .toList(),
      noOfLikes: (documentSnapshot.data() as Map)['noOfLikes'],
      noOfDislikes: (documentSnapshot.data() as Map)['noOfDislikes'],
      noOfComments: (documentSnapshot.data() as Map)['noOfComments'],
      timestamp: (documentSnapshot.data() as Map)['timeStamp'] as int,
      likedBy: ((documentSnapshot.data() as Map)['likedBy'] as List)
          .map((e) => e.toString())
          .toList(),
      dislikedBy: ((documentSnapshot.data() as Map)['dislikedBy'] as List)
          .map((e) => e.toString())
          .toList(),
      savedBy: ((documentSnapshot.data() as Map)['savedBy'] as List)
          .map((e) => e.toString())
          .toList(),
      userData: userData,
      reportList: ((documentSnapshot.data() as Map)['reports'] as List)
          .map((e) => e)
          .toList(),
    );
  }
}
