import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medical_blog/model/news.dart';
import 'package:medical_blog/presentation/widgets/dialogs/loading_dialog.dart';
import 'package:medical_blog/utils/network/firestore_service.dart';
import 'package:medical_blog/utils/session_temp.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsCardController extends GetxController {
  FirestoreService _firestoreService = Get.find();
  RxBool isSaved = false.obs;

  NewsCardController({
    this.isSaved,
  });

  Future<void> onSaveIconClick({
    News news,
    Function deleteNewsCallback,
    bool isInSavedScreen,
  }) async {
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
                          if (isInSavedScreen)
                            {
                              deleteNewsCallback(news.id),
                            },
                          isSaved.value = false,
                          Get.back(),
                        }),
              });
    }
  }

  Future<void> launchBrowser({
    String url,
  }) async {
    await launch(
      url,
      forceWebView: true,
    );
  }

  Future<void> onShare({
    BuildContext context,
    String url,
  }) async {
    final RenderBox box = context.findRenderObject();

    await Share.share(
      url,
      subject: 'Look what I found!',
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    );
  }
}
