import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medical_blog/logic/model/comment.dart';
import 'package:medical_blog/logic/model/post.dart';
import 'package:medical_blog/logic/model/user_data.dart';
import 'package:medical_blog/presentation/screens/add_comments_screen/add_comments_controller.dart';
import 'package:medical_blog/presentation/widgets/comment_card/comment_card.dart';
import 'package:medical_blog/presentation/widgets/comment_card/comment_card_controller.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_text_field/input_text_field.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_text_field/input_text_field_controller.dart';
import 'package:medical_blog/presentation/widgets/post_card/post_card.dart';
import 'package:medical_blog/presentation/widgets/post_card/post_card_controller.dart';

import 'package:get/get.dart';

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
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.only(
            top: 50.0,
            left: 18.0,
            right: 18.0,
          ),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    PostCard(
                      post: post,
                      postCardController: postCardController,
                      isInAddComments: true,
                    ),
                    Wrap(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                20.0,
                              ),
                            ),
                          ),
                          padding: EdgeInsets.all(
                            Get.height * 0.02,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('3 Responses'),
                              Row(
                                children: [
                                  Text(
                                    'Oldest first',
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    size: 25,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    CommentCard(
                      comment: Comment(
                        commentText: 'Abc',
                        userData: UserData(firstName: 'abc', lastName: 'bbc'),
                        commentId: '123',
                        noOfLikes: 0,
                        noOfDislikes: 0,
                        timestamp: Timestamp.now(),
                      ),
                      commentCardController: Get.put(
                        CommentCardController(
                            noOfLikes: 0.obs,
                            noOfDislikes: 0.obs,
                            commentId: '123',
                            isDisliked: false.obs,
                            isLiked: false.obs),
                        tag: 'abc',
                      ),
                    ),
                  ],
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: true,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    child: ListView(
                      reverse: true,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 20.0,
                          ),
                          child: InputTextField(
                            typeOfText: TextInputType.text,
                            hint: 'Leave a comment...',
                            controller: Get.put(InputTextFieldController(),
                                tag: 'Leave a comment...'),
                            inputTextChecked:
                                _addCommentsController.commentTextCallback,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
