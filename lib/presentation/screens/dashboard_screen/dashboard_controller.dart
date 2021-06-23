import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:medical_blog/model/news.dart';
import 'package:medical_blog/utils/network/firestore_service.dart';
import 'package:medical_blog/utils/network/get_news_request.dart';
import 'package:medical_blog/utils/user_preferences.dart';

class DashboardController extends GetxController {
  FirestoreService _firestoreService = Get.find();
  RxList<News> newsList = List<News>().obs;
  RxList<News> todayNewsList = List<News>().obs;
  RxList<News> trendingNewsList = List<News>().obs;
  RxList<News> searchedNews = List<News>().obs;
  Rx<ScrollController> scrollController = ScrollController().obs;
  DocumentSnapshot documentSnapshot;
  RxString title = "".obs;
  RxBool isVisible = true.obs;

  GetNewsRequest _getNewsRequest = Get.find();

  void titleCallback(String value) {
    title.value = value;
  }

  @override
  Future<void> onInit() async {
    await addNewsToFirestore();
    scrollController.value.addListener(() {
      if (scrollController.value.position.pixels ==
          scrollController.value.position.maxScrollExtent) {
        getMoreData();
      }
      if (scrollController.value.position.userScrollDirection ==
          ScrollDirection.reverse) {
        isVisible.value = false;
      } else {
        isVisible.value = true;
      }
    });
    super.onInit();
  }

  Future<void> addNewsToFirestore() async {
    String newsAddedTodayFlag;
    await _firestoreService.getDayRequest().then((value) => {
          newsAddedTodayFlag = (value.data() as Map)['todayNewsFlag'],
        });
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
      await _firestoreService.setDayRequest(todayMillis);
      final _countries = ["gb", "us", "ie", "ca", "nz", "ph", "za"];
      _countries.forEach((element) async {
        await _getNewsRequest.getNews(element).then((value) async => {
              value.forEach((news) async {
                await _firestoreService
                    .addNewsToFirestore(news: news)
                    .then((value) => {
                          news.id = value,
                        });
              }),
              await getNews(),
            });
      });
    } else {
      await getNews();
    }
  }

  Future<void> getNews() async {
    await getTodayNews();
    await getTrendingNews();
    await getMoreData();
  }

  Future<void> getAllNews() async {
    newsList.clear();
    await _firestoreService.getAllNews().then((value) => {
          value.docs.forEach((element) {
            documentSnapshot = element;
            News news = News.fromJson(element);
            newsList.add(news);
          }),
        });
  }

  Future<void> getMoreData() async {
    await _firestoreService.getMoreNews(documentSnapshot).then((value) => {
          value.docs.forEach((element) {
            this.documentSnapshot = element;
            News news = News.fromJson(element);
            newsList.add(news);
          }),
        });
  }

  Future<void> getTodayNews() async {
    todayNewsList.clear();
    await _firestoreService.getTodayNews().then((value) => {
          value.docs.forEach((element) {
            this.documentSnapshot = element;
            News news = News.fromJson(element);
            todayNewsList.add(news);
          }),
        });
  }

  Future<void> getTrendingNews() async {
    trendingNewsList.clear();
    await _firestoreService.getTrendingNews(documentSnapshot).then((value) => {
          value.docs.forEach((element) {
            this.documentSnapshot = element;
            News news = News.fromJson(element);
            trendingNewsList.add(news);
          }),
        });
  }

  Future<void> getNewsByTitle(String title) async {
    searchedNews.clear();
    await _firestoreService.getNewsByTitle(title: title).then((value) => {
          value.docs.forEach((element) {
            News news = News.fromJson(element);
            searchedNews.add(news);
          }),
        });
  }

  void getToTop() {
    scrollController.value.animateTo(
      0.0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }
}
