import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:medical_blog/logic/model/post.dart';
import 'package:medical_blog/utils/network/firestore_service.dart';

class SavedScreenController extends GetxController {
  FirestoreService _firestoreService = Get.find();
  RxList<Post> posts = List<Post>().obs;

  @override
  Future<void> onInit() async {
    Stream<QuerySnapshot> ref = _firestoreService.getFromSavedCollection();
    ref.forEach((element) {
      posts.clear();
      element.docs.asMap().forEach((index, value) {
        var x = value.data();
        Post post = Post.fromJson(x);
        posts.add(post);
        print(posts.length);
      });
    });
    
    super.onInit();
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
