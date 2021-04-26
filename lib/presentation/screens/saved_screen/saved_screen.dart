import 'package:flutter/material.dart';
import 'package:medical_blog/presentation/screens/saved_screen/saved_screen_controller.dart';
import 'package:medical_blog/presentation/widgets/bottom_nav_bar/bottom_navigation_bar.dart';
import 'package:get/get.dart';
import 'package:medical_blog/presentation/widgets/post_card/post_card.dart';

class SavedScreen extends StatelessWidget {
  final SavedScreenController _savedScreenController =
      Get.put(SavedScreenController());

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   _savedScreenController.getPosts();
    // });
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 50.0,
          left: 18.0,
          right: 18.0,
        ),
        child: Obx(
          () => ListView.builder(
            itemBuilder: (context, index) => PostCard(
              post: _savedScreenController.posts[index],
              postCardController: Get.find(
                tag: _savedScreenController.posts[index].uid,
              ),
            ),
            itemCount: _savedScreenController.posts.length,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 2,
      ),
    );
  }
}
