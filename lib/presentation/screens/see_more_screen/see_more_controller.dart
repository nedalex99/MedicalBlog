import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_blog/model/news.dart';
import 'package:medical_blog/utils/network/firestore_service.dart';

class SeeMoreController extends GetxController {
  final String title;

  SeeMoreController({
    this.title,
  });

  Rx<ScrollController> scrollController = ScrollController().obs;
  final FirestoreService _firestoreService = Get.find();
  DocumentSnapshot documentSnapshot;

  RxList<News> newsList = List<News>().obs;

  @override
  void onInit() {
    if (title == 'today') {
      getTodayNews();
    } else {
      getTrendingNews();
    }
    scrollController.value.addListener(() {
      if (scrollController.value.position.pixels ==
          scrollController.value.position.maxScrollExtent) {
        if (title == 'today') {
          getTodayNews();
        } else {
          getTrendingNews();
        }
      }
    });
    super.onInit();
  }

  Future<void> getTodayNews() async {
    await _firestoreService.getAllTodayNews(documentSnapshot).then((value) => {
          value.docs.forEach((element) {
            documentSnapshot = element;
            News news = News.fromJson(element);
            newsList.add(news);
          }),
        });
  }

  Future<void> getTrendingNews() async {
    await _firestoreService.getTrendingNews(documentSnapshot).then((value) => {
          value.docs.forEach((element) {
            documentSnapshot = element;
            News news = News.fromJson(element);
            newsList.add(news);
          }),
        });
  }
}
