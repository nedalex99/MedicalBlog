import 'package:flutter/material.dart';
import 'package:medical_blog/presentation/screens/add_post_screen/add_post_controller.dart';
import 'package:medical_blog/utils/constants/colors.dart';
import 'package:get/get.dart';

class TagWidget extends StatelessWidget {
  final String tagName;

  TagWidget({
    @required this.tagName,
  });

  final AddPostController _addPostController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4.0,
      ),
      decoration: BoxDecoration(
        color: kTagBackgroundColor,
        borderRadius: BorderRadius.all(
          Radius.circular(
            6.0,
          ),
        ),
      ),
      child: Row(
        children: [
          Row(
            children: [
              Text(
                tagName,
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              GestureDetector(
                onTap: () => _addPostController.deleteTag(tagName: tagName),
                child: Icon(Icons.close),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
