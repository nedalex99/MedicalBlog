import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_blog/presentation/widgets/buttons/custom_button.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_field_date_picker/input_field_date_picker.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_field_date_picker/input_field_date_picker_controller.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_text_field/input_text_field.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_text_field/input_text_field_controller.dart';
import 'package:medical_blog/presentation/widgets/modals/filters_modal/filters_modal_controller.dart';
import 'package:medical_blog/utils/constants/colors.dart';

class FiltersModal extends StatelessWidget {
  final FiltersModalController _filtersModalController =
      Get.put(FiltersModalController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InputFieldDatePicker(
            typeOfText: TextInputType.text,
            hint: "Start Date",
            controller: Get.put(
              InputFieldDatePickerController(),
              tag: 'Start Date',
            ),
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
          SizedBox(
            height: 16.0,
          ),
          CustomButton(
            onButtonTap: () {},
            buttonText: "Submit",
            backgroundColor: kBlueButtonColor,
          ),
        ],
      ),
    );
  }
}
