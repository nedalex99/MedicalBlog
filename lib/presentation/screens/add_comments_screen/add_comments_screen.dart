import 'package:flutter/material.dart';
import 'package:medical_blog/model/post.dart';
import 'package:medical_blog/presentation/screens/add_comments_screen/add_comments_controller.dart';
import 'package:medical_blog/presentation/widgets/appbar/appbar.dart';
import 'package:medical_blog/presentation/widgets/comment_card/comment_card.dart';
import 'package:medical_blog/presentation/widgets/comment_card/comment_card_controller.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_text_field/input_text_field.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_text_field/input_text_field_controller.dart';
import 'package:medical_blog/presentation/widgets/post_card/post_card.dart';
import 'package:medical_blog/presentation/widgets/post_card/post_card_controller.dart';

import 'package:get/get.dart';
import 'package:medical_blog/utils/session_temp.dart';

class AddCommentsScreen extends StatelessWidget {
  final AddCommentsController addCommentsController;

  final Post post;
  final PostCardController postCardController;
  final int noOfResponses;

  AddCommentsScreen({
    this.post,
    this.postCardController,
    this.noOfResponses,
    this.addCommentsController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppBar(
          title: 'Add comments',
        ),
      ),
      body: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(
            bottom: 32.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: Get.width * 0.9,
                child: InputTextField(
                  typeOfText: TextInputType.text,
                  hint: 'Leave a comment...',
                  controller: Get.put(InputTextFieldController(),
                      tag: 'Leave a comment...'),
                  inputTextChecked: addCommentsController.commentTextCallback,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 8.0,
                ),
                child: GestureDetector(
                  onTap: () => addCommentsController.addCommentToPost(
                    postId: post.uid,
                  ),
                  child: Icon(
                    Icons.send,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            top: 3.0,
          ),
          child: CustomScrollView(
            controller: addCommentsController.scrollController.value,
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 2.0,
                      ),
                      child: PostCard(
                        post: post,
                        postCardController: postCardController,
                        isInAddComments: true,
                      ),
                    ),
                    Wrap(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 18.0,
                            right: 18.0,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  10.0,
                                ),
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
                            padding: EdgeInsets.all(
                              Get.height * 0.01,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(
                                  () => Text(
                                      '${addCommentsController.commentsFromFirestore.length} Responses'),
                                ),
                                Row(
                                  children: [
                                    Obx(
                                      () => DropdownButton(
                                        items: <String>[
                                          'Oldest first',
                                          'Newest first',
                                          'Most likes first',
                                          'Most dislikes first',
                                        ]
                                            .map(
                                              (String value) =>
                                                  DropdownMenuItem(
                                                value: value,
                                                child: Text(value),
                                              ),
                                            )
                                            .toList(),
                                        value: addCommentsController
                                            .dropDownValue.value,
                                        onChanged: (newValue) {
                                          addCommentsController
                                              .setNewDropDownValue(
                                            value: newValue,
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                  ],
                ),
              ),
              Obx(
                () => SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          left: 18.0,
                          right: 18.0,
                        ),
                        child: CommentCard(
                          comment: addCommentsController
                              .commentsFromFirestore[index],
                          alreadyReported: addCommentsController
                              .commentsFromFirestore[index].alreadyReported,
                          postId: post.uid,
                          commentCardController: Get.put(
                            CommentCardController(
                              comment: addCommentsController
                                  .commentsFromFirestore[index],
                              commentId: addCommentsController
                                  .commentsFromFirestore[index].commentId,
                              noOfLikes: addCommentsController
                                  .commentsFromFirestore[index].noOfLikes.obs,
                              noOfDislikes: addCommentsController
                                  .commentsFromFirestore[index]
                                  .noOfDislikes
                                  .obs,
                              isLiked: addCommentsController
                                      .commentsFromFirestore[index].likedBy
                                      .contains(userUID)
                                  ? true.obs
                                  : false.obs,
                              isDisliked: addCommentsController
                                      .commentsFromFirestore[index].dislikedBy
                                      .contains(userUID)
                                  ? true.obs
                                  : false.obs,
                            ),
                            tag: addCommentsController
                                .commentsFromFirestore[index].commentText,
                          ),
                        ),
                      );
                    },
                    childCount:
                        addCommentsController.commentsFromFirestore.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
