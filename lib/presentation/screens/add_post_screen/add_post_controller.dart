import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_blog/presentation/widgets/dialogs/loading_dialog.dart';
import 'package:medical_blog/presentation/widgets/tag_widget/tag_widget.dart';
import 'package:medical_blog/utils/constants/colors.dart';
import 'package:medical_blog/utils/network/firestore_service.dart';
import 'package:medical_blog/utils/util_functions.dart';

class AddPostController extends GetxController {
  String title = "";
  String description = "";

  int _selectedIndex = 0;

  RxInt addTextColor = kInactiveAddPostTextHex.obs;
  RxList<TagWidget> tagWidgetList = List<TagWidget>().obs;
  List<String> tagList = [];

  List<Widget> _cupertinoTagWidgetList = [
    Text(
      'Neorology',
      style: TextStyle(
        fontSize: 26.0,
      ),
    ),
    Text(
      'College',
      style: TextStyle(
        fontSize: 26.0,
      ),
    ),
    Text(
      'Pediatry',
      style: TextStyle(
        fontSize: 26.0,
      ),
    ),
    Text(
      'Cardiology',
      style: TextStyle(
        fontSize: 26.0,
      ),
    ),
  ];
  List<String> cupertinoTagList = [
    'Neorology',
    'College',
    'Pediatry',
    'Cardiology',
  ];

  FirestoreService _firestoreService = Get.find();

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
    Get.dialog(LoadingDialog());
    await _firestoreService
        .addPost(title: title, description: description, tags: tagList)
        .then((value) => {
              Get.back(),
              Get.back(),
            });
  }

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
