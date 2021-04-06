import 'package:get/get.dart';
import 'package:medical_blog/presentation/widgets/dialogs/loading_dialog.dart';
import 'package:medical_blog/utils/constants/colors.dart';
import 'package:medical_blog/utils/network/firestore_service.dart';

class AddPostController extends GetxController {
  String title = "";
  String description = "";

  RxInt addTextColor = kInactiveAddPostTextHex.obs;

  FirestoreService _firestoreService = Get.find();

  void titleCallback(String value) {
    title = value;
    setAddTextColor();
  }

  void descriptionCallback(String value) {
    description = value;
    setAddTextColor();
  }

  void setAddTextColor() {
    if (title != "" && description != "") {
      addTextColor.value = kActiveAddPostTextHex;
    } else {
      addTextColor.value = kInactiveAddPostTextHex;
    }
  }

  Future<void> addPost() async {
    Get.dialog(LoadingDialog());
    await _firestoreService
        .addPost(title: title, description: description)
        .then((value) => {
              Get.back(),
            });
  }
}
