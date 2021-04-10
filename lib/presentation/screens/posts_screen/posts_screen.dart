import 'package:flutter/material.dart';
import 'package:medical_blog/logic/model/post.dart';
import 'package:medical_blog/logic/model/user_data.dart';
import 'package:medical_blog/presentation/screens/add_post_screen/add_post_controller.dart';
import 'package:medical_blog/presentation/screens/posts_screen/posts_controller.dart';
import 'package:medical_blog/presentation/widgets/bottom_nav_bar/bottom_navigation_bar.dart';
import 'package:get/get.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_text_field_read_only/input_text_field_read_only.dart';
import 'package:medical_blog/presentation/widgets/post_card/post_card.dart';
import 'package:medical_blog/utils/constants/routes.dart';
import 'package:pull_to_reveal/pull_to_reveal.dart';

class PostsScreen extends StatelessWidget {
  final PostsController _addPostController = Get.put(PostsController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _addPostController.getPosts());
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
              itemCount: _addPostController.postsFromFirestore.value.length,
              itemBuilder: (BuildContext context, int index) {
                return PostCard(
                  post: _addPostController.postsFromFirestore[index],
                );
              },
              revealableHeight: 50,
              revealableBuilder: (BuildContext context, RevealableToggler opener,
                  RevealableToggler closer, BoxConstraints constraints) {
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
