import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_blog/presentation/screens/add_post_screen/add_post_controller.dart';
import 'package:medical_blog/utils/constants/colors.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final AddPostController addPostController;

  CustomAppBar({
    @required this.title,
    this.addPostController,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: false,
      leading: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
        ),
        child: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      actions: [
        addPostController != null
            ? Padding(
                padding: const EdgeInsets.all(
                  20.0,
                ),
                child: Obx(
                  () => InkWell(
                    onTap: addPostController.addTextColor.value ==
                            kActiveAddPostTextHex
                        ? addPostController.addPost
                        : null,
                    child: Text(
                      'Add',
                      style: TextStyle(
                        color: Color(addPostController.addTextColor.value),
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
