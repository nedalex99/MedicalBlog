import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:medical_blog/model/post.dart';
import 'package:medical_blog/model/report.dart';
import 'package:medical_blog/presentation/widgets/dialogs/modal_info_error_dialog.dart';
import 'package:medical_blog/utils/constants/values.dart';
import 'package:medical_blog/utils/network/firestore_service.dart';
import 'package:medical_blog/utils/session_temp.dart';
import 'package:medical_blog/utils/util_functions.dart';

class PostsController extends GetxController {
  FirestoreService _firestoreService = Get.find();
  Rx<ScrollController> scrollController = ScrollController().obs;
  DocumentSnapshot documentSnapshot;
  RxList<Post> postsFromFirestore = List<Post>().obs;
  RxBool isVisible = true.obs;
  RxBool isLoading = false.obs;
  RxString dropdownValue = "Newest first".obs;

  @override
  Future<void> onInit() async {
    await getPosts();
    scrollController.value.addListener(() {
      if (scrollController.value.position.pixels ==
          scrollController.value.position.maxScrollExtent) {
        dropdownValue.value == "Newest first"
            ? getMorePosts()
            : getMoreRecommendationPosts();
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

  Future<void> getPosts() async {
    isLoading.value = true;
    documentSnapshot = null;
    await _firestoreService.getPosts().then((value) => {
          value.docs.forEach((element) async {
            documentSnapshot = element;
            Post post = Post.fromJson(documentSnapshot);
            if (!post.flagToDelete) {
              postsFromFirestore.add(post);
            }
            List<Report> reportList = [];
            await _firestoreService
                .getReports(postId: element.id)
                .then((value) => {
                      value.docs.forEach((element) {
                        Report report = Report.fromJson(element);
                        if (report.userId == userUID) {
                          post.alreadyReported = true;
                        }
                        reportList.add(report);
                      }),
                    });
            post.reportList = reportList;

            if (post.flagToDelete) {
              await _firestoreService.deletePost(postId: post.uid);
              Get.dialog(
                  ModalErrorDialog(errorText: 'Your post has been removed!'));
            } else {
              var map = Map();
              reportList.forEach((element) {
                if (!map.containsKey(element.reportReason)) {
                  map[element.reportReason] = 1;
                } else {
                  map[element.reportReason] += 1;
                }
              });

              if (map.values.contains(3) || post.points <= 0) {
                if (post.userData.id == userUID) {
                  await _firestoreService.deletePost(postId: post.uid);
                  postsFromFirestore
                      .removeWhere((element) => element.uid == post.uid);
                  Get.dialog(ModalErrorDialog(
                      errorText: 'Your post has been removed!'));
                } else {
                  await _firestoreService.setPostReported(postId: post.uid);
                  postsFromFirestore
                      .removeWhere((element) => element.uid == post.uid);
                }
              } else {}
            }
          }),
          isLoading.value = false,
        });
  }

  Future<void> getMorePosts({
    String typeOfPost,
  }) async {
    isLoading.value = true;
    await _firestoreService.getMorePosts(documentSnapshot).then((value) => {
          value.docs.forEach((element) async {
            this.documentSnapshot = element;
            Post post = Post.fromJson(documentSnapshot);
            if (!post.flagToDelete) {
              postsFromFirestore.add(post);
            }

            List<Report> reportList = [];
            await _firestoreService
                .getReports(postId: element.id)
                .then((value) => {
                      value.docs.forEach((element) {
                        Report report = Report.fromJson(element);
                        if (report.userId == userUID) {
                          post.alreadyReported = true;
                        }
                        reportList.add(report);
                      }),
                    });
            post.reportList = reportList;

            if (post.flagToDelete) {
              await _firestoreService.deletePost(postId: post.uid);
              Get.dialog(
                  ModalErrorDialog(errorText: 'Your post has been removed!'));
            } else {
              var map = Map();
              reportList.forEach((element) {
                if (!map.containsKey(element.reportReason)) {
                  map[element.reportReason] = 1;
                } else {
                  map[element.reportReason] += 1;
                }
              });

              if (map.values.contains(3) || post.points <= 0) {
                if (post.userData.id == userUID) {
                  await _firestoreService.deletePost(postId: post.uid);
                  postsFromFirestore
                      .removeWhere((element) => element.uid == post.uid);
                  Get.dialog(ModalErrorDialog(
                      errorText: 'Your post has been removed!'));
                } else {
                  await _firestoreService.setPostReported(postId: post.uid);
                }
              } else {}
            }
          }),
          isLoading = false.obs,
        });
  }

  void getToTop() {
    scrollController.value.animateTo(
      0.0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  Future<void> setNewDropdownValue({String value}) async {
    if (dropdownValue.value != value) {
      switch (value) {
        case 'Recommendation':
          getRecommendationsPost();
          break;
        case 'Newest first':
          getLatestPosts();
          break;
      }
    }
    dropdownValue.value = value;
  }

  Future<void> getRecommendationsPost() async {
    String url;
    postsFromFirestore.value.clear();
    documentSnapshot = null;
    await _firestoreService.getRecommendationPosts().then((value) => {
          value.docs.forEach((element) async {
            documentSnapshot = element;
            Post post = Post.fromJson(documentSnapshot);
            if (!post.flagToDelete) {
              postsFromFirestore.add(post);
            }

            List<Report> reportList = [];
            await _firestoreService
                .getReports(postId: element.id)
                .then((value) => {
                      value.docs.forEach((element) {
                        Report report = Report.fromJson(element);
                        if (report.userId == userUID) {
                          post.alreadyReported = true;
                        }
                        reportList.add(report);
                      }),
                    });
            post.reportList = reportList;

            if (post.flagToDelete) {
              await _firestoreService.deletePost(postId: post.uid);
              Get.dialog(
                  ModalErrorDialog(errorText: 'Your post has been removed!'));
            } else {
              var map = Map();
              reportList.forEach((element) {
                if (!map.containsKey(element.reportReason)) {
                  map[element.reportReason] = 1;
                } else {
                  map[element.reportReason] += 1;
                }
              });

              if (map.values.contains(3) || post.points <= 0) {
                if (post.userData.id == userUID) {
                  await _firestoreService.deletePost(postId: post.uid);
                  postsFromFirestore
                      .removeWhere((element) => element.uid == post.uid);
                  Get.dialog(ModalErrorDialog(
                      errorText: 'Your post has been removed!'));
                } else {
                  await _firestoreService.setPostReported(postId: post.uid);
                }
              } else {}
            }
          }),
          isLoading.value = false,
        });
  }

  Future<void> getMoreRecommendationPosts() async {
    String url;
    await _firestoreService
        .getMoreRecommendationPosts(documentSnapshot)
        .then((value) => {
              value.docs.forEach((element) async {
                documentSnapshot = element;
                Post post = Post.fromJson(documentSnapshot);
                if (!post.flagToDelete) {
                  postsFromFirestore.add(post);
                }
                List<Report> reportList = [];
                await _firestoreService
                    .getReports(postId: element.id)
                    .then((value) => {
                          value.docs.forEach((element) {
                            Report report = Report.fromJson(element);
                            if (report.userId == userUID) {
                              post.alreadyReported = true;
                            }
                            reportList.add(report);
                          }),
                        });
                post.reportList = reportList;

                if (post.flagToDelete) {
                  await _firestoreService.deletePost(postId: post.uid);
                  Get.dialog(ModalErrorDialog(
                      errorText: 'Your post has been removed!'));
                } else {
                  var map = Map();
                  reportList.forEach((element) {
                    if (!map.containsKey(element.reportReason)) {
                      map[element.reportReason] = 1;
                    } else {
                      map[element.reportReason] += 1;
                    }
                  });

                  if (map.values.contains(3) || post.points <= 0) {
                    if (post.userData.id == userUID) {
                      await _firestoreService.deletePost(postId: post.uid);
                      postsFromFirestore
                          .removeWhere((element) => element.uid == post.uid);
                      Get.dialog(ModalErrorDialog(
                          errorText: 'Your post has been removed!'));
                    } else {
                      await _firestoreService.setPostReported(postId: post.uid);
                    }
                  } else {}
                }
              }),
              isLoading.value = false,
            });
  }

  Future<void> getLatestPosts() async {
    postsFromFirestore.clear();
    getPosts();
  }
}
