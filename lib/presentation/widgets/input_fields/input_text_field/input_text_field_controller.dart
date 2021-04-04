import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_blog/utils/constants/styles.dart';

class InputTextFieldController extends GetxController {
  RxBool isHidden = true.obs;
  Rx<TextStyle> hintTextStyle = kNoFocusNoErrorHintTextStyle.obs;
  Rx<TextEditingController> textController = TextEditingController().obs;
  RxString errorText = ''.obs..value = null;

  void handleOnFocus(bool focused) {
    if (focused && errorText.value.isNullOrBlank) {
      hintTextStyle.value = kFocusedNoErrorHintTextStyle;
    } else if (!focused && !errorText.value.isNullOrBlank) {
      hintTextStyle.value = kNoFocusWithErrorTextStyle;
    } else if (focused && !errorText.value.isNullOrBlank) {
      hintTextStyle.value = kFocusedWithErrorTextStyle;
    } else {
      hintTextStyle.value = kNoFocusNoErrorHintTextStyle;
    }
  }
}
