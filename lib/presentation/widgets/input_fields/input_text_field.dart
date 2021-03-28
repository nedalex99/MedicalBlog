import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_text_field_controller.dart';
import 'package:medical_blog/utils/constants/colors.dart';

class InputTextField extends StatelessWidget {
  final TextInputType typeOfText;
  final String hint;
  final InputTextFieldController controller;

  InputTextField(
      {@required this.typeOfText,
      @required this.hint,
      @required this.controller});

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      onFocusChange: (focused) => controller.handleOnFocus(focused),
      child: Obx(
        () => TextField(
          controller: controller.textController.value,
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.center,
          keyboardType: typeOfText,
          obscureText: typeOfText == TextInputType.visiblePassword
              ? controller.isHidden.value
              : false,
          onEditingComplete: () => FocusScope.of(context).unfocus(),
          onChanged: (value) {},
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
            suffixIcon: typeOfText == TextInputType.visiblePassword
                ? GestureDetector(
                    onTap: () {
                      controller.isHidden.value = !controller.isHidden.value;
                    },
                    child: controller.isHidden.value
                        ? Icon(
                            Icons.remove_red_eye,
                            color: Colors.black,
                            size: 20.0,
                          )
                        : Icon(
                            Icons.visibility_off,
                            color: Colors.black,
                            size: 20,
                          ),
                  )
                : null,
            contentPadding: const EdgeInsets.only(
              left: 12.0,
              bottom: 12.0,
            ),
            labelText: hint,
            labelStyle: controller.hintTextStyle.value,
          ),
        ),
      ),
    );
  }
}
