import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_blog/model/post.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_text_field_read_only/input_text_field_read_only.dart';
import 'package:medical_blog/presentation/widgets/post_card/post_card_controller.dart';
import 'package:medical_blog/presentation/widgets/tag_widget/tag_widget.dart';
import 'package:medical_blog/utils/constants/colors.dart';
import 'package:medical_blog/utils/util_functions.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final PostCardController postCardController;
  final bool isInAddComments;
  final bool isInSavedScreen;
  final bool alreadyReported;

  PostCard({
    @required this.post,
    this.postCardController,
    this.isInAddComments = false,
    this.isInSavedScreen = false,
    this.alreadyReported,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: Get.height * 0.02,
        left: 18,
        right: 18,
      ),
      child: Wrap(
        children: [
          GestureDetector(
            onTap: () => postCardController.getToAddComments(
              postCardController: postCardController,
            ),
            child: Container(
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
                    blurRadius: 10,
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
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: kBlueButtonColor,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                25.0,
                              ),
                              child: post.image != null
                                  ? Image.network(
                                      post.image,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.fill,
                                    )
                                  : Container(
                                      height: 50,
                                      width: 50,
                                      color: Colors.grey,
                                    ),
                            ),
                          ),
                          Text(
                            '${handleMillisecondsFromTimestamp(post.timestamp)} ago',
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
                              "${post.userData.firstName} ${post.userData.lastName}",
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            Text(
                              post.userData.profession != null
                                  ? post.userData.profession
                                  : 'Student',
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
                          child: IconButton(
                            onPressed: () => postCardController.showModal(
                              isInSavedScreen: isInSavedScreen,
                              alreadyReported: alreadyReported,
                            ),
                            icon: Icon(
                              Icons.more_vert_rounded,
                            ),
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
                      Obx(
                        () =>
                            Text('${postCardController.noOfLikes.value} Likes'),
                      ),
                      SizedBox(
                        width: Get.width * 0.09,
                      ),
                      Obx(
                        () => Text(
                          '${postCardController.noOfDislikes.value} Dislikes',
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Obx(
                            () => Text(
                              '${postCardController.noOfComments.value} Comments',
                            ),
                          ),
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
                      GestureDetector(
                        onTap: postCardController.onLikeTap,
                        child: Row(
                          children: [
                            Obx(
                              () => Icon(
                                postCardController.isLiked.value
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
                        onTap: postCardController.onDislikeTap,
                        child: Row(
                          children: [
                            Obx(
                              () => Icon(
                                postCardController.isDisliked.value
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
                  !isInAddComments
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width * 0.85,
                          height: 50.0,
                          child: InputTextFieldReadOnly(
                            hint: 'Leave a comment...',
                            onTap: () => postCardController.getToAddComments(
                              postCardController: postCardController,
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
