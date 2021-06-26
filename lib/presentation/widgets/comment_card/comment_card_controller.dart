import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_blog/model/comment.dart';
import 'package:medical_blog/presentation/widgets/dialogs/loading_dialog.dart';
import 'package:medical_blog/presentation/widgets/modals/comment_card_options_modal.dart';
import 'package:medical_blog/utils/network/firestore_service.dart';

class CommentCardController extends GetxController {
  final Comment comment;
  final String commentId;
  RxInt noOfLikes = 0.obs;
  RxInt noOfDislikes = 0.obs;
  RxBool isLiked = false.obs;
  RxBool isDisliked = false.obs;

  FirestoreService _firestoreService = Get.find();

  CommentCardController({
    this.comment,
    this.commentId,
    this.noOfLikes,
    this.noOfDislikes,
    this.isLiked,
    this.isDisliked,
  });

  void onLikeTap({String postId}) {
    if (isDisliked.value) {
      addLike();
      removeDislike();
      addLikeOrDislikeByUser(collectionName: 'likedBy', postId: postId);
      removeLikeOrDislikeByUser(collectionName: 'dislikedBy', postId: postId);
      updatePointsForComment(
          postId: postId, addLike: true, removeDislike: true);
    } else if (isLiked.value) {
      removeLike();
      removeLikeOrDislikeByUser(collectionName: 'likedBy', postId: postId);
      updatePointsForComment(postId: postId, removeLike: true);
    } else {
      addLike();
      addLikeOrDislikeByUser(collectionName: 'likedBy', postId: postId);
      updatePointsForComment(postId: postId, addLike: true);
    }
    updateNoOfLikesAndDislikesFirebase(postId: postId);
  }

  void onDislikeTap({String postId}) {
    if (isLiked.value) {
      removeLike();
      addDislike();
      removeLikeOrDislikeByUser(collectionName: 'likedBy', postId: postId);
      addLikeOrDislikeByUser(collectionName: 'dislikedBy', postId: postId);
      updatePointsForComment(
          postId: postId, addDislike: true, removeLike: true);
    } else if (isDisliked.value) {
      removeDislike();
      removeLikeOrDislikeByUser(collectionName: 'dislikedBy', postId: postId);
      updatePointsForComment(postId: postId, removeDislike: true);
    } else {
      addDislike();
      addLikeOrDislikeByUser(collectionName: 'dislikedBy', postId: postId);
      updatePointsForComment(postId: postId, addDislike: true);
    }
    updateNoOfLikesAndDislikesFirebase(postId: postId);
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

  Future<void> updateNoOfLikesAndDislikesFirebase({
    String postId,
  }) async {
    Get.dialog(LoadingDialog());
    await _firestoreService
        .updateNoOfLikesAndDislikesToComment(
          postId: postId,
          commentId: commentId,
          noOfLikes: noOfLikes.value,
          noOfDislikes: noOfDislikes.value,
        )
        .then((value) => {
              Get.back(),
            });
  }

  void addLikeOrDislikeByUser({
    String collectionName,
    String postId,
  }) async {
    await _firestoreService.addLikedOrDislikedByUserCommentPost(
      fieldName: collectionName,
      commentId: commentId,
      postId: postId,
    );
  }

  void removeLikeOrDislikeByUser({
    String collectionName,
    String postId,
  }) async {
    await _firestoreService.removeLikedOrDislikedByUserCommentPost(
      fieldName: collectionName,
      commentId: commentId,
      postId: postId,
    );
  }

  void showModal({
    bool alreadyReported,
    String postId,
  }) {
    showModalBottomSheet(
      context: Get.context,
      builder: (context) {
        return CommentCardOptionsModal(
          comment: comment,
          commentId: commentId,
          postId: postId,
          alreadyReported: alreadyReported,
        );
      },
    );
  }

  Future<void> updatePointsForComment({
    String postId,
    bool addLike = false,
    bool addDislike = false,
    bool removeLike = false,
    bool removeDislike = false,
  }) async {
    if (addLike && removeDislike) {
      await _firestoreService.updatePointsForComment(
        postId: postId,
        commentId: commentId,
        points: 2.5,
      );
    } else if (addDislike && removeLike) {
      await _firestoreService.updatePointsForComment(
        postId: postId,
        commentId: commentId,
        points: -2.5,
      );
    } else if (removeLike) {
      await _firestoreService.updatePointsForComment(
        postId: postId,
        commentId: commentId,
        points: -2.0,
      );
    } else if (addLike) {
      await _firestoreService.updatePointsForComment(
        postId: postId,
        commentId: commentId,
        points: 2.0,
      );
    } else if (removeDislike) {
      await _firestoreService.updatePointsForComment(
        postId: postId,
        commentId: commentId,
        points: 0.5,
      );
    } else if (addDislike) {
      await _firestoreService.updatePointsForComment(
        postId: postId,
        commentId: commentId,
        points: -0.5,
      );
    }
  }
}
