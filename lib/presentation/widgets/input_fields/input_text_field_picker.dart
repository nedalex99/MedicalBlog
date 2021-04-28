import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_text_field_picker_controller.dart';

class InputTextFieldPicker extends StatelessWidget {
  final String hint;
  final Function onTap;
  final InputTextFieldPickerController controller;

  InputTextFieldPicker({
    @required this.hint,
    @required this.onTap,
    @required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.start,
      readOnly: true,
      controller: controller.textController.value..text = hint,
      onTap: controller.showCategoryPicker,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        focusColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.black,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(6.0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.black,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(6.0),
          ),
        ),
      ),
    );
  }
}
