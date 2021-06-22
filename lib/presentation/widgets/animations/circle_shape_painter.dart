import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';

class ShapePainter extends CustomPainter {
  final double radius;

  ShapePainter(this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = kBlueButtonColor
      ..strokeWidth = 1.0
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(115, 15), radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
