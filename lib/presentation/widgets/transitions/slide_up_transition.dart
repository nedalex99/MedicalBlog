import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SlideUpTransition extends CustomTransition {
  @override
  Widget buildTransition(
    BuildContext context,
    Curve curve,
    Alignment alignment,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget nextPage,
  ) {
    Animation<Offset> _slideUpAnimationPage =
        Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
            .animate(animation);
    return Stack(
      children: [
        SlideTransition(
          position: _slideUpAnimationPage,
          child: nextPage,
        )
      ],
    );
  }
}
