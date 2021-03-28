import 'package:flutter/material.dart';
import 'package:medical_blog/presentation/widgets/buttons/custom_button.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_text_field.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_text_field_controller.dart';
import 'package:medical_blog/utils/constants/colors.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
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
                children: [
                  Column(
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
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.025,
                  ),
                  InputTextField(
                    typeOfText: TextInputType.visiblePassword,
                    hint: 'Password',
                    controller: Get.put(InputTextFieldController(),
                        tag: "password_register"),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.025,
                  ),
                  InputTextField(
                    typeOfText: TextInputType.name,
                    hint: 'First name',
                    controller: Get.put(InputTextFieldController(),
                        tag: "first_name_register"),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.025,
                  ),
                  InputTextField(
                    typeOfText: TextInputType.name,
                    hint: 'Last Name',
                    controller: Get.put(InputTextFieldController(),
                        tag: "last_name_register"),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.025,
                  ),
                  InputTextField(
                    typeOfText: TextInputType.name,
                    hint: 'Country',
                    controller: Get.put(InputTextFieldController(),
                        tag: "country_register"),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.025,
                  ),
                  InputTextField(
                    typeOfText: TextInputType.name,
                    hint: 'Date of birth',
                    controller: Get.put(InputTextFieldController(),
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
                  child: CustomButton(
                    onButtonTap: () {},
                    buttonText: 'Register',
                    backgroundColor: kInactiveBlueButtonColor,
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

/*
body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.05,
          horizontal: 32.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
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
                controller:
                    Get.put(InputTextFieldController(), tag: "email_register"),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.025,
              ),
              InputTextField(
                typeOfText: TextInputType.visiblePassword,
                hint: 'Password',
                controller: Get.put(InputTextFieldController(),
                    tag: "password_register"),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.025,
              ),
              InputTextField(
                typeOfText: TextInputType.name,
                hint: 'First name',
                controller: Get.put(InputTextFieldController(),
                    tag: "first_name_register"),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.025,
              ),
              InputTextField(
                typeOfText: TextInputType.name,
                hint: 'Last Name',
                controller: Get.put(InputTextFieldController(),
                    tag: "last_name_register"),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.025,
              ),
              InputTextField(
                typeOfText: TextInputType.name,
                hint: 'Country',
                controller: Get.put(InputTextFieldController(),
                    tag: "country_register"),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.025,
              ),
              InputTextField(
                typeOfText: TextInputType.name,
                hint: 'Date of birth',
                controller: Get.put(InputTextFieldController(),
                    tag: "date_of_birth_register_register"),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomButton(
                    onButtonTap: () {},
                    buttonText: 'Register',
                    backgroundColor: kInactiveBlueButtonColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
 */
