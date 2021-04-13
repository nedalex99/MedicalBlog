import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medical_blog/logic/model/comment.dart';
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

  Future<String> addPost({
    Post post,
  }) async {
    Map<String, dynamic> postJson = post.toJson();
    String postId;
    await _firestoreInstance.collection('posts').add(postJson).then((value) => {
          postId = value.id,
        });
    return postId;
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

  Future<void> addLikedOrDislikedByUserPost({String postId, String fieldName}) {
    return _firestoreInstance.collection('posts').doc(postId).update({
      fieldName: FieldValue.arrayUnion(
        [userUID],
      ),
    });
  }

  Future<void> removeLikedOrDislikedByUserPost({
    String postId,
    String fieldName,
  }) {
    return _firestoreInstance.collection('posts').doc(postId).update({
      fieldName: FieldValue.arrayRemove(
        [userUID],
      ),
    });
  }

  Future<String> addCommentToPost({
    String postId,
    Comment comment,
  }) async {
    String commentId;
    _firestoreInstance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add(comment.toJson())
        .then((value) => {
              commentId = value.id,
            });
    return commentId;
  }

  Future<void> updateNoOfLikesAndDislikesToComment({
    String postId,
    String commentId,
    int noOfLikes,
    int noOfDislikes,
  }) {
    return _firestoreInstance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(commentId)
        .update({
      'noOfLikes': noOfLikes,
      'noOfDislikes': noOfDislikes,
    });
  }

  Future<void> addLikedOrDislikedByUserCommentPost({
    String postId,
    String commentId,
    String fieldName,
  }) {
    return _firestoreInstance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(commentId)
        .update({
      fieldName: FieldValue.arrayUnion(
        [userUID],
      ),
    });
  }

  Future<void> removeLikedOrDislikedByUserCommentPost({
    String postId,
    String commentId,
    String fieldName,
  }) {
    return _firestoreInstance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(commentId)
        .update({
      fieldName: FieldValue.arrayRemove(
        [userUID],
      ),
    });
  }

  Future<QuerySnapshot> getComments({String postId}) {
    return _firestoreInstance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .get();
  }

  Future<DocumentSnapshot> getUserFirstAndLastName() {
    return _firestoreInstance.collection('users').doc(userUID).get();
  }

  Future<QuerySnapshot> getPosts() {
    return _firestoreInstance.collection('posts').get();
  }
}
