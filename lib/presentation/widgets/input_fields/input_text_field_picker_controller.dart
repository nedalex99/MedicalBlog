import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_field_date_picker/input_field_date_picker.dart';
import 'package:medical_blog/utils/util_functions.dart';

class InputTextFieldPickerController extends GetxController {
  Rx<TextEditingController> textController = TextEditingController().obs;
  final CheckCallback inputTextChecked;

  InputTextFieldPickerController({
    this.inputTextChecked,
  });

  int _selectedIndex = 0;
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

  void showCategoryPicker() {
    showSheet(
      context: Get.context,
      child: buildPicker(),
      onClicked: addCategory,
    );
  }

  void addCategory() {
    tagList.add(cupertinoTagList[_selectedIndex]);
    textController.value.text = cupertinoTagList[_selectedIndex];
    inputTextChecked(textController.value.text);
    Get.back();
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
