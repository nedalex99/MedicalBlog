import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_blog/utils/constants/styles.dart';

class InputTextFieldController extends GetxController {
  RxBool isHidden = true.obs;
  Rx<TextStyle> hintTextStyle = kNoFocusNoErrorHintTextStyle.obs;
  Rx<TextEditingController> textController = TextEditingController().obs;

  void handleOnFocus(bool focused) {
    switch (focused) {
      case true:
        hintTextStyle.value = kFocusedNoErrorHintTextStyle;
        return;
      case false:
        hintTextStyle.value = kNoFocusNoErrorHintTextStyle;
        return;
      default:
        return;
    }
  }
}
