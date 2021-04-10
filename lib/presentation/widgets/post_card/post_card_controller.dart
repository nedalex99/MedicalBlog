import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_blog/presentation/widgets/dialogs/loading_dialog.dart';
import 'package:medical_blog/utils/network/firestore_service.dart';
import 'package:get/get.dart';

class PostCardController extends GetxController {
  final String postId;

  RxInt noOfLikes = 0.obs;
  RxInt noOfDislikes = 0.obs;
  RxInt noOfComments = 0.obs;
  RxBool isLiked = false.obs;
  RxBool isDisliked = false.obs;
  Rx<IconData> likeIcon = Icons.thumb_up_alt_outlined.obs;
  Rx<IconData> dislikeIcon = Icons.thumb_down_alt_outlined.obs;
  List<String> likedList = [];
  List<String> dislikedList = [];

  FirestoreService _firestoreService = Get.find();

  PostCardController({
    this.postId,
    this.noOfLikes,
    this.noOfDislikes,
    this.noOfComments,
    this.isLiked,
    this.isDisliked,
  });

  void onLikeTap() {
    if (isDisliked.value) {
      addLike();
      removeDislike();
      //addToLikedRemoveFromDislikedPosts();
    } else if (isLiked.value) {
      removeLike();
      updateLikedDislikedPostsFirebase(collectionName: 'liked-posts');
      //updateLikedPostsFirebase();
    } else {
      addLike();
      updateLikedDislikedPostsFirebase(collectionName: 'liked-posts');
      //updateLikedPostsFirebase();
    }
    updateNoOfLikesAndDislikesFirebase();
  }

  void onDislikeTap() {
    if (isLiked.value) {
      removeLike();
      addDislike();
    } else if (isDisliked.value) {
      removeDislike();
    } else {
      addDislike();
    }
    updateNoOfLikesAndDislikesFirebase();
  }

  void addDislike() {
    dislikeIcon.value = Icons.thumb_down_alt;
    isDisliked.value = true;
    noOfDislikes++;
  }

  void removeDislike() {
    dislikeIcon.value = Icons.thumb_down_alt_outlined;
    noOfDislikes--;
    isDisliked.value = false;
  }

  void addLike() {
    likeIcon.value = Icons.thumb_up_alt;
    noOfLikes++;
    isLiked.value = true;
  }

  void removeLike() {
    likeIcon.value = Icons.thumb_up_alt_outlined;
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
              updateLikedDislikedPostsFirebase(),
              Get.back(),
            });
  }

  void updateLikedDislikedPostsFirebase({String collectionName}) async {
    await _firestoreService.updateLikedDislikePosts(
      collectionName: collectionName,
      postId: postId,
    );
  }
}
