import 'package:get/get.dart';
import 'package:medical_blog/model/news.dart';
import 'package:medical_blog/presentation/widgets/dialogs/loading_dialog.dart';
import 'package:medical_blog/utils/network/firestore_service.dart';

class NewsCardController extends GetxController {
  FirestoreService _firestoreService = Get.find();

  void addNewsToSaved({News news}) {
    Get.dialog(LoadingDialog());
    _firestoreService.addNewsToSaved(news: news).then((value) => {
          Get.back(),
        });
  }
}
