import 'package:flutter/material.dart';
import 'package:medical_blog/logic/model/tutorial_data.dart';
import 'package:medical_blog/presentation/widgets/buttons/tutorial_button.dart';
import 'package:medical_blog/presentation/widgets/view_pager_circle/view_pager_circle.dart';
import 'package:medical_blog/utils/constants/colors.dart';
import 'package:medical_blog/utils/constants/images.dart';
import 'package:medical_blog/utils/constants/strings.dart';
import 'package:medical_blog/utils/constants/styles.dart';

class TutorialScreen extends StatelessWidget {
  final TutorialData tutorial;
  final Function next;
  final Function back;

  TutorialScreen({this.tutorial, this.next, this.back});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(kFirstImageTutorial),
            SizedBox(
              height: 30,
            ),
            Text(
              kFirstTutorialTitle,
              style: kTutorialTitleTextStyle,
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Wrap(
                      children: [
                        Text(
                          kFirstTutorialDescription,
                          style: kTutorialDescriptionTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: createPagerCircles(tutorial.position),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 30.0,
                  right: 30.0,
                  top: 200.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('SKIP'),
                    TutorialButton(
                      buttonText: 'NEXT',
                      backgroundColor: kBlueButtonColor,
                      isEnabled: true,
                      onButtonTap: next,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> createPagerCircles(int position) {
    List<Widget> _list = [];
    Color color;
    for (int i = 0; i < 3; i++) {
      if (i == position) {
        color = kBlueButtonColor;
      } else {
        color = Colors.grey;
      }
      _list.add(ViewPagerCircle(
        color: color,
      ));
    }
    return _list;
  }
}
