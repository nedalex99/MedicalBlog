import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_blog/model/post.dart';
import 'package:medical_blog/model/user_data.dart';
import 'package:medical_blog/presentation/screens/posts_screen/posts_controller.dart';
import 'package:medical_blog/presentation/widgets/dialogs/loading_dialog.dart';
import 'package:medical_blog/presentation/widgets/dialogs/modal_info_error_dialog.dart';
import 'package:medical_blog/presentation/widgets/tag_widget/tag_widget.dart';
import 'package:medical_blog/utils/constants/colors.dart';
import 'package:medical_blog/utils/network/firestore_service.dart';
import 'package:medical_blog/utils/session_temp.dart';
import 'package:medical_blog/utils/util_functions.dart';
import 'package:profanity_filter/profanity_filter.dart';

class AddPostController extends GetxController {
  String title = "";
  String description = "";

  int _selectedIndex = 0;

  RxInt addTextColor = kInactiveAddPostTextHex.obs;
  RxList<TagWidget> tagWidgetList = List<TagWidget>().obs;
  List<String> tagList = [];

  Rx<UserData> userData = UserData(
    firstName: '',
    lastName: '',
    profession: '',
  ).obs;
  RxString url = "".obs;

  List<Widget> _cupertinoTagWidgetList = [
    Text(
      'Cardiology',
      style: TextStyle(
        fontSize: 26.0,
      ),
    ),
    Text(
      'Neurology',
      style: TextStyle(
        fontSize: 26.0,
      ),
    ),
    Text(
      'Pediatrics',
      style: TextStyle(
        fontSize: 26.0,
      ),
    ),
    Text(
      'Allergy and Immunology',
      style: TextStyle(
        fontSize: 26.0,
      ),
    ),
    Text(
      'Anesthesiology',
      style: TextStyle(
        fontSize: 26.0,
      ),
    ),
    Text(
      'Dermatology',
      style: TextStyle(
        fontSize: 26.0,
      ),
    ),
    Text(
      'Diagnostic radiology',
      style: TextStyle(
        fontSize: 26.0,
      ),
    ),
    Text(
      'Emergency medicine',
      style: TextStyle(
        fontSize: 26.0,
      ),
    ),
    Text(
      'Internal medicine',
      style: TextStyle(
        fontSize: 26.0,
      ),
    ),
    Text(
      'Medical genetics',
      style: TextStyle(
        fontSize: 26.0,
      ),
    ),
    Text(
      'Neurology',
      style: TextStyle(
        fontSize: 26.0,
      ),
    ),
    Text(
      'Nuclear medicine',
      style: TextStyle(
        fontSize: 26.0,
      ),
    ),
    Text(
      'Obstetrics and gynecology',
      style: TextStyle(
        fontSize: 26.0,
      ),
    ),
    Text(
      'Ophthalmology',
      style: TextStyle(
        fontSize: 26.0,
      ),
    ),
    Text(
      'Pathology',
      style: TextStyle(
        fontSize: 26.0,
      ),
    ),
    Text(
      'Preventive medicine',
      style: TextStyle(
        fontSize: 26.0,
      ),
    ),
    Text(
      'Psychiatry',
      style: TextStyle(
        fontSize: 26.0,
      ),
    ),
    Text(
      'Radiation oncology',
      style: TextStyle(
        fontSize: 26.0,
      ),
    ),
    Text(
      'Surgery',
      style: TextStyle(
        fontSize: 26.0,
      ),
    ),
    Text(
      'Urology',
      style: TextStyle(
        fontSize: 26.0,
      ),
    ),
  ];

  List<String> cupertinoTagList = [
    'Cardiology',
    'Neurology',
    'Pediatrics',
    'Allergy and Immunology',
    'Anesthesiology',
    'Dermatology',
    'Diagnostic radiology',
    'Emergency medicine',
    'Family medicine',
    'Internal medicine',
    'Medical genetics',
    'Neurology',
    'Nuclear medicine',
    'Obstetrics and gynecology',
    'Ophthalmology',
    'Pathology',
    'Preventive medicine',
    'Psychiatry',
    'Radiation oncology',
    'Surgery',
    'Urology',
  ];

  FirestoreService _firestoreService = Get.find();

  @override
  void onInit() {
    getUserData();
    super.onInit();
  }

  Future<void> getUserData() async {
    await _firestoreService.getUserData().then((value) async => {
          userData.value = UserData.fromJson(value),
          await getPhoto(id: userUID).then((value) => {
                if (value != null)
                  {
                    url.value = value,
                  }
              }),
        });
  }

  void titleCallback(String value) {
    title = value;
    setAddTextColor();
  }

  void descriptionCallback(String value) {
    description = value;
    setAddTextColor();
  }

  void setAddTextColor() {
    if (title != "" && description != "") {
      addTextColor.value = kActiveAddPostTextHex;
    } else {
      addTextColor.value = kInactiveAddPostTextHex;
    }
  }

  Future<void> addPost() async {
    if (ProfanityFilter().hasProfanity(description) ||
        ProfanityFilter().hasProfanity(title)) {
      Get.dialog(
        ModalErrorDialog(
          errorText: 'Your post contains profanity words!',
        ),
      );
    } else {
      Get.dialog(LoadingDialog());
      UserData userData;
      await _firestoreService.getUserFirstAndLastName().then((value) => {
            userData = UserData.fromJson(value),
          });
      Post post = Post(
        title: title,
        description: description,
        tags: tagList,
        timestamp: Timestamp.now().millisecondsSinceEpoch,
        userData: userData,
        reportList: [],
        image: url.value,
      );
      await _firestoreService
          .addPost(
            post: post,
          )
          .then((value) => {
                post.uid = value,
                Get.back(),
                Get.back(),
              });
      PostsController _postsController = Get.find();
      // if (url.value == "") {
      //   post.image = null;
      // } else {
      //   post.image = url.value;
      // }
      _postsController.postsFromFirestore.insert(
        0,
        post,
      );
    }
  }

  void verifyContent() {}

  void showTagPicker() {
    showSheet(
      context: Get.context,
      child: buildPicker(),
      onClicked: addTag,
    );
  }

  void addTag() {
    tagWidgetList.add(
      TagWidget(
        tagName: cupertinoTagList[_selectedIndex],
      ),
    );
    tagList.add(cupertinoTagList[_selectedIndex]);

    deleteFromCupertinoTagList(index: _selectedIndex);

    Get.back();
  }

  void deleteTag({String tagName}) {
    tagWidgetList.removeWhere((element) => element.tagName == tagName);
    tagList.removeWhere((element) => element == tagName);

    addToCupertinoTagList(tagName: tagName);
  }

  void deleteFromCupertinoTagList({int index}) {
    _cupertinoTagWidgetList.removeAt(index);
    cupertinoTagList.removeAt(index);
  }

  void addToCupertinoTagList({String tagName}) {
    _cupertinoTagWidgetList.insert(
      0,
      Text(
        tagName,
        style: TextStyle(
          fontSize: 26.0,
        ),
      ),
    );
    cupertinoTagList.insert(0, tagName);
  }

  Widget buildPicker() {
    return SizedBox(
      height: Get.height * 0.25,
      child: CupertinoPicker(
        onSelectedItemChanged: (int value) {
          _selectedIndex = value;
        },
        itemExtent: 50,
        children: _cupertinoTagWidgetList,
      ),
    );
  }
}
