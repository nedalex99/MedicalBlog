import 'package:get/get.dart';
import 'package:medical_blog/logic/model/post.dart';
import 'package:medical_blog/presentation/screens/saved_screen/saved_screen_controller.dart';
import 'package:medical_blog/presentation/widgets/dialogs/loading_dialog.dart';
import 'package:medical_blog/utils/network/firestore_service.dart';

class PostCardOptionsModalController extends GetxController {
  FirestoreService _firestoreService = Get.find();

  PostCardOptionsModalController({
    this.isSaved,
    this.isInSavedScreen = false,
  });

  RxBool isSaved = false.obs;
  bool isInSavedScreen;

  Future<void> saveThisPost({Post post, String postId}) async {
    Get.dialog(LoadingDialog());
    if (isSaved.value) {
      removeSaved(postId: postId);
      if (isInSavedScreen) {
        SavedScreenController savedScreenController = Get.find();
        savedScreenController.removeWithPostId(postId);
      }
    } else {
      addSaved(post: post, postId: postId);
    }
  }

  Future<void> removeSaved({String postId}) async {
    await _firestoreService
        .removeSavedPostByUser(postId: postId)
        .then((value) => {
              _firestoreService
                  .removeFromSavedCollection(postId: postId)
                  .then((value) => {
                        isSaved.value = false,
                        Get.back(),
                        Get.back(),
                      }),
            });
  }

  Future<void> addSaved({String postId, Post post}) async {
    await _firestoreService.addSavedPostByUser(postId: postId).then(
          (value) => {
            _firestoreService.addToSavedCollection(post: post).then((value) => {
                  this.isSaved.value = true,
                  Get.back(),
                  Get.back(),
                }),
          },
        );
  }
}
