import 'package:flutter/material.dart';
import 'package:medical_blog/model/user_info.dart';
import 'package:medical_blog/presentation/screens/update_account_screen/update_account_controller.dart';
import 'package:medical_blog/presentation/widgets/appbar/appbar.dart';
import 'package:medical_blog/presentation/widgets/buttons/custom_button.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_text_field/input_text_field.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_text_field/input_text_field_controller.dart';
import 'package:get/get.dart';
import 'package:medical_blog/utils/constants/colors.dart';

class UpdateAccountScreen extends StatelessWidget {
  final UserInfo userInfo;
  final UpdateAccountController controller;

  UpdateAccountScreen({
    this.userInfo,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: CustomAppBar(
          title: userInfo.name,
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 30.0,
                horizontal: 32.0,
              ),
              child: Column(
                children: [
                  InputTextField(
                    typeOfText: TextInputType.text,
                    hint: userInfo.name,
                    controller: Get.put(
                      InputTextFieldController()
                        ..textController.value.text = userInfo.name,
                      tag: userInfo.name,
                    ),
                    inputTextChecked: controller.nameCallback,
                  )
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
                      padding: const EdgeInsets.only(
                        bottom: 32.0,
                      ),
                      child: CustomButton(
                        buttonText: 'Submit',
                        backgroundColor: kBlueButtonColor,
                        onButtonTap: () => userInfo.function(
                          controller.name,
                        ),
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
