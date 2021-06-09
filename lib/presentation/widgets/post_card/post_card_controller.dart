import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_blog/model/post.dart';
import 'package:medical_blog/presentation/widgets/dialogs/loading_dialog.dart';
import 'package:medical_blog/presentation/widgets/modals/post_card_options_modal/post_card_options_modal.dart';
import 'package:medical_blog/presentation/widgets/modals/post_card_options_modal/post_card_options_modal_controller.dart';
import 'package:medical_blog/utils/network/firestore_service.dart';

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
    } else if (isLiked.value) {
      removeLike();
      removeLikeOrDislikeByUser(collectionName: 'likedBy');
    } else {
      addLike();
      addLikeOrDislikeByUser(collectionName: 'likedBy');
    }
    updateNoOfLikesAndDislikesFirebase();
  }

  void onDislikeTap() {
    if (isLiked.value) {
      removeLike();
      addDislike();
      removeLikeOrDislikeByUser(collectionName: 'likedBy');
      addLikeOrDislikeByUser(collectionName: 'dislikedBy');
    } else if (isDisliked.value) {
      removeDislike();
      removeLikeOrDislikeByUser(collectionName: 'dislikedBy');
    } else {
      addDislike();
      addLikeOrDislikeByUser(collectionName: 'dislikedBy');
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

  void showModal({bool isInSavedScreen}) {
    showModalBottomSheet(
      context: Get.context,
      builder: (context) {
        return PostCardOptionsModal(
          post: post,
          postId: postId,
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

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void reportThisPost() {
    //   Get.back();
    //   showModalBottomSheet(
    //       context: Get.context,
    //       builder: (context) {
    //         return Column(
    //           children: [
    //             ListTile(
    //               title: Text('abc'),
    //             ),
    //           ],
    //         );
    //       });
  }
}
