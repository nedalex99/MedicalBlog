import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medical_blog/logic/model/news.dart';
import 'package:medical_blog/utils/network/firestore_service.dart';

class DashboardController extends GetxController {
  FirestoreService _firestoreService = Get.find();
  RxList<News> newsList = List<News>().obs;
  Rx<ScrollController> scrollController = ScrollController().obs;
  DocumentSnapshot documentSnapshot;

  @override
  Future<void> onInit() async {
    await getAllNews();
    scrollController.value.addListener(() {
      if (scrollController.value.position.pixels ==
          scrollController.value.position.maxScrollExtent) {
        getMoreData();
      }
    });
    super.onInit();
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
              name: element.data()['name'],
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
              name: element.data()['name'],
              title: element.data()['title'],
              publishedAt: element.data()['publishedAt'],
              url: element.data()['url'],
              urlToImage: element.data()['urlToImage'],
            );
            newsList.add(news);
          }),
        });
  }
}
