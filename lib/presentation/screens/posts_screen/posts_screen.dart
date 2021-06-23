import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medical_blog/presentation/screens/posts_screen/posts_controller.dart';
import 'package:medical_blog/presentation/widgets/bottom_nav_bar/bottom_navigation_bar.dart';
import 'package:get/get.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_text_field_read_only/input_text_field_read_only.dart';
import 'package:medical_blog/presentation/widgets/post_card/post_card.dart';
import 'package:medical_blog/presentation/widgets/post_card/post_card_controller.dart';
import 'package:medical_blog/utils/constants/routes.dart';
import 'package:medical_blog/utils/session_temp.dart';
import 'package:pull_to_reveal/pull_to_reveal.dart';

class PostsScreen extends StatelessWidget {
  final PostsController postsController = Get.put(PostsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        shrinkWrap: true,
        controller: postsController.scrollController.value,
        slivers: [
          SliverAppBar(
            forceElevated: true,
            floating: true,
            title: InputTextFieldReadOnly(
              onTap: () => Get.toNamed(kAddPostRoute),
              hint: 'Tell us something new...',
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 18.0,
                    right: 18.0,
                    top: 18.0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: DropdownButton(
                        items: <String>[
                          'Newest first',
                          'Oldest first',
                          'Most likes first',
                          'Most dislikes first',
                        ]
                            .map(
                              (String e) => DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              ),
                            )
                            .toList(),
                        value: 'Newest first',
                        onChanged: (newValue) {
                          // _savedScreenController.setNewDropdownValue(
                          //   value: newValue,
                          // );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == postsController.postsFromFirestore.length) {
                    return CupertinoActivityIndicator();
                  }
                  return PostCard(
                    post: postsController.postsFromFirestore[index],
                    postCardController: Get.put(
                      PostCardController(
                        post: postsController.postsFromFirestore[index],
                        postId: postsController.postsFromFirestore[index].uid,
                        noOfLikes: postsController
                            .postsFromFirestore[index].noOfLikes.obs,
                        noOfDislikes: postsController
                            .postsFromFirestore[index].noOfDislikes.obs,
                        noOfComments: postsController
                            .postsFromFirestore[index].noOfComments.obs,
                        isLiked: postsController
                                .postsFromFirestore[index].likedBy
                                .contains(userUID)
                            ? true.obs
                            : false.obs,
                        isDisliked: postsController
                                .postsFromFirestore[index].dislikedBy
                                .contains(userUID)
                            ? true.obs
                            : false.obs,
                        isSaved: postsController
                                .postsFromFirestore[index].savedBy
                                .contains(userUID)
                            ? true.obs
                            : false.obs,
                      ),
                      tag: '${postsController.postsFromFirestore[index].uid}',
                    ),
                  );
                },
                childCount: postsController.postsFromFirestore.length + 1,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Obx(
        () => AnimatedContainer(
          duration: Duration(
            milliseconds: 200,
          ),
          height: postsController.isVisible.value ? 90 : 0.0,
          child: BottomNavBar(
            selectedIndex: 1,
            pressCallback: postsController.getToTop,
          ),
        ),
      ),
    );
  }
}
