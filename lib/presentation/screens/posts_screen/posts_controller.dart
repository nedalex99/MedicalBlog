import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medical_blog/model/post.dart';
import 'package:medical_blog/utils/network/firestore_service.dart';
import 'package:medical_blog/utils/util_functions.dart';

class PostsController extends GetxController {
  FirestoreService _firestoreService = Get.find();
  Rx<ScrollController> scrollController = ScrollController().obs;
  DocumentSnapshot documentSnapshot;
  RxList<Post> postsFromFirestore = List<Post>().obs;

  @override
  Future<void> onInit() async {
    await getPosts();
    scrollController.value.addListener(() {
      if (scrollController.value.position.pixels ==
          scrollController.value.position.maxScrollExtent) {
        getMorePosts();
      }
    });
    super.onInit();
  }

  Future<void> getPosts() async {
    String url;
    await _firestoreService.getPosts().then((value) => {
          value.docs.forEach((element) async {
            documentSnapshot = element;
            Post post = Post.fromJson(documentSnapshot);
            url = await getPhoto(id: post.userData.id);
            post.image = url;

            postsFromFirestore.add(post);
          }),
        });
  }

  Future<void> getMorePosts() async {
    print("In get more posts");
    await _firestoreService.getMorePosts(documentSnapshot).then((value) => {
          value.docs.forEach((element) {
            this.documentSnapshot = element;
            Post post = Post.fromJson(documentSnapshot);
            postsFromFirestore.add(post);
          }),
        });
  }
}
