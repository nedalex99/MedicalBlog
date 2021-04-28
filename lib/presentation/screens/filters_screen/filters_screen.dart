import 'package:flutter/material.dart';
import 'package:medical_blog/presentation/screens/filters_screen/filters_screen_controller.dart';
import 'package:medical_blog/presentation/widgets/appbar/appbar.dart';
import 'package:medical_blog/presentation/widgets/buttons/custom_button.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_field_date_picker/input_field_date_picker.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_field_date_picker/input_field_date_picker_controller.dart';
import 'package:get/get.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_text_field_picker.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_text_field_picker_controller.dart';
import 'package:medical_blog/utils/constants/colors.dart';

class FiltersScreen extends StatelessWidget {
  final FiltersScreenController filtersScreenController;

  FiltersScreen({
    this.filtersScreenController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: CustomAppBar(
          title: 'Filters',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 30.0,
          right: 30.0,
        ),
        child: Column(
          children: [
            InputFieldDatePicker(
              typeOfText: TextInputType.text,
              hint: "Start Date",
              controller: Get.put(
                InputFieldDatePickerController(
                  inputTextChecked: filtersScreenController.startDateCallback,
                ),
                tag: 'Start Date',
              ),
              inputTextChecked: filtersScreenController.startDateCallback,
            ),
            SizedBox(
              height: 16.0,
            ),
            InputFieldDatePicker(
              typeOfText: TextInputType.text,
              hint: "End Date",
              controller: Get.put(
                InputFieldDatePickerController(
                  inputTextChecked: filtersScreenController.endDateCallback,
                ),
                tag: 'End Date',
              ),
              inputTextChecked: filtersScreenController.endDateCallback,
            ),
            SizedBox(
              height: 16.0,
            ),
            InputTextFieldPicker(
              hint: 'Category',
              controller: Get.put(
                InputTextFieldPickerController(
                  inputTextChecked: filtersScreenController.categoryCallback,
                ),
                tag: "Category",
              ),
              onTap: () {},
            ),
            SizedBox(
              height: 16.0,
            ),
            CustomButton(
              onButtonTap: filtersScreenController.applyFilters,
              buttonText: "Apply filters",
              backgroundColor: kBlueButtonColor,
            ),
          ],
        ),
      ),
    );
  }
}
