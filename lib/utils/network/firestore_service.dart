import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medical_blog/logic/model/post.dart';
import 'package:medical_blog/logic/model/user_data.dart';
import 'package:medical_blog/utils/session_temp.dart';

class FirestoreService {
  static Future<FirestoreService> get _instance async =>
      _firestoreService ??= FirestoreService();
  static FirestoreService _firestoreService;

  static Future<FirestoreService> init() async {
    if (_firestoreService == null) _firestoreService = await _instance;
    return _firestoreService;
  }

  FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;

  Future<void> createUser(
      {String uid,
      String email,
      String firstName,
      String lastName,
      String country}) {
    UserData user = UserData(
      email: email,
      firstName: firstName,
      lastName: lastName,
      country: country,
    );

    Map<String, dynamic> userJson = user.toJson();

    return _firestoreInstance.collection('users').doc(uid).set(userJson);
  }

  Future<void> addPost({
    Post post,
  }) {
    Map<String, dynamic> postJson = post.toJson();

    return _firestoreInstance.collection('posts').add(postJson);
  }

  Future<void> updateNoOfLikesAndDislikes({
    String postId,
    int noOfLikes,
    int noOfDislikes,
  }) {
    return _firestoreInstance.collection('posts').doc(postId).update({
      'noOfLikes': noOfLikes,
      'noOfDislikes': noOfDislikes,
    });
  }

  Future<void> updateLikedDislikePosts({
    String postId,
    String collectionName,
  }) {
    return _firestoreInstance.collection(collectionName).doc(userUID).set({
      'postId': postId,
    });
  }

  Future<DocumentSnapshot> getUserFirstAndLastName() {
    return _firestoreInstance.collection('users').doc(userUID).get();
  }

  Future<QuerySnapshot> getPosts() {
    return _firestoreInstance.collection('posts').get();
  }
}
