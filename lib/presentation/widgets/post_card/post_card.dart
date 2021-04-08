import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_blog/logic/model/post.dart';
import 'package:medical_blog/logic/model/user_data.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_text_field_read_only/input_text_field_read_only.dart';
import 'package:medical_blog/presentation/widgets/tag_widget/tag_widget.dart';
import 'package:medical_blog/utils/constants/colors.dart';

class PostCard extends StatelessWidget {
  final UserData userData;
  final Post post;

  PostCard({
    @required this.userData,
    @required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: Get.height * 0.02,
        left: 2,
        right: 2,
      ),
      child: Wrap(
        children: [
          Container(
            padding: EdgeInsets.all(
              16.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFe6e6e6),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50.0),
                            ),
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          '1h ago',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: kHintColor,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        top: 5.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "${userData.firstName} ${userData.lastName}",
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          // SizedBox(
                          //   height: Get.height * 0.005,
                          // ),
                          Text(
                            'Student',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: kHintColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Icon(
                          Icons.more_vert_rounded,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.013,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    post.title,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.005,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    post.description,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.009,
                ),
                Divider(
                  height: 2,
                  thickness: 2,
                  color: kHintColor,
                ),
                SizedBox(
                  height: Get.height * 0.009,
                ),
                Row(
                  children: List<TagWidget>.generate(
                    post.tags.length,
                    (index) => TagWidget(
                      tagName: post.tags[index],
                      isIconVisible: false,
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Row(
                  children: [
                    Text('${post.noOfLikes} Likes'),
                    SizedBox(
                      width: Get.width * 0.09,
                    ),
                    Text('${post.noOfDislikes} Dislikes'),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text('${post.noOfComments} Comments'),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.008,
                ),
                Divider(
                  height: 2,
                  thickness: 2,
                  color: kHintColor,
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.thumb_up_alt_outlined,
                        ),
                        SizedBox(
                          width: Get.width * 0.015,
                        ),
                        Text(
                          'Like',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.thumb_down_alt_outlined,
                        ),
                        SizedBox(
                          width: Get.width * 0.015,
                        ),
                        Text(
                          'Dislike',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Divider(
                  height: 2,
                  thickness: 2,
                  color: kHintColor,
                ),
                SizedBox(
                  height: Get.height * 0.008,
                ),
                InputTextFieldReadOnly(
                  hint: 'Leave a comment...',
                  onTap: () => Get.back(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
