import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_blog/presentation/screens/edit_account_screen/edit_account_controller.dart';
import 'package:medical_blog/presentation/widgets/acc_info_card/acc_info_card.dart';
import 'package:medical_blog/presentation/widgets/appbar/appbar.dart';

class EditAccountScreen extends StatelessWidget {
  final EditAccountController _editAccountController =
      Get.put(EditAccountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
          80,
        ),
        child: CustomAppBar(
          title: 'Edit profile',
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.only(
              top: 50.0,
            ),
            sliver: Obx(
              () => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Obx(
                      () => AccInfoCard(
                        userData: _editAccountController.userInfoList[index],
                      ),
                    );
                  },
                  childCount: _editAccountController.userInfoList.length,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
