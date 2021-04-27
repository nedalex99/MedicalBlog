import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_text_field/input_text_field.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_text_field/input_text_field_controller.dart';
import 'package:medical_blog/presentation/widgets/modals/filters_modal/filters_modal_controller.dart';

class FiltersModal extends StatelessWidget {
  final FiltersModalController _filtersModalController =
      Get.put(FiltersModalController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InputTextField(
            typeOfText: TextInputType.text,
            hint: 'Start Date',
            controller: Get.put(InputTextFieldController(), tag: 'Start Date'),
            inputTextChecked: _filtersModalController.startDateCallback,
          ),
          SizedBox(
            height: 16.0,
          ),
          InputTextField(
            typeOfText: TextInputType.text,
            hint: 'End Date',
            controller: Get.put(InputTextFieldController(), tag: 'End Date'),
            inputTextChecked: _filtersModalController.startDateCallback,
          ),
          SizedBox(
            height: 16.0,
          ),
          InputTextField(
            typeOfText: TextInputType.text,
            hint: 'Category',
            controller: Get.put(InputTextFieldController(), tag: 'Category'),
            inputTextChecked: _filtersModalController.startDateCallback,
          ),
        ],
      ),
    );
  }
}
