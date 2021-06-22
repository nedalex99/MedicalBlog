import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_blog/presentation/screens/register_profession_screen/register_profession_controller.dart';
import 'package:medical_blog/presentation/widgets/buttons/custom_button.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_text_field_picker/input_text_field_picker.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_text_field_picker/input_text_field_picker_controller.dart';
import 'package:medical_blog/utils/constants/colors.dart';

class RegisterProfession extends StatelessWidget {
  final RegisterProfessionController _controller =
      Get.put(RegisterProfessionController());
  final String userUID;

  RegisterProfession({
    this.userUID,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: Get.height * 0.09,
                horizontal: 32.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tell us more about your medical field',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'All fields must be completed',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: kHintColor,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.025,
                  ),
                  InputTextFieldPicker(
                    hint: 'Profession',
                    controller: Get.put(
                      InputTextFieldPickerController(
                        inputTextChecked: _controller.updateProfessionCallback,
                        cupertinoTagList: [
                          'Student',
                          'Surgeon',
                          'Family doctor',
                        ],
                      ),
                      tag: 'Profession',
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.025,
                  ),
                  InputTextFieldPicker(
                    hint: 'Specialty',
                    controller: Get.put(
                      InputTextFieldPickerController(
                        inputTextChecked: _controller.updateSpecialtyCallback,
                        cupertinoTagList: [
                          'Cardiology',
                          'Neurology',
                          'Pediatry',
                        ],
                      ),
                      tag: 'Specialty',
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.025,
                  ),
                  Obx(
                    () => _controller.specialty.value.isNotEmpty
                        ? InputTextFieldPicker(
                            hint: _controller.profession.value == 'Student'
                                ? 'Year of graduation'
                                : 'Years of experience',
                            controller: Get.put(
                              InputTextFieldPickerController(
                                inputTextChecked:
                                    _controller.updateYearOfGraduationCallback,
                                cupertinoTagList: [
                                  '1',
                                  '2',
                                  '3',
                                  '4',
                                ],
                              ),
                              tag: _controller.profession.value == 'Student'
                                  ? 'Year of graduation'
                                  : 'Years of experience',
                            ),
                          )
                        : Container(),
                  ),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.05,
                      ),
                      child: CustomButton(
                        onButtonTap: () =>
                            _controller.updateUserProfile(uid: userUID),
                        buttonText: 'Submit',
                        backgroundColor: kBlueButtonColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
