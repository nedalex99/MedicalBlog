import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:medical_blog/model/filter.dart';
import 'package:medical_blog/model/news.dart';
import 'package:medical_blog/model/post.dart';
import 'package:medical_blog/model/user_data.dart';
import 'package:medical_blog/presentation/widgets/dialogs/loading_dialog.dart';
import 'package:medical_blog/presentation/widgets/modals/filters_modal/filters_modal.dart';
import 'package:medical_blog/utils/network/firestore_service.dart';
import 'package:medical_blog/utils/util_functions.dart';

class SavedScreenController extends GetxController {
  FirestoreService _firestoreService = Get.find();
  RxList<Post> posts = List<Post>().obs;
  RxList<News> newsList = List<News>().obs;
  RxInt toggleIndex = 0.obs;
  RxString dropdownValue = "Newest first".obs;
  DocumentSnapshot documentSnapshot;
  Rx<ScrollController> scrollController = ScrollController().obs;
  RxBool isVisible = true.obs;

  @override
  Future<void> onInit() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getPosts();
    });
    scrollController.value.addListener(() {
      if (scrollController.value.position.pixels ==
          scrollController.value.position.maxScrollExtent) {
        getMorePosts();
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

  void onToggle(int index) {
    toggleIndex.value = index;
    if (index == 0) {
      getPosts();
    } else {
      getNews();
    }
  }

  Future<void> getPosts() async {
    String url;
    Get.dialog(LoadingDialog());
    await _firestoreService.getPostsFromSavedCollection().then((value) => {
          value.docs.forEach((element) async {
            documentSnapshot = element;
            Post post = Post.fromJson(element);
            posts.add(post);
          }),
          Get.back(),
        });
  }

  Future<void> getMorePosts() async {
    print("In get more posts");
    await _firestoreService
        .getMorePostsFromSavedCollection(documentSnapshot)
        .then((value) => {
              value.docs.forEach((element) {
                this.documentSnapshot = element;
                Post post = Post.fromJson(documentSnapshot);
                posts.add(post);
              }),
            });
  }

  Future<void> getNews() async {
    newsList.clear();
    Get.dialog(LoadingDialog());
    await _firestoreService.getNewsFromSavedCollection().then((value) => {
          value.docs.forEach((element) {
            News news = News.fromJson(element);
            newsList.add(news);
          }),
          Get.back(),
        });
  }

  void showFilterModal() {
    showModalBottomSheet(
        context: Get.context,
        builder: (context) {
          return FiltersModal();
        });
  }

  @override
  void onClose() {
    print('on close controller');
    super.onClose();
  }

  @override
  void dispose() {
    print('on dispose controller');
    super.dispose();
  }

  void setNewDropdownValue({String value}) {
    if (dropdownValue.value != value) {
      switch (value) {
        case 'Oldest first':
          posts.sort(
              (a, b) => a.timestamp.seconds.compareTo(b.timestamp.seconds));
          break;
        case 'Newest first':
          posts.sort(
              (a, b) => b.timestamp.seconds.compareTo(a.timestamp.seconds));
          break;
        case 'Most likes first':
          posts.sort((a, b) => b.noOfLikes.compareTo(a.noOfLikes));
          break;
        case 'Most dislikes first':
          posts.sort((a, b) => b.noOfDislikes.compareTo(a.noOfDislikes));
          break;
      }
    }
    dropdownValue.value = value;
  }

  void removePostFromSaved(int index) {
    posts.removeAt(index);
  }

  void removeWithPostId(String postId) {
    posts.removeWhere((element) => element.uid == postId);
  }

  void removeNewsById(String newsId) {
    newsList.removeWhere((element) => element.id == newsId);
  }

  Future<void> getPostsWithFilters(Filter filter) async {
    await _firestoreService
        .getSavedPostsWithFilters(filter: filter)
        .then((value) => {
              posts.clear(),
              value.docs.forEach((element) {
                UserData userData = UserData(
                  firstName: (element.data() as Map)['userData']['firstName'],
                  lastName: (element.data() as Map)['userData']['lastName'],
                );
                Post post = Post(
                  uid: element.id,
                  title: (element.data() as Map)['title'],
                  description: (element.data() as Map)['description'],
                  noOfLikes: (element.data() as Map)['noOfLikes'],
                  noOfDislikes: (element.data() as Map)['noOfDislikes'],
                  noOfComments: (element.data() as Map)['noOfComments'],
                  tags: ((element.data() as Map)['tags'] as List)
                      .map((e) => e.toString())
                      .toList(),
                  timestamp: (element.data() as Map)['timeStamp'] as int,
                  likedBy: ((element.data() as Map)['likedBy'] as List)
                      .map((e) => e.toString())
                      .toList(),
                  dislikedBy: ((element.data() as Map)['dislikedBy'] as List)
                      .map((e) => e.toString())
                      .toList(),
                  savedBy: ((element.data() as Map)['savedBy'] as List)
                      .map((e) => e.toString())
                      .toList(),
                  userData: userData,
                );
                posts.add(post);
              }),
            });
    Get.back();
  }
}
