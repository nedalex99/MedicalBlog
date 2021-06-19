import 'package:flutter/material.dart';
import 'package:medical_blog/presentation/screens/add_post_screen/add_post_controller.dart';
import 'package:medical_blog/presentation/widgets/appbar/appbar.dart';
import 'package:medical_blog/presentation/widgets/input_fields/text_form_field/input_field.dart';
import 'package:medical_blog/presentation/widgets/input_fields/text_form_field/text_field_controller.dart';
import 'package:get/get.dart';
import 'package:medical_blog/utils/constants/colors.dart';

class AddPostScreen extends StatelessWidget {
  final AddPostController _addPostController = Get.put(AddPostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
          80,
        ),
        child: CustomAppBar(
          title: 'Create post',
          addPostController: _addPostController,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 30.0,
            right: 30.0,
            bottom: 50.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      right: 10.0,
                      bottom: 8.0,
                    ),
                    child: Obx(
                      () => CircleAvatar(
                        radius: 25,
                        backgroundColor: kBlueButtonColor,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            25.0,
                          ),
                          child: _addPostController.url.value != ""
                              ? Image.network(
                                  _addPostController.url.value,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.fill,
                                )
                              : Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.grey,
                                ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => Text(
                          "${_addPostController.userData.value.firstName} ${_addPostController.userData.value.lastName}",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: kTextBlack1C,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.001,
                      ),
                      Obx(
                        () => Text(
                          "${_addPostController.userData.value.profession}",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: kHintColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              InputField(
                hint: 'Title',
                textFieldController:
                    Get.put(TextFieldController(), tag: 'title'),
                inputTextChecked: _addPostController.titleCallback,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              InputField(
                hint: 'Description',
                textFieldController: Get.put(
                  TextFieldController(),
                  tag: 'description',
                ),
                inputTextChecked: _addPostController.descriptionCallback,
              ),
              SizedBox(
                height: Get.height * 0.08,
              ),
              GestureDetector(
                onTap: _addPostController.showTagPicker,
                child: Row(
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: Get.width * 0.01,
                    ),
                    Text(
                      'Tags',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Obx(
                () => Row(
                  children: _addPostController.tagWidgetList,
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Row(
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: Get.width * 0.01,
                  ),
                  Text(
                    'Photos',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
