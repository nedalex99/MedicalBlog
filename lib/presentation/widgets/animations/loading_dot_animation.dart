import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medical_blog/presentation/widgets/animations/black_loading_dot.dart';

import '../../../utils/constants/colors.dart';

class LoadingDotAnimation extends StatelessWidget {
  LoadingDotAnimation({Key key, this.controller});

  final AnimationController controller;

  Animation<Color> get color => ColorTween(
    begin: Colors.black,
    end: kBlueButtonColor,
  ).animate(CurvedAnimation(
    parent: controller,
    curve: Curves.easeOut,
  ));

  Animation<Offset> get offset => Tween<Offset>(
    begin: Offset(0.0, 0.0),
    end: const Offset(0.0, -0.7),
  ).animate(CurvedAnimation(
    parent: controller,
    curve: Curves.easeOut,
  ));

// Color animation
  Widget _buildAnimation(BuildContext context, Widget child) {
    return SlideTransition(
      key: Key('slide_transition_loading_dot'),
      position: offset,
      child: BlackLoadingDot(
        color: color.value,
        key: Key('slide_transition_black_loading_dot'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      key: Key('loading_dot_animated_builder'),
      builder: _buildAnimation,
      animation: controller,
    );
  }
}
