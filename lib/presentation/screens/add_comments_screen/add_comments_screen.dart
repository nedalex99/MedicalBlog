import 'package:flutter/material.dart';
import 'package:medical_blog/logic/model/post.dart';
import 'package:medical_blog/presentation/widgets/post_card/post_card.dart';
import 'package:medical_blog/presentation/widgets/post_card/post_card_controller.dart';

class AddCommentsScreen extends StatelessWidget {
  final Post post;
  final PostCardController postCardController;

  AddCommentsScreen({
    this.post,
    this.postCardController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          PostCard(
            post: post,
            postCardController: postCardController,
          ),
        ],
      ),
    );
  }
}
