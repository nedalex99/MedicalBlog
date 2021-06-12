import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_blog/presentation/screens/profile_screen/profile_screen_controller.dart';
import 'package:medical_blog/presentation/widgets/bottom_nav_bar/bottom_navigation_bar.dart';
import 'package:medical_blog/presentation/widgets/post_card/post_card.dart';
import 'package:medical_blog/presentation/widgets/post_card/post_card_controller.dart';
import 'package:medical_blog/utils/session_temp.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileScreenController _profileScreenController =
      Get.put(ProfileScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            forceElevated: true,
            backgroundColor: Colors.cyan,
            title: Text('Title'),
            leading: IconButton(
              icon: Icon(Icons.logout),
              onPressed: _profileScreenController.signOutUser,
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: Get.height * 0.2),
                child: Column(
                  children: [
                    Container(

                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(
                          () => Column(
                            children: [
                              Text(
                                _profileScreenController
                                    .userData.value.firstName,
                              ),
                              Text(
                                _profileScreenController
                                    .userData.value.lastName,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.05,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                          ),
                          onPressed:
                              _profileScreenController.redirectToEditAccount,
                        ),
                        SizedBox(
                          height: 200,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Obx(
            () => SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return PostCard(
                    post: _profileScreenController.posts[index],
                    postCardController: Get.put(
                      PostCardController(
                        post: _profileScreenController.posts[index],
                        postId: _profileScreenController.posts[index].uid,
                        noOfLikes:
                            _profileScreenController.posts[index].noOfLikes.obs,
                        noOfDislikes: _profileScreenController
                            .posts[index].noOfDislikes.obs,
                        noOfComments: _profileScreenController
                            .posts[index].noOfComments.obs,
                        isLiked: _profileScreenController.posts[index].likedBy
                                .contains(userUID)
                            ? true.obs
                            : false.obs,
                        isDisliked: _profileScreenController
                                .posts[index].dislikedBy
                                .contains(userUID)
                            ? true.obs
                            : false.obs,
                        isSaved: _profileScreenController.posts[index].savedBy
                                .contains(userUID)
                            ? true.obs
                            : false.obs,
                      ),
                      tag: _profileScreenController.posts[index].uid,
                    ),
                  );
                },
                childCount: _profileScreenController.posts.length,
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 3,
      ),
    );
  }
}
