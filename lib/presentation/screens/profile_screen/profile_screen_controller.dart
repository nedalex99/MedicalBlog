import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical_blog/model/post.dart';
import 'package:medical_blog/model/user_data.dart';
import 'package:medical_blog/presentation/screens/edit_account_screen/edit_account_screen.dart';
import 'package:medical_blog/presentation/widgets/dialogs/loading_dialog.dart';
import 'package:medical_blog/utils/constants/routes.dart';
import 'package:medical_blog/utils/constants/strings.dart';
import 'package:medical_blog/utils/network/auth_service.dart';
import 'package:medical_blog/utils/network/firestore_service.dart';
import 'package:medical_blog/utils/session_temp.dart';
import 'package:medical_blog/utils/user_preferences.dart';

class ProfileScreenController extends GetxController {
  FirestoreService _firestoreService = Get.find();
  AuthService _authService = Get.find();
  PreferencesUtils _preferencesUtils = Get.find();
  Rx<PickedFile> image = PickedFile("").obs;
  RxString img = "".obs;

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
    getPhoto();
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

  Future<void> getPhoto() async {
    await FirebaseStorage.instance
        .ref(userUID)
        .child("images/$userUID")
        .getDownloadURL()
        .then((value) => {
              img.value = value,
            });
  }

  Future<void> signOutUser() async {
    String keepMeAuthFlag;
    Get.dialog(LoadingDialog());
    await _authService.logoutUser().then((value) async => {
          keepMeAuthFlag =
              await _preferencesUtils.getKeepMeAuthFlag(kKeepMeAuthFlag, ""),
          if (keepMeAuthFlag == 'true')
            {
              await _preferencesUtils.setKeepMeAuthFlag(kKeepMeAuthFlag, false),
            },
          userUID = '',
          Get.back(),
          Get.offAllNamed(kLoginRoute),
        });
  }

  void showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.photo_library,
                    ),
                    title: Text(
                      'Photo Library',
                    ),
                    onTap: imageFromGallery,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.photo_camera,
                    ),
                    title: Text(
                      'Camera',
                    ),
                    onTap: imageFromCamera,
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> imageFromCamera() async {
    PickedFile img = await ImagePicker().getImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    image.value = img;
  }

  Future<void> imageFromGallery() async {
    PickedFile img = await ImagePicker().getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    image.value = img;
    var storage = FirebaseStorage.instance;
    storage.ref(userUID).child('images/$userUID').putFile(
          File(
            image.value.path,
          ),
        );
  }

  void redirectToEditAccount() {
    Get.to(() => EditAccountScreen());
  }
}
