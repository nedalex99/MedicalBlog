import 'package:get/get.dart';
import 'package:medical_blog/logic/model/post.dart';
import 'package:medical_blog/utils/network/auth_service.dart';
import 'package:medical_blog/utils/network/firestore_service.dart';

class PostsController extends GetxController {
  FirestoreService _firestoreService = Get.find();
  AuthService _authService = Get.find();
  RxList<Post> postsFromFirestore = List<Post>().obs;

  Future<void> getPosts() async {
    await _firestoreService.getPosts().then((value) => {
          value.docs.forEach((element) {
            print(element.data());
            postsFromFirestore.add(Post(
              title: element.data()['title'],
              description: element.data()['description'],
              noOfLikes: element.data()['noOfLikes'],
              noOfDislikes: element.data()['noOfDislikes'],
              noOfComments: element.data()['noOfComments'],
              tags: (element.data()['tags'] as List)
                  .map((e) => e.toString())
                  .toList(),
            ));
          }),
        });
  }

  Future<void> getUserFirstAndLastName() async {
    _firestoreService.getUserFirstAndLastName().then((value) => {
          value.data().forEach((key, value) {
            print(key + " " + value);
          }),
        });
  }
}
