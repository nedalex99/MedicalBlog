import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_field_date_picker/input_field_date_picker_controller.dart';
import 'package:medical_blog/utils/constants/colors.dart';

typedef CheckCallback(String value);

class InputFieldDatePicker extends StatelessWidget {
  final TextInputType typeOfText;
  final String hint;
  final InputFieldDatePickerController controller;
  final CheckCallback inputTextChecked;
  final Function validator;
  final Function isDatePicker;

  InputFieldDatePicker(
      {@required this.typeOfText,
      @required this.hint,
      @required this.controller,
      this.inputTextChecked,
      this.validator,
      this.isDatePicker});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => FocusScope(
        onFocusChange: (focused) {
          if (validator != null && !focused) {
            controller.errorText.value =
                validator(controller.textController.value.text, hint);
          }
          controller.handleOnFocus(focused);
        },
        child: TextField(
          controller: controller.textController.value,
          textAlign: TextAlign.start,
          readOnly: true,
          textAlignVertical: TextAlignVertical.center,
          keyboardType: typeOfText,
          onChanged: (value) {
            inputTextChecked(controller.textController.value.text);
          },
          onTap: () => controller.getDate(context),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: kHintColor,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(6.0),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: kBlueSideColor,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  6.0,
                ),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: kRedErrorColor,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  6.0,
                ),
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: kRedErrorColor,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  6.0,
                ),
              ),
            ),
            contentPadding: const EdgeInsets.only(
              left: 12.0,
              bottom: 12.0,
            ),
            labelText: hint,
            labelStyle: controller.hintTextStyle.value,
            errorMaxLines: 2,
          ),
        ),
      ),
    );
  }
}
