import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_field_date_picker/input_field_date_picker.dart';
import 'package:medical_blog/utils/constants/styles.dart';
import 'package:medical_blog/utils/util_functions.dart';
import 'package:intl/intl.dart';

class InputFieldDatePickerController extends GetxController {
  Rx<TextStyle> hintTextStyle = kNoFocusNoErrorHintTextStyle.obs;
  Rx<TextEditingController> textController = TextEditingController().obs;
  RxString errorText = ''.obs..value = null;
  DateTime dateTime = DateFormat("yyyy-MM-dd").parse(DateTime.now().toString());
  final CheckCallback inputTextChecked;

  InputFieldDatePickerController({
    this.inputTextChecked,
  });

  void getDate(BuildContext context) {
    showSheet(
      context: context,
      child: buildDatePicker(),
      onClicked: saveDate,
    );
  }

  void saveDate() {
    String date = dateTime.toString();
    var formattedDate = DateFormat("yyyy-MM-dd").format(dateTime);
    textController.value.text = formattedDate.toString();
    inputTextChecked(textController.value.text);
    Get.back();
  }

  Widget buildDatePicker() => SizedBox(
        height: 180.0,
        child: CupertinoDatePicker(
          initialDateTime: DateTime.now(),
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (dateTime) {
            this.dateTime = dateTime;
          },
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
