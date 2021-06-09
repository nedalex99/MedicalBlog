import 'package:get/get.dart';
import 'package:medical_blog/model/news.dart';
import 'package:medical_blog/presentation/widgets/dialogs/loading_dialog.dart';
import 'package:medical_blog/utils/network/firestore_service.dart';
import 'package:medical_blog/utils/session_temp.dart';

class NewsCardController extends GetxController {
  FirestoreService _firestoreService = Get.find();
  RxBool isSaved = false.obs;

  NewsCardController({
    this.isSaved,
  });

  void onSaveIconClick({News news}) {
    Get.dialog(LoadingDialog());
    if (!isSaved.value) {
      _firestoreService.addSavedNewsByUser(newsId: news.id).then((value) => {
            news.savedBy.add(userUID),
            _firestoreService.addNewsToSaved(news: news).then((value) => {
                  isSaved.value = true,
                  Get.back,
                  Get.back,
                }),
          });
    } else {
      _firestoreService.removeSavedNewsByUser(newsId: news.id).then((value) => {
            _firestoreService
                .removeNewsFromSavedCollection(newsId: news.id)
                .then((value) => {
                      isSaved.value = false,
                      Get.back(),
                    }),
          });
    }
  }
}
