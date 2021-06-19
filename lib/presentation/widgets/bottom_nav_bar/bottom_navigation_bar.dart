import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_blog/presentation/screens/dashboard_screen/dashboard_screen.dart';
import 'package:medical_blog/presentation/screens/posts_screen/posts_screen.dart';
import 'package:medical_blog/presentation/screens/profile_screen/profile_screen.dart';
import 'package:medical_blog/presentation/screens/saved_screen/saved_screen.dart';
import 'package:medical_blog/presentation/widgets/bottom_nav_bar/bottom_nav_bar_controller.dart';
import 'package:medical_blog/utils/constants/routes.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function pressCallback;

  BottomNavBar({
    @required this.selectedIndex,
    this.pressCallback,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavyBar(
      items: [
        BottomNavyBarItem(
          icon: Icon(Icons.home),
          title: Text('News'),
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.list),
          title: Text('Posts'),
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.bookmark),
          title: Text('Saved'),
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.person),
          title: Text('Profile'),
        ),
      ],
      selectedIndex: selectedIndex,
      onItemSelected: (index) {
        changePage(index);
        if (index == selectedIndex) {
          pressCallback();
        }
      },
    );
  }

  void changePage(int index) {
    if (index != selectedIndex) {
      switch (index) {
        case 0:
          Get.off(
            () => DashboardScreen(),
            transition: Transition.noTransition,
          );
          break;
        case 1:
          Get.off(
            () => PostsScreen(),
            transition: Transition.noTransition,
          );
          break;
        case 2:
          Get.off(
            () => SavedScreen(),
            transition: Transition.noTransition,
          );
          break;
        case 3:
          Get.off(
            () => ProfileScreen(),
            transition: Transition.noTransition,
          );
          break;
        default:
          break;
      }
    }
  }
}
