import 'package:get/get.dart';
import 'package:medical_blog/utils/network/firestore_service.dart';

class PostsController extends GetxController {
  FirestoreService _firestoreService = Get.find();



  Future<void> getPosts() async {
    await _firestoreService.getPosts().then((value) => {
          value.docs.forEach((element) {
            print(element.data());
          }),
        });
  }
}
