import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:medical_blog/logic/model/post.dart';
import 'package:medical_blog/logic/model/user_data.dart';
import 'package:medical_blog/utils/network/firestore_service.dart';

class SavedScreenController extends GetxController {
  FirestoreService _firestoreService = Get.find();
  RxList<Post> posts = List<Post>().obs;

  @override
  Future<void> onInit() async {
    getPosts();
    super.onInit();
  }

  Future<void> getPosts() async {
    await _firestoreService.getFromSavedCollection().then((value) => {
          value.docs.forEach((element) {
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
            posts.add(post);
          }),
        });
    posts.sort((a, b) => b.timestamp.seconds.compareTo(a.timestamp.seconds));
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
}
