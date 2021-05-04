import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medical_blog/presentation/screens/dashboard_screen/dashboard_controller.dart';
import 'package:medical_blog/presentation/widgets/bottom_nav_bar/bottom_navigation_bar.dart';
import 'package:medical_blog/presentation/widgets/news_card/news_card.dart';
import 'package:medical_blog/utils/network/auth_service.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  final DashboardController _dashboardController =
      Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _dashboardController.scrollController.value,
        slivers: [
          Obx(
            () => SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == _dashboardController.newsList.value.length) {
                    return CupertinoActivityIndicator();
                  }
                  return Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: NewsCard(
                      news: _dashboardController.newsList[index],
                    ),
                  );
                },
                childCount: _dashboardController.newsList.value.length + 1,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 0,
      ),
    );
  }
}
