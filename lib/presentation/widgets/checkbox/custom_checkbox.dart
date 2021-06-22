import 'package:flutter/material.dart';
import 'package:medical_blog/utils/constants/colors.dart';

class CustomCheckbox extends StatelessWidget {
  final bool isSelected;
  final Function onTap;

  CustomCheckbox({this.isSelected, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      child: Container(
        width: 25.0,
        height: 25.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(
              4.0,
            ),
          ),
          border: Border.all(
            color: isSelected ? kTextBlack1C : kHintColor,
            width: 1.5,
          ),
        ),
        child: isSelected
            ? Center(
                child: Icon(
                  Icons.check_rounded,
                  color: Colors.black,
                  size: 21.5,
                ),
              )
            : null,
      ),
    );
  }
}
