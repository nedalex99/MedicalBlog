import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:medical_blog/model/post.dart';
import 'package:medical_blog/model/user_data.dart';
import 'package:medical_blog/presentation/screens/edit_account_screen/edit_account_screen.dart';
import 'package:medical_blog/presentation/widgets/dialogs/loading_dialog.dart';
import 'package:medical_blog/utils/constants/routes.dart';
import 'package:medical_blog/utils/network/auth_service.dart';
import 'package:medical_blog/utils/network/firestore_service.dart';
import 'package:medical_blog/utils/session_temp.dart';

class ProfileScreenController extends GetxController {
  FirestoreService _firestoreService = Get.find();
  AuthService _authService = Get.find();

  RxList<Post> posts = List<Post>().obs;
  Rx<UserData> userData = UserData(
    firstName: "",
    lastName: "",
  ).obs;

  DocumentSnapshot documentSnapshot;

  @override
  void onInit() {
    getPosts();
    getUserData();
    super.onInit();
  }

  Future<void> getPosts() async {
    await _firestoreService.getUserPosts().then((value) => {
          value.docs.forEach((element) {
            documentSnapshot = element;
            Post post = Post.fromJson(documentSnapshot);
            posts.add(post);
          }),
        });
  }

  Future<void> getUserData() async {
    await _firestoreService.getUserData().then((value) => {
          userData.value = UserData.fromJson(value),
        });
  }

  Future<void> signOutUser() async {
    Get.dialog(LoadingDialog());
    await _authService.logoutUser().then((value) => {
          userUID = '',
          Get.back(),
          Get.offAllNamed(kLoginRoute),
        });
  }

  void redirectToEditAccount() {
    Get.to(() => EditAccountScreen());
  }
}
