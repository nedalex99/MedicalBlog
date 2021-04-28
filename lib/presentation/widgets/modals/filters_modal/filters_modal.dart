import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_blog/presentation/widgets/buttons/custom_button.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_field_date_picker/input_field_date_picker.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_field_date_picker/input_field_date_picker_controller.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_text_field/input_text_field.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_text_field/input_text_field_controller.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_text_field_picker.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_text_field_picker_controller.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_text_field_read_only/input_text_field_read_only.dart';
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
          InputFieldDatePicker(
            typeOfText: TextInputType.text,
            hint: "End Date",
            controller: Get.put(
              InputFieldDatePickerController(),
              tag: 'End Date',
            ),
            inputTextChecked: _filtersModalController.endDateCallback,
          ),
          SizedBox(
            height: 16.0,
          ),
          InputTextFieldPicker(
            hint: 'Category',
            controller: Get.put(
              InputTextFieldPickerController(),
              tag: "Category",
            ),
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
