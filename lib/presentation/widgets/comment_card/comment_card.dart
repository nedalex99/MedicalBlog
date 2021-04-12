import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_blog/logic/model/comment.dart';
import 'package:medical_blog/presentation/widgets/comment_card/comment_card_controller.dart';
import 'package:medical_blog/utils/constants/colors.dart';
import 'package:medical_blog/utils/util_functions.dart';

class CommentCard extends StatelessWidget {
  final Comment comment;
  final CommentCardController commentCardController;

  CommentCard({
    @required this.comment,
    @required this.commentCardController,
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
                          '${handleSecondsFromTimestamp(comment.timestamp.seconds)} ago',
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
                            "${comment.userData.firstName} ${comment.userData.lastName}",
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    comment.commentText,
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
                    GestureDetector(
                      onTap: commentCardController.onLikeTap,
                      child: Row(
                        children: [
                          Obx(
                            () => Icon(
                              commentCardController.isLiked.value
                                  ? Icons.thumb_up_alt
                                  : Icons.thumb_up_alt_outlined,
                            ),
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
                    ),
                    GestureDetector(
                      onTap: commentCardController.onDislikeTap,
                      child: Row(
                        children: [
                          Obx(
                            () => Icon(
                              commentCardController.isDisliked.value
                                  ? Icons.thumb_down_alt
                                  : Icons.thumb_down_alt_outlined,
                            ),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
