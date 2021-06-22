import 'package:get/get.dart';
import 'package:medical_blog/presentation/widgets/dialogs/loading_dialog.dart';
import 'package:medical_blog/utils/network/firestore_service.dart';

class CommentCardController extends GetxController {
  final String commentId;
  RxInt noOfLikes = 0.obs;
  RxInt noOfDislikes = 0.obs;
  RxBool isLiked = false.obs;
  RxBool isDisliked = false.obs;

  FirestoreService _firestoreService = Get.find();

  CommentCardController({
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
    } else if (isLiked.value) {
      removeLike();
      removeLikeOrDislikeByUser(collectionName: 'likedBy', postId: postId);
    } else {
      addLike();
      addLikeOrDislikeByUser(collectionName: 'likedBy', postId: postId);
    }
    updateNoOfLikesAndDislikesFirebase(postId: postId);
  }

  void onDislikeTap({String postId}) {
    if (isLiked.value) {
      removeLike();
      addDislike();
      removeLikeOrDislikeByUser(collectionName: 'likedBy', postId: postId);
      addLikeOrDislikeByUser(collectionName: 'dislikedBy', postId: postId);
    } else if (isDisliked.value) {
      removeDislike();
      removeLikeOrDislikeByUser(collectionName: 'dislikedBy', postId: postId);
    } else {
      addDislike();
      addLikeOrDislikeByUser(collectionName: 'dislikedBy', postId: postId);
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

  Future<void> updateNoOfLikesAndDislikesFirebase({String postId}) async {
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

  void addLikeOrDislikeByUser({String collectionName, String postId}) async {
    await _firestoreService.addLikedOrDislikedByUserCommentPost(
      fieldName: collectionName,
      commentId: commentId,
      postId: postId,
    );
  }

  void removeLikeOrDislikeByUser({String collectionName, String postId}) async {
    await _firestoreService.removeLikedOrDislikedByUserCommentPost(
      fieldName: collectionName,
      commentId: commentId,
      postId: postId,
    );
  }
}
