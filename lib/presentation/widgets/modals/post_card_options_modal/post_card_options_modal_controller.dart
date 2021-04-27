import 'package:get/get.dart';
import 'package:medical_blog/logic/model/post.dart';
import 'package:medical_blog/presentation/widgets/dialogs/loading_dialog.dart';
import 'package:medical_blog/utils/network/firestore_service.dart';

class PostCardOptionsModalController extends GetxController {
  FirestoreService _firestoreService = Get.find();

  PostCardOptionsModalController({
    this.isSaved,
    this.removeSavedBy,
  });

  RxBool isSaved = false.obs;
  Function removeSavedBy;

  void saveThisPost({Post post, String postId}) {
    Get.dialog(LoadingDialog());
    if (isSaved.value) {
      removeSavedBy();
      removeSaved(postId: postId);
    } else {
      addSaved(post: post, postId: postId);
    }
  }

  void removeSaved({String postId}) {
    _firestoreService.removeSavedPostByUser(postId: postId).then((value) => {
          _firestoreService
              .removeFromSavedCollection(postId: postId)
              .then((value) => {
                    isSaved.value = false,
                    Get.back(),
                    Get.back(),
                  }),
        });
  }

  void addSaved({String postId, Post post}) {
    _firestoreService.addSavedPostByUser(postId: postId).then(
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
