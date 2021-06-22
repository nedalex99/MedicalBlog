import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_field_date_picker/input_field_date_picker.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_text_field_search_controller.dart';

class InputTextFieldSearch extends StatelessWidget {
  final InputTextFieldSearchController _controller =
      Get.put(InputTextFieldSearchController());

  final CheckCallback inputTextChecked;
  final Function getNewsByTitle;

  InputTextFieldSearch({
    this.getNewsByTitle,
    this.inputTextChecked,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller.textController.value,
      onChanged: (value) {
        inputTextChecked(value);
        getNewsByTitle(value);
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(6.0),
          ),
        ),
        hintText: 'Search',
      ),
    );
  }
}
