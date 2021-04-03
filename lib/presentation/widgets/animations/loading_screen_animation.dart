import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:medical_blog/presentation/widgets/animations/loading_dot_animation.dart';

class LoadingScreenAnimationController extends StatefulWidget {
  LoadingScreenAnimationController({Key key, @required this.position});

  final int position;

  @override
  _LoadingScreenAnimationControllerState createState() =>
      _LoadingScreenAnimationControllerState();
}

class _LoadingScreenAnimationControllerState
    extends State<LoadingScreenAnimationController>
    with TickerProviderStateMixin {
  AnimationController _controller;
  var loopAnimation;
  var firstAnimation;

  @override
  Widget build(BuildContext context) {
    return LoadingDotAnimation(
      key: Key('loading_animation_dot'),
      controller: _controller.view,
    );
  }

  @override
  void dispose() {
    _stopAnimation();
    super.dispose();
  }

  void _startAnimation() {
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        loopAnimation = Timer(Duration(milliseconds: 800), () {
          _controller.forward().whenComplete(() => _controller.reverse());
        });
      }
    });
    firstAnimation = Timer(Duration(milliseconds: widget.position * 400), () {
      _controller.forward().whenComplete(() => _controller.reverse());
    });
  }

  void _stopAnimation() {
    if (firstAnimation != null) firstAnimation.cancel();
    if (loopAnimation != null) loopAnimation.cancel();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);
    _startAnimation();
  }
}
