import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlackLoadingDot extends StatelessWidget {
  final Color color;

  BlackLoadingDot({Key key, @required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key('loading_dot_container'),
      margin:
      EdgeInsets.only(left: Get.width * 0.012, right: Get.width * 0.012),
      width: 19,
      height: 18,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
