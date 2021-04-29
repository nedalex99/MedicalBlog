import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medical_blog/logic/model/post.dart';
import 'package:medical_blog/logic/model/user_data.dart';
import 'package:medical_blog/utils/network/firestore_service.dart';

class PostsController extends GetxController {
  FirestoreService _firestoreService = Get.find();
  Rx<ScrollController> scrollController = ScrollController().obs;
  RxList<Post> postsFromFirestore = List<Post>().obs;
  DocumentSnapshot documentSnapshot;

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
    await _firestoreService.getPosts().then((value) => {
          value.docs.forEach((element) {
            print(element.data());
            documentSnapshot = element;
            UserData userData = UserData(
              firstName: element.data()['userData']['firstName'],
              lastName: element.data()['userData']['lastName'],
            );
            Post post = Post(
              uid: element.id,
              title: element.data()['title'],
              description: element.data()['description'],
              noOfLikes: element.data()['noOfLikes'],
              noOfDislikes: element.data()['noOfDislikes'],
              noOfComments: element.data()['noOfComments'],
              tags: (element.data()['tags'] as List)
                  .map((e) => e.toString())
                  .toList(),
              timestamp: element.data()['timeStamp'] as int,
              likedBy: (element.data()['likedBy'] as List)
                  .map((e) => e.toString())
                  .toList(),
              dislikedBy: (element.data()['dislikedBy'] as List)
                  .map((e) => e.toString())
                  .toList(),
              savedBy: (element.data()['savedBy'] as List)
                  .map((e) => e.toString())
                  .toList(),
              userData: userData,
            );
            postsFromFirestore.add(post);
          }),
        });
    postsFromFirestore
        .sort((a, b) => b.timestamp.seconds.compareTo(a.timestamp.seconds));
  }

  Future<void> getMorePosts() async {
    print("In get more posts");
    await _firestoreService.getMorePosts(documentSnapshot).then((value) => {
          value.docs.forEach((element) {
            print(element.data());
            this.documentSnapshot = element;
            UserData userData = UserData(
              firstName: element.data()['userData']['firstName'],
              lastName: element.data()['userData']['lastName'],
            );
            Post post = Post(
              uid: element.id,
              title: element.data()['title'],
              description: element.data()['description'],
              noOfLikes: element.data()['noOfLikes'],
              noOfDislikes: element.data()['noOfDislikes'],
              noOfComments: element.data()['noOfComments'],
              tags: (element.data()['tags'] as List)
                  .map((e) => e.toString())
                  .toList(),
              timestamp: element.data()['timeStamp'] as int,
              likedBy: (element.data()['likedBy'] as List)
                  .map((e) => e.toString())
                  .toList(),
              dislikedBy: (element.data()['dislikedBy'] as List)
                  .map((e) => e.toString())
                  .toList(),
              savedBy: (element.data()['savedBy'] as List)
                  .map((e) => e.toString())
                  .toList(),
              userData: userData,
            );
            postsFromFirestore.add(post);
          }),
        });
    postsFromFirestore
        .sort((a, b) => b.timestamp.seconds.compareTo(a.timestamp.seconds));
  }
}
