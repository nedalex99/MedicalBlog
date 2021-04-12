import 'package:get/get.dart';
import 'package:medical_blog/presentation/widgets/dialogs/loading_dialog.dart';
import 'package:medical_blog/utils/network/firestore_service.dart';

class PostCardController extends GetxController {
  final String postId;

  RxInt noOfLikes = 0.obs;
  RxInt noOfDislikes = 0.obs;
  RxInt noOfComments = 0.obs;
  RxBool isLiked = false.obs;
  RxBool isDisliked = false.obs;

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
}
