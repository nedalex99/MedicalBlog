import 'package:flutter/material.dart';
import 'package:medical_blog/presentation/screens/filters_screen/filters_screen.dart';
import 'package:medical_blog/presentation/screens/filters_screen/filters_screen_controller.dart';
import 'package:medical_blog/presentation/screens/saved_screen/saved_screen_controller.dart';
import 'package:medical_blog/presentation/widgets/bottom_nav_bar/bottom_navigation_bar.dart';
import 'package:get/get.dart';
import 'package:medical_blog/presentation/widgets/news_card/news_card.dart';
import 'package:medical_blog/presentation/widgets/news_card/news_card_controller.dart';
import 'package:medical_blog/presentation/widgets/post_card/post_card.dart';
import 'package:medical_blog/presentation/widgets/post_card/post_card_controller.dart';
import 'package:medical_blog/utils/session_temp.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SavedScreen extends StatelessWidget {
  final SavedScreenController _savedScreenController =
      Get.put(SavedScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 75.0,
        ),
        child: CustomScrollView(
          controller: _savedScreenController.scrollController.value,
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 32.0,
                  left: 18.0,
                  right: 18.0,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Choose:',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Container(
                          child: ToggleSwitch(
                            minWidth: 90,
                            initialLabelIndex: 0,
                            cornerRadius: 20.0,
                            activeFgColor: Colors.white,
                            inactiveBgColor: Colors.grey,
                            inactiveFgColor: Colors.white,
                            labels: ['Posts', 'News'],
                            onToggle: _savedScreenController.onToggle,
                            totalSwitches: 2,
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Obx(
                        () => _savedScreenController.toggleIndex == 0
                            ? DropdownButton(
                                items: <String>[
                                  'Newest first',
                                  'Oldest first',
                                  'Most likes first',
                                  'Most dislikes first',
                                ]
                                    .map(
                                      (String e) => DropdownMenuItem(
                                        child: Text(e),
                                        value: e,
                                      ),
                                    )
                                    .toList(),
                                value:
                                    _savedScreenController.dropdownValue.value,
                                onChanged: (newValue) {
                                  _savedScreenController.setNewDropdownValue(
                                    value: newValue,
                                  );
                                },
                              )
                            : Container(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Obx(
              () => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    if (_savedScreenController.toggleIndex.value == 1) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 18.0,
                        ),
                        child: NewsCard(
                          news: _savedScreenController.newsList[index],
                          isInSavedScreen: true,
                          deleteNewsCallback:
                              _savedScreenController.removeNewsById,
                          newsCardController: Get.put(
                            NewsCardController(
                              isSaved:
                                  _savedScreenController.newsList[index].savedBy
                                      .contains(
                                        userUID,
                                      )
                                      .obs,
                            ),
                            tag: _savedScreenController.newsList[index].title,
                          ),
                        ),
                      );
                    } else {
                      return PostCard(
                        post: _savedScreenController.posts[index],
                        isInSavedScreen: true,
                        removeFromSaved:
                            _savedScreenController.removeWithPostId,
                        postCardController: Get.put(
                            PostCardController(
                              post: _savedScreenController.posts[index],
                              postId: _savedScreenController.posts[index].uid,
                              noOfLikes: _savedScreenController
                                  .posts[index].noOfLikes.obs,
                              noOfDislikes: _savedScreenController
                                  .posts[index].noOfDislikes.obs,
                              noOfComments: _savedScreenController
                                  .posts[index].noOfComments.obs,
                              isLiked: _savedScreenController
                                      .posts[index].likedBy
                                      .contains(userUID)
                                  ? true.obs
                                  : false.obs,
                              isDisliked: _savedScreenController
                                      .posts[index].dislikedBy
                                      .contains(userUID)
                                  ? true.obs
                                  : false.obs,
                              isSaved: true.obs,
                            ),
                            tag: _savedScreenController.posts[index].uid),
                      );
                    }
                  },
                  childCount: _savedScreenController.toggleIndex.value == 1
                      ? _savedScreenController.newsList.length
                      : _savedScreenController.posts.length,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => AnimatedContainer(
          duration: Duration(
            milliseconds: 200,
          ),
          height: _savedScreenController.isVisible.value ? 55 : 0.0,
          child: BottomNavBar(
            selectedIndex: 2,
          ),
        ),
      ),
    );
  }
}
