import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medical_blog/utils/constants/routes.dart';
import 'package:medical_blog/utils/constants/strings.dart';
import 'package:medical_blog/utils/user_preferences.dart';

class TutorialPageViewController extends GetxController {
  Rx<PageController> pageController = PageController(initialPage: 0).obs;

  PreferencesUtils _preferencesUtils = Get.find();

  bool goBack({@required BuildContext context}) {
    if (pageController.value.page.toInt() == 0) {
      Navigator.pop(context);
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
      _preferencesUtils.setTutorialFlag(kTutorialFlagKey, true);
      Get.offAllNamed(kLoginRoute);
    } else {
      pageController.value.nextPage(
        duration: Duration(
          milliseconds: 400,
        ),
        curve: Curves.linear,
      );
    }
  }

  void skipTutorial({@required BuildContext context}) {
    pageController.value.dispose();
    pageController.close();
    _preferencesUtils.setTutorialFlag(kTutorialFlagKey, true);
    Get.offAllNamed(kLoginRoute);
  }
}
