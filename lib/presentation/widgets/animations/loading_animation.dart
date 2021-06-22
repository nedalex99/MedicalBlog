import 'package:flutter/material.dart';
import 'package:medical_blog/presentation/widgets/animations/loading_screen_animation.dart';
import 'package:get/get.dart';
import '../../../utils/constants/strings.dart';
import '../../../utils/constants/styles.dart';

class LoadingAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      key: Key('loading_dialog_column_1'),
      children: <Widget>[
        SizedBox(
            key: Key('loading_dialog_sized_box_1'), height: Get.height * 0.03),
        Row(
            key: Key('loading_dialog_row_1'),
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              LoadingScreenAnimationController(position: 0),
              LoadingScreenAnimationController(position: 1),
              LoadingScreenAnimationController(position: 2),
              LoadingScreenAnimationController(position: 3),
            ]),
        SizedBox(
            key: Key('loading_dialog_sized_box_2'), height: Get.height * 0.034),
        Text(
          kPleaseWaitText,
          textAlign: TextAlign.center,
          style: kLoadingTextStyle,
          key: Key('loading_dialog_text_1'),
        ),
      ],
    );
  }
}
