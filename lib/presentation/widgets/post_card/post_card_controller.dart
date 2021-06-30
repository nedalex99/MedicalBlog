import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_blog/model/post.dart';
import 'package:medical_blog/model/report.dart';
import 'package:medical_blog/presentation/screens/add_comments_screen/add_comments_controller.dart';
import 'package:medical_blog/presentation/screens/add_comments_screen/add_comments_screen.dart';
import 'package:medical_blog/presentation/screens/posts_screen/posts_controller.dart';
import 'package:medical_blog/presentation/widgets/dialogs/loading_dialog.dart';
import 'package:medical_blog/presentation/widgets/dialogs/modal_info_error_dialog.dart';
import 'package:medical_blog/presentation/widgets/modals/post_card_options_modal/post_card_options_modal.dart';
import 'package:medical_blog/presentation/widgets/modals/post_card_options_modal/post_card_options_modal_controller.dart';
import 'package:medical_blog/utils/network/firestore_service.dart';
import 'package:medical_blog/utils/session_temp.dart';

class PostCardController extends GetxController {
  final String postId;
  final Post post;
  RxInt noOfLikes = 0.obs;
  RxInt noOfDislikes = 0.obs;
  RxInt noOfComments = 0.obs;
  RxBool isLiked = false.obs;
  RxBool isDisliked = false.obs;
  RxBool isSaved = false.obs;

  FirestoreService _firestoreService = Get.find();

  PostCardController({
    this.post,
    this.postId,
    this.noOfLikes,
    this.noOfDislikes,
    this.noOfComments,
    this.isLiked,
    this.isDisliked,
    this.isSaved,
  });

  void onLikeTap() {
    if (isDisliked.value) {
      addLike();
      removeDislike();
      addLikeOrDislikeByUser(collectionName: 'likedBy');
      removeLikeOrDislikeByUser(collectionName: 'dislikedBy');
      updatePointsForPost(addLike: true, removeDislike: true);
    } else if (isLiked.value) {
      removeLike();
      removeLikeOrDislikeByUser(collectionName: 'likedBy');
      updatePointsForPost(removeLike: true);
    } else {
      addLike();
      addLikeOrDislikeByUser(collectionName: 'likedBy');
      updatePointsForPost(addLike: true);
    }
    updateNoOfLikesAndDislikesFirebase();
  }

  void onDislikeTap() {
    if (isLiked.value) {
      removeLike();
      addDislike();
      removeLikeOrDislikeByUser(collectionName: 'likedBy');
      addLikeOrDislikeByUser(collectionName: 'dislikedBy');
      updatePointsForPost(addDislike: true, removeLike: true);
    } else if (isDisliked.value) {
      removeDislike();
      removeLikeOrDislikeByUser(collectionName: 'dislikedBy');
      updatePointsForPost(removeDislike: true);
    } else {
      addDislike();
      addLikeOrDislikeByUser(collectionName: 'dislikedBy');
      updatePointsForPost(addDislike: true);
    }
    updateNoOfLikesAndDislikesFirebase();
  }

  void addDislike() {
    isDisliked.value = true;
    noOfDislikes++;
  }

  void removeDislike() {
    noOfDislikes--;
    isDisliked.value = false;
  }

  void addLike() {
    noOfLikes++;
    isLiked.value = true;
  }

  void removeLike() {
    noOfLikes--;
    isLiked.value = false;
  }

  Future<void> updateNoOfLikesAndDislikesFirebase() async {
    Get.dialog(LoadingDialog());
    await _firestoreService
        .updateNoOfLikesAndDislikes(
          postId: postId,
          noOfLikes: noOfLikes.value,
          noOfDislikes: noOfDislikes.value,
        )
        .then((value) => {
              Get.back(),
            });
  }

  void addLikeOrDislikeByUser({String collectionName}) async {
    await _firestoreService.addLikedOrDislikedByUserPost(
      fieldName: collectionName,
      postId: postId,
    );
  }

  void removeLikeOrDislikeByUser({String collectionName}) async {
    await _firestoreService.removeLikedOrDislikedByUserPost(
      fieldName: collectionName,
      postId: postId,
    );
  }

  void showModal({
    bool isInSavedScreen,
    bool alreadyReported,
    Function removeFromSaved,
  }) {
    showModalBottomSheet(
      context: Get.context,
      builder: (context) {
        return PostCardOptionsModal(
          post: post,
          postId: postId,
          alreadyReported: alreadyReported,
          reportPostCallback: reportPost,
          removePostFromSaved: removeFromSaved,
          isInSavedScreen: isInSavedScreen,
          controller: Get.put(
            PostCardOptionsModalController(
              isSaved: isSaved,
              isInSavedScreen: isInSavedScreen,
            ),
            tag: postId,
          ),
        );
      },
    );
  }

  Future<void> reportPost(Report report) async {
    post.reportList.add(report);
    post.points -= 5;
    if (post.flagToDelete) {
      await _firestoreService.deletePost(postId: post.uid);
      Get.dialog(ModalErrorDialog(errorText: 'Your post has been removed!'));
    } else {
      var map = Map();
      PostsController postsController = Get.find();
      post.reportList.forEach((element) {
        if (!map.containsKey(element.reportReason)) {
          map[element.reportReason] = 1;
        } else {
          map[element.reportReason] += 1;
        }
      });

      if (map.values.contains(3) || post.points <= 0) {
        if (post.userData.id == userUID) {
          await _firestoreService.deletePost(postId: post.uid);
          postsController.postsFromFirestore
              .removeWhere((element) => element.uid == post.uid);
          Get.dialog(
              ModalErrorDialog(errorText: 'Your post has been removed!'));
        } else {
          await _firestoreService.setPostReported(postId: post.uid);
          post.flagToDelete = true;
          postsController.postsFromFirestore
              .removeWhere((element) => element.uid == post.uid);
        }
      } else {}
    }
    if (report.userId == userUID) {
      post.alreadyReported = true;
    }
  }

  void saveThisPost() {
    Get.dialog(LoadingDialog());
    if (isSaved.value) {
      _firestoreService.removeSavedPostByUser(postId: postId).then((value) => {
            _firestoreService
                .removePostFromSavedCollection(postId: postId)
                .then((value) => {
                      isSaved.value = false,
                      Get.back(),
                      Get.back(),
                    }),
          });
    } else {
      _firestoreService.addSavedPostByUser(postId: postId).then(
            (value) => {
              _firestoreService
                  .addToSavedCollection(post: post)
                  .then((value) => {
                        isSaved.value = true,
                        Get.back(),
                        Get.back(),
                      }),
            },
          );
    }
  }

  void getToAddComments({PostCardController postCardController}) {
    incrementNoOfEntriesForPost();
    Get.to(
      () => AddCommentsScreen(
        post: post,
        postCardController: postCardController,
        addCommentsController: Get.put(
          AddCommentsController(
            postId: post.uid,
          ),
        ),
      ),
    );
  }

  Future<void> incrementNoOfEntriesForPost() async {
    await _firestoreService.incrementNoOfEntriesForPost(postId: postId);
  }

  Future<void> updatePointsForPost({
    bool addLike = false,
    bool addDislike = false,
    bool removeLike = false,
    bool removeDislike = false,
  }) async {
    if (addLike && removeDislike) {
      await _firestoreService.updatePointsForPost(postId: postId, points: 2.5);
    } else if (addDislike && removeLike) {
      await _firestoreService.updatePointsForPost(postId: postId, points: -2.5);
    } else if (removeLike) {
      await _firestoreService.updatePointsForPost(postId: postId, points: -2.0);
    } else if (addLike) {
      await _firestoreService.updatePointsForPost(postId: postId, points: 2.0);
    } else if (removeDislike) {
      await _firestoreService.updatePointsForPost(postId: postId, points: 0.5);
    } else if (addDislike) {
      await _firestoreService.updatePointsForPost(postId: postId, points: -0.5);
    }
  }
}
