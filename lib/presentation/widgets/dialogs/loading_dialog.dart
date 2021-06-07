import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'file:///C:/Users/alexa/AndroidStudioProjects/MedicalBlog/lib/presentation/widgets/dialogs/custom_lib_dialog.dart';
import 'package:medical_blog/presentation/widgets/animations/loading_animation.dart';

class LoadingDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      key: Key('loading_dialog_custom_dialog'),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Container(
          key: Key('loading_dialog_container_1'),
          height: Get.width * 0.36,
          width: Get.width * 0.36,
          child: LoadingAnimation()),
    );
  }
}
