import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Appbar extends StatelessWidget {
  final String title;

  Appbar({@required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: false,
      leading: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
        ),
        child: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
    );
  }
}
