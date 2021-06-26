import 'package:get/get.dart';
import 'package:medical_blog/model/comment.dart';
import 'package:medical_blog/presentation/widgets/dialogs/loading_dialog.dart';
import 'package:medical_blog/utils/network/firestore_service.dart';

class CommentCardOptionsModalController extends GetxController {
  FirestoreService _firestoreService = Get.find();

  CommentCardOptionsModalController({
    this.isSaved,
    this.isInSavedScreen = false,
  });

  RxBool isSaved = false.obs;
  bool isInSavedScreen;


}
