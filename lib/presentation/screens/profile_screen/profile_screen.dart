import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_blog/presentation/screens/profile_screen/profile_screen_controller.dart';
import 'package:medical_blog/presentation/widgets/bottom_nav_bar/bottom_navigation_bar.dart';
import 'package:medical_blog/presentation/widgets/post_card/post_card.dart';
import 'package:medical_blog/presentation/widgets/post_card/post_card_controller.dart';
import 'package:medical_blog/utils/constants/colors.dart';
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
            backgroundColor: kBackgroundColor,
            title: Text(
              'Profile',
              style: TextStyle(
                color: kTextBlack1C,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.logout,
                  color: kTextBlack1C,
                ),
                onPressed: _profileScreenController.signOutUser,
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: Get.height * 0.2),
                child: Column(
                  children: [
                    Container(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(
                          () => Column(
                            children: [
                              GestureDetector(
                                onTap: () => _profileScreenController
                                    .showPicker(context),
                                child: CircleAvatar(
                                  radius: 55,
                                  backgroundColor: kBlueButtonColor,
                                  child: _profileScreenController.img.value !=
                                          ""
                                      ? ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            50.0,
                                          ),
                                          child: Image.network(
                                            _profileScreenController.img.value,
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.fill,
                                          ),
                                        )
                                      : Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: BorderRadius.circular(
                                              50.0,
                                            ),
                                          ),
                                          width: 100,
                                          height: 100,
                                          child: Icon(
                                            Icons.camera_alt,
                                            color: Colors.grey[800],
                                          ),
                                        ),
                                ),
                              ),
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18.0,
                        ),
                        child: Text(
                          'Your posts',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24.0,
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
      bottomNavigationBar: Container(
        height: 80,
        child: BottomNavBar(
          selectedIndex: 3,
        ),
      ),
    );
  }
}
