import 'package:flutter/material.dart';
import 'package:medical_blog/presentation/widgets/buttons/custom_button.dart';
import 'package:medical_blog/presentation/widgets/checkbox/custom_checkbox.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_text_field.dart';
import 'package:get/get.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_text_field_controller.dart';
import 'package:medical_blog/utils/constants/colors.dart';
import 'package:medical_blog/utils/constants/routes.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 32.0,
          ),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              Center(
                child: Text(
                  'Medical blog',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              SizedBox(
                height: 80,
              ),
              InputTextField(
                hint: 'Email',
                typeOfText: TextInputType.emailAddress,
                controller: Get.put(
                  InputTextFieldController(),
                  tag: 'Email',
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              InputTextField(
                hint: 'Password',
                typeOfText: TextInputType.visiblePassword,
                controller: Get.put(
                  InputTextFieldController(),
                  tag: 'Password',
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forgot your password?',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: kBlueButtonColor,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Row(
                children: [
                  CustomCheckbox(
                    isSelected: false,
                    onTap: () {},
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Text(
                    'Keep me authenticated',
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              CustomButton(
                onButtonTap: () {},
                buttonText: 'Login',
                backgroundColor: kInactiveBlueButtonColor,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.05),
                    child: CustomButton(
                      buttonText: 'Register',
                      onButtonTap: () {
                        Navigator.of(context).pushNamed(registerRoute);
                      },
                      isEnabled: true,
                      backgroundColor: kBlueButtonColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
