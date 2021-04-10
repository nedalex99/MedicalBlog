import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:medical_blog/logic/model/post.dart';
import 'package:medical_blog/logic/model/user_data.dart';
import 'package:medical_blog/utils/network/auth_service.dart';
import 'package:medical_blog/utils/network/firestore_service.dart';

class PostsController extends GetxController {
  FirestoreService _firestoreService = Get.find();

  RxList<Post> postsFromFirestore = List<Post>().obs;

  Future<void> getPosts() async {
    await _firestoreService.getPosts().then((value) => {
          value.docs.forEach((element) {
            print(element.data());
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
              timestamp: element.data()['timeStamp'] as Timestamp,
              userData: userData,
            );
            postsFromFirestore.add(post);
          }),
        });
    postsFromFirestore
        .sort((a, b) => b.timestamp.seconds.compareTo(a.timestamp.seconds));
  }
}
