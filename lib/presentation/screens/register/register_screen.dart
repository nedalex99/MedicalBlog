import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medical_blog/presentation/screens/register/register_controller.dart';
import 'package:medical_blog/presentation/widgets/buttons/custom_button.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_field_date_picker/input_field_date_picker.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_field_date_picker/input_field_date_picker_controller.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_text_field/input_text_field.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_text_field/input_text_field_controller.dart';
import 'package:medical_blog/utils/constants/colors.dart';
import 'package:get/get.dart';
import 'package:medical_blog/utils/util_functions.dart';
import 'package:medical_blog/utils/validators.dart';

class RegisterScreen extends StatelessWidget {
  final RegisterController _registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 32.0,
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sign up for a Free Account',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.005,
                      ),
                      Text(
                        'All fields must be completed',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: kHintColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  InputTextField(
                    typeOfText: TextInputType.emailAddress,
                    hint: 'Email',
                    controller: Get.put(InputTextFieldController(),
                        tag: "email_register"),
                    inputTextChecked: _registerController.emailCallback,
                    validator: isValidEmail,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.025,
                  ),
                  InputTextField(
                    typeOfText: TextInputType.visiblePassword,
                    hint: 'Password',
                    controller: Get.put(InputTextFieldController(),
                        tag: "password_register"),
                    inputTextChecked: _registerController.passwordCallback,
                    validator: isValidPassword,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.025,
                  ),
                  InputTextField(
                    typeOfText: TextInputType.name,
                    hint: 'First name',
                    controller: Get.put(InputTextFieldController(),
                        tag: "first_name_register"),
                    inputTextChecked: _registerController.firstNameCallback,
                    validator: isValidName,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.025,
                  ),
                  InputTextField(
                    typeOfText: TextInputType.name,
                    hint: 'Last Name',
                    controller: Get.put(InputTextFieldController(),
                        tag: "last_name_register"),
                    inputTextChecked: _registerController.lastNameCallback,
                    validator: isValidName,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.025,
                  ),
                  InputTextField(
                    typeOfText: TextInputType.name,
                    hint: 'Country',
                    controller: Get.put(InputTextFieldController(),
                        tag: "country_register"),
                    inputTextChecked: _registerController.countryCallback,
                    validator: isValidName,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.025,
                  ),
                  InputFieldDatePicker(
                    typeOfText: TextInputType.name,
                    hint: 'Date of birth',
                    controller: Get.put(InputFieldDatePickerController(),
                        tag: "date_of_birth_register_register"),
                  ),
                ],
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.05,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: (MediaQuery.of(context).size.height * 0.025),
                    ),
                    child: CustomButton(
                      onButtonTap: () {},
                      buttonText: 'Register',
                      backgroundColor: kInactiveBlueButtonColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
