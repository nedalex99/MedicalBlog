import 'package:flutter/material.dart';
import 'package:medical_blog/utils/constants/colors.dart';

class TutorialButton extends StatelessWidget {
  final Function onButtonTap;
  final String buttonText;
  final Color backgroundColor;
  final TextStyle buttonTextStyle;
  final bool isEnabled;

  TutorialButton(
      {this.onButtonTap,
      this.buttonText,
      this.backgroundColor,
      this.buttonTextStyle,
      this.isEnabled});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onButtonTap,
      color: backgroundColor,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 5.0,
        ),
        child: Text(
          buttonText,
          style: buttonTextStyle != null
              ? buttonTextStyle
              : TextStyle(
                  fontSize: 18.0,
                ),
        ),
      ),
    );
  }
}
