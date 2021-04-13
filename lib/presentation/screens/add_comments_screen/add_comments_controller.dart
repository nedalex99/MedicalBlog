import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:medical_blog/logic/model/comment.dart';
import 'package:medical_blog/logic/model/user_data.dart';
import 'package:medical_blog/presentation/widgets/dialogs/loading_dialog.dart';
import 'package:medical_blog/utils/network/firestore_service.dart';

class AddCommentsController extends GetxController {
  String commentText;
  RxList<Comment> commentsFromFirestore = List<Comment>().obs;
  FirestoreService _firestoreService = Get.find();

  void commentTextCallback(String value) {
    commentText = value;
  }

  Future<void> getComments({String postId}) async {
    await _firestoreService.getComments(postId: postId).then((value) => {
          value.docs.forEach((element) {
            Comment comment = Comment.fromJson(element.data());
            comment.commentId = element.id;
            commentsFromFirestore.add(comment);
          }),
        });
    commentsFromFirestore
        .sort((a, b) => b.timestamp.seconds.compareTo(a.timestamp.seconds));
  }

  Future<void> addCommentToPost({String postId}) async {
    UserData userData;
    Get.dialog(LoadingDialog());
    await _firestoreService.getUserFirstAndLastName().then((value) => {
          userData = UserData(
            firstName: value['firstName'] as String,
            lastName: value['lastName'] as String,
          ),
        });
    Comment comment = Comment(
      commentText: commentText,
      timestamp: Timestamp.now(),
      userData: userData,
    );
    await _firestoreService
        .addCommentToPost(
          postId: postId,
          comment: comment,
        )
        .then((value) => {
              comment.commentId = value,
              Get.back(),
            });
    commentsFromFirestore.insert(0, comment);
  }
}
