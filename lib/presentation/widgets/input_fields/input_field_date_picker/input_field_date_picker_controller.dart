import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medical_blog/utils/constants/styles.dart';
import 'package:medical_blog/utils/util_functions.dart';

class InputFieldDatePickerController extends GetxController {
  Rx<TextStyle> hintTextStyle = kNoFocusNoErrorHintTextStyle.obs;
  Rx<TextEditingController> textController = TextEditingController().obs;
  RxString errorText = ''.obs..value = null;

  void getDate(BuildContext context) {
    showSheet(
      context: context,
      child: buildDatePicker(),
      onClicked: () => Get.back(),
    );
  }

  Widget buildDatePicker() => SizedBox(
        height: 180.0,
        child: CupertinoDatePicker(
          initialDateTime: DateTime.now(),
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (dateTime) {},
        ),
      );

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
