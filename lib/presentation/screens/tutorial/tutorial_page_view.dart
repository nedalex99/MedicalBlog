import 'package:flutter/material.dart';
import 'package:medical_blog/presentation/screens/tutorial/tutorial_page_view_controller.dart';
import 'package:medical_blog/presentation/screens/tutorial/tutorial_screen.dart';
import 'package:medical_blog/utils/constants/values.dart';
import 'package:get/get.dart';

class TutorialPageView extends StatelessWidget {
  final _controller = Get.put(TutorialPageViewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.horizontal,
        controller: _controller.pageController.value,
        children: [
          TutorialScreen(
            tutorial: tutorialList[0],
            back: _controller.goBack,
            next: () => _controller.goToNextTutorial(context: context),
          ),
          TutorialScreen(
            tutorial: tutorialList[1],
            back: _controller.goBack,
            next: () => _controller.goToNextTutorial(context: context),
          ),
          TutorialScreen(
            tutorial: tutorialList[2],
            back: _controller.goBack,
            next: () => _controller.goToNextTutorial(context: context),
          ),
        ],
      ),
    );
  }
}
