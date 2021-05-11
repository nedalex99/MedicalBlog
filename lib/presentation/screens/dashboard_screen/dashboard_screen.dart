import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medical_blog/presentation/screens/dashboard_screen/dashboard_controller.dart';
import 'package:medical_blog/presentation/widgets/bottom_nav_bar/bottom_navigation_bar.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_text_field_search.dart';
import 'package:medical_blog/presentation/widgets/news_card/news_card.dart';
import 'package:medical_blog/presentation/widgets/news_card/news_card_controller.dart';
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
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(
                  height: 50.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFe6e6e6),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: InputTextFieldSearch(
                      inputTextChecked: _dashboardController.titleCallback,
                      getNewsByTitle: _dashboardController.getNewsByTitle,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Today',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'see more >',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: NewsCard(
                      news: _dashboardController.todayNewsList[index],
                    ),
                  );
                },
                childCount: _dashboardController.todayNewsList.length,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Trending',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'see more >',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: NewsCard(
                      news: _dashboardController.trendingNewsList[index],
                    ),
                  );
                },
                childCount: _dashboardController.trendingNewsList.length,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Latest',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == _dashboardController.newsList.value.length) {
                    return CupertinoActivityIndicator();
                  }
                  return Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: NewsCard(
                      news: _dashboardController.newsList[index],
                      newsCardController: Get.put(
                        NewsCardController(),
                        tag: _dashboardController.newsList[index].title,
                      ),
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
