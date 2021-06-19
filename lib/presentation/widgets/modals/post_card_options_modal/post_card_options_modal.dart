import 'package:flutter/material.dart';
import 'package:medical_blog/model/post.dart';
import 'package:medical_blog/presentation/screens/report_post_screen/report_post_screen.dart';
import 'package:medical_blog/presentation/widgets/modals/post_card_options_modal/post_card_options_modal_controller.dart';
import 'package:get/get.dart';

class PostCardOptionsModal extends StatelessWidget {
  final PostCardOptionsModalController controller;

  final Post post;
  final String postId;

  PostCardOptionsModal({this.post, this.postId, this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(
              controller.isSaved.value ? Icons.bookmark : Icons.bookmark_border,
            ),
            title: Text(
              controller.isSaved.value ? 'Unsave this post' : 'Save this post',
            ),
            onTap: () => controller.saveThisPost(post: post, postId: postId),
          ),
          ListTile(
            leading: Icon(
              Icons.close,
            ),
            title: Text(
              'Hide this post',
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.report,
            ),
            title: Text(
              'Report this post',
            ),
            onTap: () => Get.to(
              () => ReportPostScreen(
                postId: postId,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
