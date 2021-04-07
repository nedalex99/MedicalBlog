import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputTextFieldReadOnly extends StatelessWidget {
  final String hint;
  final Function onTap;

  InputTextFieldReadOnly({
    @required this.hint,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.start,
      readOnly: true,
      controller: TextEditingController()..text = hint,
      onTap: onTap,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        focusColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.black,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(6.0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.black,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(6.0),
          ),
        ),
      ),
    );
  }
}
