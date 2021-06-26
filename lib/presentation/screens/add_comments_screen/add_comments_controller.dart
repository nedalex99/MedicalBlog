import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medical_blog/model/comment.dart';
import 'package:medical_blog/model/report.dart';
import 'package:medical_blog/model/user_data.dart';
import 'package:medical_blog/presentation/widgets/dialogs/loading_dialog.dart';
import 'package:medical_blog/presentation/widgets/dialogs/modal_info_error_dialog.dart';
import 'package:medical_blog/presentation/widgets/post_card/post_card_controller.dart';
import 'package:medical_blog/utils/network/firestore_service.dart';
import 'package:medical_blog/utils/session_temp.dart';
import 'package:medical_blog/utils/util_functions.dart';

class AddCommentsController extends GetxController {
  String commentText;
  RxList<Comment> commentsFromFirestore = List<Comment>().obs;
  RxString dropDownValue = "Oldest first".obs;
  Rx<ScrollController> scrollController = ScrollController().obs;
  FirestoreService _firestoreService = Get.find();
  DocumentSnapshot documentSnapshot;

  final String postId;

  AddCommentsController({
    this.postId,
  });

  void commentTextCallback(String value) {
    commentText = value;
  }

  @override
  void onInit() {
    getComments(
      postId: postId,
    );
    scrollController.value.addListener(() {
      if (scrollController.value.position.pixels ==
          scrollController.value.position.maxScrollExtent) {
        getMoreComments();
      }
    });
    super.onInit();
  }

  Future<void> getComments({String postId}) async {
    String url = '';
    await _firestoreService.getComments(postId: postId).then((value) => {
          value.docs.forEach((element) async {
            documentSnapshot = element;
            Comment comment = Comment.fromJson(element);
            comment.commentId = element.id;
            url = await getPhoto(id: comment.userData.id);
            comment.image = url;
            List<Report> reportList = [];
            await _firestoreService
                .getCommentsReports(
                  postId: postId,
                  commentId: element.id,
                )
                .then((value) => {
                      value.docs.forEach((element) {
                        Report report = Report.fromJson(element);
                        if (report.userId == userUID) {
                          comment.alreadyReported = true;
                        } else {
                          comment.alreadyReported = false;
                        }
                        reportList.add(report);
                      }),
                    });
            comment.reportList = reportList;

            if (comment.flagToDelete) {
              await _firestoreService.deleteComment(
                  postId: postId, commentId: comment.commentId);
              Get.dialog(
                  ModalErrorDialog(errorText: 'Your post has been removed!'));
            } else {
              var map = Map();
              reportList.forEach((element) {
                if (!map.containsKey(element.reportReason)) {
                  map[element.reportReason] = 1;
                } else {
                  map[element.reportReason] += 1;
                }
              });

              if (map.values.contains(3) || comment.points <= 0) {
                if (comment.userData.id == userUID) {
                  await _firestoreService.deleteComment(
                    postId: postId,
                    commentId: comment.commentId,
                  );
                  Get.dialog(ModalErrorDialog(
                      errorText: 'Your comment has been removed!'));
                } else {
                  await _firestoreService.setCommentReported(
                    postId: postId,
                    commentId: comment.commentId,
                  );
                }
              } else {
                commentsFromFirestore.add(comment);
              }
            }
          }),
        });
    commentsFromFirestore
        .sort((a, b) => b.timestamp.seconds.compareTo(a.timestamp.seconds));
  }

  Future<void> getMoreComments({
    String postId,
  }) async {
    String url = '';
    await _firestoreService
        .getMoreComments(
          postId: postId,
          documentSnapshot: documentSnapshot,
        )
        .then((value) => {
              value.docs.forEach((element) async {
                documentSnapshot = element;
                Comment comment = Comment.fromJson(element);
                comment.commentId = element.id;
                url = await getPhoto(id: comment.userData.id);
                comment.image = url;
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
            profession: value['profession'] as String,
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
    PostCardController _postsController = Get.find(tag: postId);
    _postsController.noOfComments.value++;
    scrollController.value.jumpTo(
      scrollController.value.position.maxScrollExtent,
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
