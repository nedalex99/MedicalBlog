import 'package:flutter/material.dart';
import 'package:medical_blog/presentation/screens/posts_screen/posts_controller.dart';
import 'package:medical_blog/presentation/widgets/bottom_nav_bar/bottom_navigation_bar.dart';
import 'package:get/get.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_text_field_read_only/input_text_field_read_only.dart';
import 'package:medical_blog/presentation/widgets/post_card/post_card.dart';
import 'package:medical_blog/presentation/widgets/post_card/post_card_controller.dart';
import 'package:medical_blog/utils/constants/routes.dart';
import 'package:pull_to_reveal/pull_to_reveal.dart';

class PostsScreen extends StatelessWidget {
  final PostsController postsController = Get.put(PostsController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => postsController.getPosts());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 50.0,
          left: 18.0,
          right: 18.0,
        ),
        child: Center(
          child: Obx(
            () => PullToRevealTopItemList(
              startRevealed: true,
              itemCount: postsController.postsFromFirestore.value.length,
              itemBuilder: (BuildContext context, int index) {
                return PostCard(
                  post: postsController.postsFromFirestore[index],
                  postCardController: Get.put(
                    PostCardController(
                      postId: postsController.postsFromFirestore[index].uid,
                      noOfLikes: postsController.postsFromFirestore[index].noOfLikes.obs,
                      noOfDislikes: postsController.postsFromFirestore[index].noOfDislikes.obs,
                      noOfComments: postsController.postsFromFirestore[index].noOfComments.obs,
                      isLiked: false.obs,
                      isDisliked: false.obs,
                    ),
                    tag: '${postsController.postsFromFirestore[index].uid}',
                  ),
                );
              },
              revealableHeight: 50,
              revealableBuilder: (BuildContext context,
                  RevealableToggler opener,
                  RevealableToggler closer,
                  BoxConstraints constraints) {
                return Row(
                  children: [
                    Flexible(
                      child: InputTextFieldReadOnly(
                        onTap: () => Get.toNamed(kAddPostRoute),
                        hint: 'Tell us something new...',
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 1,
      ),
    );
  }
}
