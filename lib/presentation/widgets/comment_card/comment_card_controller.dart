import 'package:get/get.dart';

class CommentCardController extends GetxController {
  final String commentId;
  RxInt noOfLikes = 0.obs;
  RxInt noOfDislikes = 0.obs;
  RxBool isLiked = false.obs;
  RxBool isDisliked = false.obs;

  CommentCardController({
    this.commentId,
    this.noOfLikes,
    this.noOfDislikes,
    this.isLiked,
    this.isDisliked,
  });

  void onLikeTap() {}

  void onDislikeTap() {}
}
