import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_blog/presentation/screens/report_post_screen/report_post_controller.dart';

class ReportPostScreen extends StatelessWidget {
  final ReportPostController _controller = Get.put(ReportPostController());

  final String postId;

  ReportPostScreen({
    this.postId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                top: Get.height * 0.08,
                left: 18.0,
                right: 18.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Please select a problem',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'If something about this post seems not all right, please report this post!',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  )
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ListTile(
                  title: Text(
                    _controller.reportList[index],
                  ),
                  trailing: Icon(
                    Icons.navigate_next,
                  ),
                  onTap: () => _controller.reportPost(
                    postId: postId,
                    reportReason: _controller.reportList[index],
                  ),
                );
              },
              childCount: _controller.reportList.length,
            ),
          ),
        ],
      ),
    );
  }
}
