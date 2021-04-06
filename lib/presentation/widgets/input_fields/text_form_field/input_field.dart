import 'package:flutter/material.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_field_date_picker/input_field_date_picker.dart';
import 'package:medical_blog/presentation/widgets/input_fields/text_form_field/text_field_controller.dart';

class InputField extends StatelessWidget {
  @required final String hint;
  @required final CheckCallback inputTextChecked;
  @required final TextFieldController textFieldController;

  InputField({
    this.hint,
    this.inputTextChecked,
    this.textFieldController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      controller: textFieldController.textController.value,
      onChanged: inputTextChecked,
      decoration: InputDecoration(
        hintText: hint,
      ),
    );
  }
}
