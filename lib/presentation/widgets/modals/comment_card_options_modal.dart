import 'package:flutter/material.dart';
import 'package:medical_blog/model/comment.dart';
import 'package:get/get.dart';
import 'package:medical_blog/presentation/screens/report_post_screen/report_post_screen.dart';

class CommentCardOptionsModal extends StatelessWidget {
  final Comment comment;
  final String commentId;
  final String postId;
  final bool alreadyReported;

  CommentCardOptionsModal({
    this.comment,
    this.commentId,
    this.postId,
    this.alreadyReported,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(
              Icons.report,
            ),
            title: Text(
              !alreadyReported
                  ? 'Report this post'
                  : 'You already reported this post!',
            ),
            onTap: !alreadyReported
                ? () => Get.to(
                      () => ReportPostScreen(
                        postId: postId,
                        isComment: true,
                        commentId: commentId,
                      ),
                    )
                : () {},
          ),
        ],
      ),
    );
  }
}
