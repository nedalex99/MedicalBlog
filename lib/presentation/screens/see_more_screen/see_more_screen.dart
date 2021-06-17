import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medical_blog/presentation/screens/see_more_screen/see_more_controller.dart';
import 'package:medical_blog/presentation/widgets/appbar/appbar.dart';
import 'package:medical_blog/presentation/widgets/news_card/news_card.dart';
import 'package:medical_blog/presentation/widgets/news_card/news_card_controller.dart';
import 'package:medical_blog/utils/session_temp.dart';
import 'package:get/get.dart';

class SeeMoreScreen extends StatelessWidget {
  final String title;
  final SeeMoreController seeMoreController;

  SeeMoreScreen({
    this.title,
    this.seeMoreController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppBar(
          title: title,
        ),
      ),
      body: CustomScrollView(
        controller: seeMoreController.scrollController.value,
        slivers: [
          Obx(
            () => SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == seeMoreController.newsList.value.length) {
                    return CupertinoActivityIndicator();
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: NewsCard(
                      news: seeMoreController.newsList[index],
                      newsCardController: Get.put(
                        NewsCardController(
                          isSaved: seeMoreController.newsList[index].savedBy
                              .contains(
                                userUID,
                              )
                              .obs,
                        ),
                        tag: seeMoreController.newsList[index].title,
                      ),
                    ),
                  );
                },
                childCount: seeMoreController.newsList.value.length + 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
