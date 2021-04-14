import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medical_blog/logic/model/comment.dart';
import 'package:medical_blog/logic/model/user_data.dart';
import 'package:medical_blog/presentation/widgets/dialogs/loading_dialog.dart';
import 'package:medical_blog/utils/network/firestore_service.dart';

class AddCommentsController extends GetxController {
  String commentText;
  RxList<Comment> commentsFromFirestore = List<Comment>().obs;
  RxString dropDownValue = "Oldest first".obs;
  ScrollController scrollController = ScrollController();
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
    commentsFromFirestore.add(comment);
    scrollController.jumpTo(
      scrollController.position.maxScrollExtent,
    );
    FocusScope.of(Get.context).unfocus();
  }

  void setNewDropDownValue({String value}) {
    if (dropDownValue.value != value) {
      switch (value) {
        case 'Oldest first':
          commentsFromFirestore.sort(
              (a, b) => a.timestamp.seconds.compareTo(b.timestamp.seconds));
          break;
        case 'Newest first':
          commentsFromFirestore.sort(
              (a, b) => b.timestamp.seconds.compareTo(a.timestamp.seconds));
          break;
        case 'Most likes first':
          commentsFromFirestore
              .sort((a, b) => b.noOfLikes.compareTo(a.noOfLikes));
          break;
        case 'Most dislikes first':
          commentsFromFirestore
              .sort((a, b) => b.noOfDislikes.compareTo(a.noOfDislikes));
          break;
      }
    }
    dropDownValue.value = value;
  }
}
