import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_blog/utils/constants/styles.dart';

class InputTextFieldSearchController extends GetxController {
  Rx<TextEditingController> textController = TextEditingController().obs;
  Rx<TextStyle> hintTextStyle = kNoFocusNoErrorHintTextStyle.obs;

  void getNewsByTitle() {

  }
}
