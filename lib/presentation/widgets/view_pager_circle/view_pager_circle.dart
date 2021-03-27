import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewPagerCircle extends StatelessWidget {
  final Color color;

  ViewPagerCircle({this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: Get.width * 0.02,
        right: Get.width * 0.02,
      ),
      width: 15.0,
      height: 15.0,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
