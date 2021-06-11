import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_blog/presentation/screens/edit_account_screen/edit_account_controller.dart';
import 'package:medical_blog/presentation/widgets/acc_info_card/acc_info_card.dart';

class EditAccountScreen extends StatelessWidget {
  final EditAccountController _editAccountController =
      Get.put(EditAccountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.only(
              top: 50.0,
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Obx(
                    () => AccInfoCard(
                      userData: _editAccountController.userData.value,
                    ),
                  );
                },
                childCount: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
