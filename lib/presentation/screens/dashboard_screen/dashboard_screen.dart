import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medical_blog/presentation/screens/dashboard_screen/dashboard_controller.dart';
import 'package:medical_blog/presentation/screens/see_more_screen/see_more_controller.dart';
import 'package:medical_blog/presentation/screens/see_more_screen/see_more_screen.dart';
import 'package:medical_blog/presentation/widgets/bottom_nav_bar/bottom_navigation_bar.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_text_field_read_only/input_text_field_read_only.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_text_field_search.dart';
import 'package:medical_blog/presentation/widgets/news_card/news_card.dart';
import 'package:medical_blog/presentation/widgets/news_card/news_card_controller.dart';
import 'package:get/get.dart';
import 'package:medical_blog/utils/session_temp.dart';

class DashboardScreen extends StatelessWidget {
  final DashboardController _dashboardController =
      Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(
      //     80,
      //   ),
      //   child: SliverAppBar(
      //     title: Expanded(
      //         child:
      //     ),
      //   ),
      // ),
      body: CustomScrollView(
        controller: _dashboardController.scrollController.value,
        slivers: [
          SliverAppBar(
            floating: true,
            forceElevated: true,
            toolbarHeight: 80.0,
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
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
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Obx(
                  () => _dashboardController.searchedNews.length == 0
                      ? Padding(
                          padding: const EdgeInsets.all(
                            18.0,
                          ),
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
                                  child: GestureDetector(
                                    onTap: () => Get.to(
                                      () => SeeMoreScreen(
                                        title: 'Todays news',
                                        seeMoreController: Get.put(
                                          SeeMoreController(
                                            title: 'today',
                                          ),
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      'see more >',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                ),
              ],
            ),
          ),
          Obx(
            () => _dashboardController.searchedNews.length == 0
                ? SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 18.0,
                          ),
                          child: NewsCard(
                            news: _dashboardController.todayNewsList[index],
                            newsCardController: Get.put(
                              NewsCardController(
                                isSaved: _dashboardController
                                    .todayNewsList[index].savedBy
                                    .contains(
                                      userUID,
                                    )
                                    .obs,
                              ),
                              tag: _dashboardController
                                  .todayNewsList[index].title,
                            ),
                          ),
                        );
                      },
                      childCount: _dashboardController.todayNewsList.length,
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 18.0,
                          ),
                          child: NewsCard(
                            news: _dashboardController.searchedNews[index],
                            newsCardController: Get.put(
                              NewsCardController(
                                isSaved: _dashboardController
                                    .searchedNews[index].savedBy
                                    .contains(
                                      userUID,
                                    )
                                    .obs,
                              ),
                              tag: _dashboardController
                                  .searchedNews[index].title,
                            ),
                          ),
                        );
                      },
                      childCount: _dashboardController.searchedNews.length,
                    ),
                  ),
          ),
          Obx(
            () => _dashboardController.searchedNews.length == 0
                ? SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(
                            18.0,
                          ),
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
                                  child: GestureDetector(
                                    onTap: () => Get.to(
                                      () => SeeMoreScreen(
                                        title: 'Trending news',
                                        seeMoreController: Get.put(
                                          SeeMoreController(
                                            title: 'trending',
                                          ),
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      'see more >',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : SliverToBoxAdapter(),
          ),
          Obx(
            () => _dashboardController.searchedNews.length == 0
                ? SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 18.0,
                          ),
                          child: NewsCard(
                            news: _dashboardController.trendingNewsList[index],
                            newsCardController: Get.put(
                              NewsCardController(
                                  isSaved: _dashboardController
                                      .trendingNewsList[index].savedBy
                                      .contains(
                                        userUID,
                                      )
                                      .obs),
                              tag: _dashboardController
                                  .trendingNewsList[index].title,
                            ),
                          ),
                        );
                      },
                      childCount: _dashboardController.trendingNewsList.length,
                    ),
                  )
                : SliverToBoxAdapter(),
          ),
          Obx(
            () => _dashboardController.searchedNews.length == 0
                ? SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(
                            18.0,
                          ),
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
                  )
                : SliverToBoxAdapter(),
          ),
          Obx(
            () => _dashboardController.searchedNews.length == 0
                ? SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index ==
                            _dashboardController.newsList.value.length) {
                          return CupertinoActivityIndicator();
                        }
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 18.0,
                          ),
                          child: NewsCard(
                            news: _dashboardController.newsList[index],
                            newsCardController: Get.put(
                              NewsCardController(
                                  isSaved: _dashboardController
                                      .newsList[index].savedBy
                                      .contains(
                                        userUID,
                                      )
                                      .obs),
                              tag: _dashboardController.newsList[index].title,
                            ),
                          ),
                        );
                      },
                      childCount:
                          _dashboardController.newsList.value.length + 1,
                    ),
                  )
                : SliverToBoxAdapter(),
          ),
        ],
      ),
      bottomNavigationBar: Obx(
        () => AnimatedContainer(
          duration: Duration(
            milliseconds: 200,
          ),
          height: _dashboardController.isVisible.value ? 90 : 0.0,
          child: BottomNavBar(
            selectedIndex: 0,
            pressCallback: _dashboardController.getToTop,
          ),
        ),
      ),
    );
  }
}
