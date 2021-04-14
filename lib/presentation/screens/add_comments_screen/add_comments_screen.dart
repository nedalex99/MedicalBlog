import 'package:flutter/material.dart';
import 'package:medical_blog/logic/model/post.dart';
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
  final AddCommentsController _addCommentsController =
      Get.put(AddCommentsController());

  final Post post;
  final PostCardController postCardController;
  final int noOfResponses;

  AddCommentsScreen({
    this.post,
    this.postCardController,
    this.noOfResponses,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => _addCommentsController.getComments(postId: post.uid));
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
                  inputTextChecked: _addCommentsController.commentTextCallback,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 8.0,
                ),
                child: GestureDetector(
                  onTap: () => _addCommentsController.addCommentToPost(
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
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 2.0,
                        left: 18.0,
                        right: 18.0,
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
                                Text('3 Responses'),
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
                                        value: _addCommentsController
                                            .dropDownValue.value,
                                        onChanged: (newValue) {
                                          _addCommentsController
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
                          comment: _addCommentsController
                              .commentsFromFirestore[index],
                          postId: post.uid,
                          commentCardController: Get.put(
                            CommentCardController(
                              commentId: _addCommentsController
                                  .commentsFromFirestore[index].commentId,
                              noOfLikes: _addCommentsController
                                  .commentsFromFirestore[index].noOfLikes.obs,
                              noOfDislikes: _addCommentsController
                                  .commentsFromFirestore[index]
                                  .noOfDislikes
                                  .obs,
                              isLiked: _addCommentsController
                                      .commentsFromFirestore[index].likedBy
                                      .contains(userUID)
                                  ? true.obs
                                  : false.obs,
                              isDisliked: _addCommentsController
                                      .commentsFromFirestore[index].dislikedBy
                                      .contains(userUID)
                                  ? true.obs
                                  : false.obs,
                            ),
                            tag: _addCommentsController
                                .commentsFromFirestore[index].commentText,
                          ),
                        ),
                      );
                    },
                    childCount:
                        _addCommentsController.commentsFromFirestore.length,
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
