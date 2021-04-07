import 'package:flutter/material.dart';
import 'package:medical_blog/presentation/screens/add_post_screen/add_post_controller.dart';
import 'package:medical_blog/utils/constants/colors.dart';
import 'package:get/get.dart';

class TagWidget extends StatelessWidget {
  final String tagName;
  final bool isIconVisible;

  TagWidget({
    @required this.tagName,
    this.isIconVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 12.0,
      ),
      child: Container(
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
                !isIconVisible
                    ? Container()
                    : GestureDetector(
                        onTap: () {
                          final AddPostController _addPostController =
                              Get.find();
                          _addPostController.deleteTag(tagName: tagName);
                        },
                        child: Icon(
                          Icons.close,
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
