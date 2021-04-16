import 'package:flutter/material.dart';
import 'package:medical_blog/presentation/screens/saved_screen/saved_screen_controller.dart';
import 'package:medical_blog/presentation/widgets/bottom_nav_bar/bottom_navigation_bar.dart';
import 'package:get/get.dart';

class SavedScreen extends StatelessWidget {
  final SavedScreenController _savedScreenController =
      Get.put(SavedScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => Text(
              _savedScreenController.posts.length.toString(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 2,
      ),
    );
  }
}
