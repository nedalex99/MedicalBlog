import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medical_blog/logic/model/news.dart';
import 'package:medical_blog/utils/constants/strings.dart';
import 'package:medical_blog/utils/network/firestore_service.dart';
import 'package:medical_blog/utils/network/get_news_request.dart';
import 'package:medical_blog/utils/user_preferences.dart';

class DashboardController extends GetxController {
  FirestoreService _firestoreService = Get.find();
  RxList<News> newsList = List<News>().obs;
  RxList<News> todayNewsList = List<News>().obs;
  RxList<News> trendingNewsList = List<News>().obs;
  Rx<ScrollController> scrollController = ScrollController().obs;
  DocumentSnapshot documentSnapshot;
  RxString title = "".obs;

  GetNewsRequest _getNewsRequest = Get.find();
  PreferencesUtils _prefs = Get.find();

  void titleCallback(String value) {
    title.value = value;
  }

  @override
  Future<void> onInit() async {
    await addNewsToFirestore();
    await getAllNews();
    await getTodayNews();
    await getTrendingNews();
    scrollController.value.addListener(() {
      if (scrollController.value.position.pixels ==
          scrollController.value.position.maxScrollExtent) {
        getMoreData();
      }
    });
    super.onInit();
  }

  Future<void> addNewsToFirestore() async {
    String newsAddedTodayFlag =
        await _prefs.getNewsAddedTodayFlag(kNewsAddedTodayFlag, '');
    DateTime now = DateTime.now();
    String todayMillis = DateTime.now()
        .subtract(Duration(
          hours: now.hour,
          minutes: now.minute,
          seconds: now.second,
          milliseconds: now.millisecond,
          microseconds: now.microsecond,
        ))
        .millisecondsSinceEpoch
        .toString();
    if (newsAddedTodayFlag == null || todayMillis != newsAddedTodayFlag) {
      await _prefs.setNewsAddedTodayFlag(kNewsAddedTodayFlag, todayMillis);
      final _countries = ["gb", "us", "ie", "ca", "nz", "ph", "za"];
      _countries.forEach((element) async {
        await _getNewsRequest.getNews(element).then((value) => {
              value.forEach((news) async {
                await _firestoreService.addNewsToFirestore(news: news);
              }),
            });
      });
    }
  }

  Future<void> getAllNews() async {
    await _firestoreService.getAllNews().then((value) => {
          value.docs.forEach((element) {
            print(element.data());
            documentSnapshot = element;
            News news = News(
              author: element.data()['author'],
              content: element.data()['content'],
              description: element.data()['description'],
              sourceName: element.data()['name'],
              title: element.data()['title'],
              publishedAt: element.data()['publishedAt'],
              url: element.data()['url'],
              urlToImage: element.data()['urlToImage'],
            );
            newsList.add(news);
          }),
        });
    print(newsList.length);
  }

  Future<void> getMoreData() async {
    print("In get more data");
    await _firestoreService.getMoreNews(documentSnapshot).then((value) => {
          value.docs.forEach((element) {
            this.documentSnapshot = element;
            News news = News(
              author: element.data()['author'],
              content: element.data()['content'],
              description: element.data()['description'],
              sourceName: element.data()['name'],
              title: element.data()['title'],
              publishedAt: element.data()['publishedAt'],
              url: element.data()['url'],
              urlToImage: element.data()['urlToImage'],
            );
            newsList.add(news);
          }),
        });
  }

  Future<void> getTodayNews() async {
    await _firestoreService.getTodayNews().then((value) => {
          value.docs.forEach((element) {
            News news = News(
              author: element.data()['author'],
              content: element.data()['content'],
              description: element.data()['description'],
              sourceName: element.data()['name'],
              title: element.data()['title'],
              publishedAt: element.data()['publishedAt'],
              url: element.data()['url'],
              urlToImage: element.data()['urlToImage'],
            );
            todayNewsList.add(news);
          }),
        });
  }

  Future<void> getTrendingNews() async {
    await _firestoreService.getTodayNews().then((value) => {
          value.docs.forEach((element) {
            News news = News(
              author: element.data()['author'],
              content: element.data()['content'],
              description: element.data()['description'],
              sourceName: element.data()['name'],
              title: element.data()['title'],
              publishedAt: element.data()['publishedAt'],
              url: element.data()['url'],
              urlToImage: element.data()['urlToImage'],
            );
            trendingNewsList.add(news);
          }),
        });
  }

  Future<void> getNewsByTitle(String title) async {
    todayNewsList.clear();
    await _firestoreService.getNewsByTitle(title: title).then((value) => {
          value.docs.forEach((element) {
            News news = News(
              author: element.data()['author'],
              content: element.data()['content'],
              description: element.data()['description'],
              sourceName: element.data()['name'],
              title: element.data()['title'],
              publishedAt: element.data()['publishedAt'],
              url: element.data()['url'],
              urlToImage: element.data()['urlToImage'],
            );
            todayNewsList.add(news);
          }),
        });
  }
}
