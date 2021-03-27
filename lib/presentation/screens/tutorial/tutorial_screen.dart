import 'package:flutter/material.dart';
import 'package:medical_blog/logic/model/tutorial_data.dart';
import 'package:medical_blog/presentation/widgets/buttons/custom_button.dart';
import 'package:medical_blog/presentation/widgets/buttons/next_tutorial_button.dart';
import 'package:medical_blog/presentation/widgets/view_pager_circle/view_pager_circle.dart';
import 'package:medical_blog/utils/constants/colors.dart';
import 'package:medical_blog/utils/constants/styles.dart';

class TutorialScreen extends StatelessWidget {
  final TutorialData tutorial;
  final Function next;
  final Function back;
  final Function skip;

  TutorialScreen({this.tutorial, this.next, this.back, this.skip});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Wrap(
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(
                            tutorial.image,
                          ),
                          SizedBox(
                            height: 32.0,
                          ),
                          Text(
                            tutorial.title,
                            style: kTutorialTitleTextStyle,
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32.0,
                            ),
                            child: Text(
                              tutorial.description,
                              style: kTutorialDescriptionTextStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 32.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: createPagerCircles(tutorial.position),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      tutorial.position != 2
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: skip,
                                    child: Text(
                                      'SKIP',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                  TutorialButton(
                                    buttonText: 'NEXT',
                                    backgroundColor: kBlueButtonColor,
                                    isEnabled: true,
                                    onButtonTap: next,
                                  ),
                                ],
                              ),
                            )
                          : CustomButton(
                              buttonText: 'START',
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
