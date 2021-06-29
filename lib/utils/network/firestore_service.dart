import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart';
import 'package:medical_blog/model/comment.dart';
import 'package:medical_blog/model/filter.dart';
import 'package:medical_blog/model/news.dart';
import 'package:medical_blog/model/post.dart';
import 'package:medical_blog/model/report.dart';
import 'package:medical_blog/model/user_data.dart';
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

  Future<void> createUser({
    String uid,
    String email,
    String firstName,
    String lastName,
    String country,
    String dateOfBirth,
  }) {
    UserData user = UserData(
      id: uid,
      email: email,
      firstName: firstName,
      lastName: lastName,
      country: country,
      dateOfBirth: dateOfBirth,
      profession: '',
      specialty: '',
      yearsOfExperience: 0,
    );

    Map<String, dynamic> userJson = user.toJson();

    return _firestoreInstance.collection('users').doc(uid).set(userJson);
  }

  Future<DocumentSnapshot> getDayRequest() async {
    return _firestoreInstance.collection('day_request').doc('1').get();
  }

  Future<void> setDayRequest(String todayMillis) async {
    return _firestoreInstance.collection('day_request').doc('1').set({
      "todayNewsFlag": todayMillis,
    });
  }

  Future<void> updateProfessionForUser({
    String uid,
    String profession,
    String specialty,
    int yearsOfExperience,
  }) async {
    return _firestoreInstance.collection('users').doc(uid).update({
      'profession': profession,
      'specialty': specialty,
      'yearsOfExperience': yearsOfExperience,
    });
  }

  Future<void> addNewsToSaved({News news}) {
    return _firestoreInstance
        .collection('saved')
        .doc(userUID)
        .collection('news')
        .doc(news.id)
        .set(news.toJson());
  }

  Future<QuerySnapshot> getAllNews() {
    return _firestoreInstance.collection('news-all').limit(15).get();
  }

  Future<QuerySnapshot> getMoreNews(DocumentSnapshot documentSnapshot) {
    return _firestoreInstance
        .collection('news-all')
        .startAfterDocument(documentSnapshot)
        .limit(15)
        .get();
  }

  Future<QuerySnapshot> getTodayNews() {
    DateTime now = DateTime.now();
    String millisMidnight = now
        .subtract(Duration(
          hours: now.hour,
          minutes: now.minute,
          seconds: now.second,
          milliseconds: now.millisecond,
          microseconds: now.microsecond,
        ))
        .millisecondsSinceEpoch
        .toString();
    return _firestoreInstance
        .collection('news-all')
        .limit(3)
        .where('publishedAt', isEqualTo: millisMidnight)
        .get();
  }

  Future<QuerySnapshot> getAllTodayNews(DocumentSnapshot documentSnapshot) {
    DateTime now = DateTime.now();
    String millisMidnight = now
        .subtract(Duration(
          hours: now.hour,
          minutes: now.minute,
          seconds: now.second,
          milliseconds: now.millisecond,
          microseconds: now.microsecond,
        ))
        .millisecondsSinceEpoch
        .toString();
    if (documentSnapshot != null) {
      return _firestoreInstance
          .collection('news-all')
          .limit(15)
          .where('publishedAt', isEqualTo: millisMidnight)
          .startAfterDocument(documentSnapshot)
          .get();
    } else {
      return _firestoreInstance
          .collection('news-all')
          .limit(15)
          .where('publishedAt', isEqualTo: millisMidnight)
          .get();
    }
  }

  Future<QuerySnapshot> getTrendingNews(DocumentSnapshot documentSnapshot) {
    if (documentSnapshot != null) {
      return _firestoreInstance
          .collection('news-all')
          .limit(3)
          .startAfterDocument(documentSnapshot)
          .get();
    } else {
      return _firestoreInstance.collection('news-all').limit(15).get();
    }
  }

  Future<QuerySnapshot> getAllTrendingNews(DocumentSnapshot documentSnapshot) {
    if (documentSnapshot != null) {
      return _firestoreInstance
          .collection('news-all')
          .limit(15)
          .startAfterDocument(documentSnapshot)
          .get();
    } else {
      return _firestoreInstance.collection('news-all').limit(3).get();
    }
  }

  Future<QuerySnapshot> getNewsByTitle({String title}) {
    return _firestoreInstance
        .collection('news-all')
        .where('caseSearch', arrayContains: title)
        .get();
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

  Future<String> addNewsToFirestore({News news}) async {
    String newsId;
    await _firestoreInstance
        .collection('news-all')
        .add(news.toJson())
        .then((value) => {
              newsId = value.id,
            });
    return newsId;
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
    await _firestoreInstance.collection('posts').doc(postId).update({
      'noOfComments': FieldValue.increment(1),
    });
    await _firestoreInstance
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

  Future<QuerySnapshot> getReports({
    String postId,
  }) {
    return _firestoreInstance
        .collection('posts')
        .doc(postId)
        .collection('reports')
        .get();
  }

  Future<QuerySnapshot> getCommentsReports({
    String postId,
    String commentId,
  }) {
    return _firestoreInstance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(commentId)
        .collection('reports')
        .get();
  }

  Future<QuerySnapshot> getComments({
    String postId,
  }) {
    return _firestoreInstance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .limit(15)
        .get();
  }

  Future<QuerySnapshot> getMoreComments({
    String postId,
    DocumentSnapshot documentSnapshot,
  }) {
    return _firestoreInstance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .limit(15)
        .startAfterDocument(documentSnapshot)
        .get();
  }

  Future<void> addSavedNewsByUser({String newsId}) {
    return _firestoreInstance.collection('news-all').doc(newsId).update({
      'savedBy': FieldValue.arrayUnion(
        [userUID],
      ),
    });
  }

  Future<void> removeSavedNewsByUser({String newsId}) {
    return _firestoreInstance.collection('news-all').doc(newsId).update({
      'savedBy': FieldValue.arrayRemove(
        [userUID],
      ),
    });
  }

  Future<void> addSavedPostByUser({String postId}) {
    return _firestoreInstance.collection('posts').doc(postId).update({
      'savedBy': FieldValue.arrayUnion(
        [userUID],
      ),
    });
  }

  Future<void> removeSavedPostByUser({String postId}) {
    return _firestoreInstance.collection('posts').doc(postId).update({
      'savedBy': FieldValue.arrayRemove(
        [userUID],
      ),
    });
  }

  Future<void> addToSavedCollection({Post post}) {
    return _firestoreInstance
        .collection('saved')
        .doc(userUID)
        .collection('posts')
        .doc(post.uid)
        .set(
          post.toJson(),
        );
  }

  Future<void> removePostFromSavedCollection({String postId}) {
    return _firestoreInstance
        .collection('saved')
        .doc(userUID)
        .collection('posts')
        .doc(postId)
        .delete();
  }

  Future<void> removeNewsFromSavedCollection({String newsId}) {
    return _firestoreInstance
        .collection('saved')
        .doc(userUID)
        .collection('news')
        .doc(newsId)
        .delete();
  }

  Future<QuerySnapshot> getNewsFromSavedCollection() {
    return _firestoreInstance
        .collection('saved')
        .doc(userUID)
        .collection('news')
        .get();
  }

  Future<QuerySnapshot> getPostsFromSavedCollection() {
    return _firestoreInstance
        .collection('saved')
        .doc(userUID)
        .collection('posts')
        .limit(15)
        .orderBy("timeStamp", descending: true)
        .get();
  }

  Future<QuerySnapshot> getMorePostsFromSavedCollection(
      DocumentSnapshot documentSnapshot) {
    return _firestoreInstance
        .collection('saved')
        .doc(userUID)
        .collection('posts')
        .limit(15)
        .orderBy("timeStamp", descending: true)
        .startAfterDocument(documentSnapshot)
        .get();
  }

  Future<QuerySnapshot> getSavedPostsWithFilters({Filter filter}) {
    if (filter.startDate != 0 && filter.endDate != 0 && filter.category != "") {
      return _firestoreInstance
          .collection('saved')
          .doc(userUID)
          .collection('posts')
          .where('timeStamp', isGreaterThanOrEqualTo: filter.startDate)
          .where('timeStamp', isLessThanOrEqualTo: filter.endDate)
          .where('tags', arrayContains: filter.category)
          .get();
    } else if (filter.startDate == 0 &&
        filter.endDate != 0 &&
        filter.category != "") {
      return _firestoreInstance
          .collection('saved')
          .doc(userUID)
          .collection('posts')
          .where('timeStamp', isLessThanOrEqualTo: filter.endDate)
          .where('tags', arrayContains: filter.category)
          .get();
    } else if (filter.startDate != 0 &&
        filter.endDate == 0 &&
        filter.category != "") {
      return _firestoreInstance
          .collection('saved')
          .doc(userUID)
          .collection('posts')
          .where('timeStamp', isGreaterThanOrEqualTo: filter.startDate)
          .where('tags', arrayContains: filter.category)
          .get();
    } else if (filter.startDate != 0 &&
        filter.endDate != 0 &&
        filter.category == "") {
      return _firestoreInstance
          .collection('saved')
          .doc(userUID)
          .collection('posts')
          .where('timeStamp', isGreaterThanOrEqualTo: filter.startDate)
          .where('timeStamp', isLessThanOrEqualTo: filter.endDate)
          .get();
    } else if (filter.startDate != 0 &&
        filter.endDate == 0 &&
        filter.category == "") {
      return _firestoreInstance
          .collection('saved')
          .doc(userUID)
          .collection('posts')
          .where('timeStamp', isGreaterThanOrEqualTo: filter.startDate)
          .get();
    } else if (filter.startDate == 0 &&
        filter.endDate != 0 &&
        filter.category == "") {
      return _firestoreInstance
          .collection('saved')
          .doc(userUID)
          .collection('posts')
          .where('timeStamp', isLessThanOrEqualTo: filter.endDate)
          .get();
    } else if (filter.startDate == 0 &&
        filter.endDate == 0 &&
        filter.category != "") {
      return _firestoreInstance
          .collection('saved')
          .doc(userUID)
          .collection('posts')
          .where('tags', arrayContains: filter.category)
          .get();
    }
  }

  Future<DocumentSnapshot> getUserFirstAndLastName() {
    return _firestoreInstance.collection('users').doc(userUID).get();
  }

  Future<QuerySnapshot> getPosts() {
    return _firestoreInstance
        .collection('posts')
        .orderBy("timeStamp", descending: true)
        .limit(15)
        .get();
  }

  Future<QuerySnapshot> getRecommendationPosts() {
    return _firestoreInstance
        .collection('posts')
        .limit(15)
        .orderBy("noOfEntries", descending: true)
        .get();
  }

  Future<QuerySnapshot> getMoreRecommendationPosts(
      DocumentSnapshot documentSnapshot) {
    return _firestoreInstance
        .collection('posts')
        .limit(15)
        .orderBy("noOfEntries", descending: true)
        .startAfterDocument(documentSnapshot)
        .get();
  }

  Future<QuerySnapshot> getMorePosts(DocumentSnapshot documentSnapshot) {
    return _firestoreInstance
        .collection('posts')
        .limit(15)
        .orderBy("noOfEntries", descending: true)
        .startAfterDocument(documentSnapshot)
        .get();
  }

  Future<QuerySnapshot> getUserPosts() {
    return _firestoreInstance
        .collection('posts')
        .limit(15)
        .orderBy("timeStamp", descending: true)
        .where("userData.id", isEqualTo: userUID)
        .get();
  }

  Future<DocumentSnapshot> getUserData() {
    return _firestoreInstance.collection('users').doc(userUID).get();
  }

  Future<void> updateProfession({String profession}) async {
    return _firestoreInstance.collection('users').doc(userUID).update({
      "profession": profession,
    });
  }

  Future<void> updateEmail({String email}) async {
    return _firestoreInstance.collection('users').doc(userUID).update({
      "email": email,
    });
  }

  Future<void> updateCountry({String country}) async {
    return _firestoreInstance.collection('users').doc(userUID).update({
      "country": country,
    });
  }

  Future<void> updateSpecialty({String specialty}) async {
    return _firestoreInstance.collection('users').doc(userUID).update({
      "specialty": specialty,
    });
  }

  Future<void> updateYearsOfExperience({int yearsOfExperience}) async {
    return _firestoreInstance.collection('users').doc(userUID).update({
      "yearsOfExperience": yearsOfExperience,
    });
  }

  Future<void> incrementNoOfEntriesForPost({String postId}) async {
    return _firestoreInstance.collection('posts').doc(postId).update({
      "noOfEntries": FieldValue.increment(1),
    });
  }

  Future<void> reportPost({String postId, Report report}) async {
    return _firestoreInstance
        .collection('posts')
        .doc(postId)
        .collection('reports')
        .add(report.toJson());
  }

  Future<void> reportComment({
    String postId,
    String commentId,
    Report report,
  }) async {
    return _firestoreInstance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(commentId)
        .collection('reports')
        .add(report.toJson());
  }

  Future<DocumentSnapshot> checkIfAlreadyReport({String postId}) async {
    return _firestoreInstance.collection('posts').doc(postId).get();
  }

  Future<void> setPostReported({
    String postId,
  }) async {
    return _firestoreInstance.collection('posts').doc(postId).update({
      'flagToDelete': true,
    });
  }

  Future<void> setCommentReported({
    String postId,
    String commentId,
  }) async {
    return _firestoreInstance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(commentId)
        .update({
      'flagToDelete': true,
    });
  }

  Future<void> deletePost({
    String postId,
  }) async {
    return _firestoreInstance.collection('posts').doc(postId).delete();
  }

  Future<void> deleteComment({
    String postId,
    String commentId,
  }) async {
    return _firestoreInstance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(commentId)
        .delete();
  }

  Future<void> updatePointsForPost({
    String postId,
    double points,
  }) {
    return _firestoreInstance.collection('posts').doc(postId).update({
      'points': FieldValue.increment(points),
    });
  }

  Future<void> updatePointsForComment({
    String postId,
    String commentId,
    double points,
  }) {
    return _firestoreInstance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(commentId)
        .update({
      'points': FieldValue.increment(points),
    });
  }
}
