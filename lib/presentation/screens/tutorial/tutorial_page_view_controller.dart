import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medical_blog/utils/constants/routes.dart';

class TutorialPageViewController extends GetxController {
  Rx<PageController> pageController = PageController(initialPage: 0).obs;

  bool goBack() {
    if (pageController.value.page.toInt() == 0) {
      Get.back();
      return true;
    } else {
      pageController.value.previousPage(
        duration: Duration(milliseconds: 400),
        curve: Curves.linear,
      );
      return false;
    }
  }

  void goToNextTutorial({@required BuildContext context}) {
    if (pageController.value.page == 2) {
      pageController.value.dispose();
      pageController.close();
      Navigator.pushNamedAndRemoveUntil(
        context,
        loginRoute,
        (Route<dynamic> route) => false,
      );
    } else {
      pageController.value.nextPage(
        duration: Duration(
          milliseconds: 400,
        ),
        curve: Curves.linear,
      );
    }
  }
}
