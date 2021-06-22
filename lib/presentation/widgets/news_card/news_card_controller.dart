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

  Future<void> onSaveIconClick({News news, Function deleteNewsCallback}) async {
    Get.dialog(LoadingDialog());
    if (!isSaved.value) {
      await _firestoreService
          .addSavedNewsByUser(newsId: news.id)
          .then((value) async => {
                news.savedBy.add(userUID),
                await _firestoreService
                    .addNewsToSaved(news: news)
                    .then((value) => {
                          isSaved.value = true,
                          Get.back(),
                        }),
              });
    } else {
      await _firestoreService
          .removeSavedNewsByUser(newsId: news.id)
          .then((value) async => {
                await _firestoreService
                    .removeNewsFromSavedCollection(newsId: news.id)
                    .then((value) => {
                          isSaved.value = false,
                          Get.back(),
                        }),
              });
    }
  }
}
