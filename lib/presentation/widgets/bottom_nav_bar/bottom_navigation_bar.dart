import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_blog/presentation/widgets/bottom_nav_bar/bottom_nav_bar_controller.dart';
import 'package:medical_blog/utils/constants/routes.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;

  BottomNavBar({@required this.selectedIndex});

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
      },
    );
  }

  void changePage(int index) {
    if (index != selectedIndex) {
      switch (index) {
        case 0:
          Get.offAllNamed(kDashboardRoute);
          break;
        case 1:
          Get.toNamed(kPostsRoute);
          break;
        case 2:
          Get.toNamed(kSavedRoute);
          break;
        case 3:
          Get.toNamed(kProfileRoute);
          break;
        default:
          break;
      }
    }
  }
}
