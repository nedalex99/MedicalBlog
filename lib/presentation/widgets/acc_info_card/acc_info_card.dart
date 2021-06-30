import 'package:flutter/material.dart';
import 'package:medical_blog/model/user_info.dart';
import 'package:medical_blog/presentation/screens/update_account_screen/update_account_controller.dart';
import 'package:medical_blog/presentation/screens/update_account_screen/update_account_screen.dart';
import 'package:get/get.dart';
import 'package:medical_blog/utils/constants/colors.dart';

class AccInfoCard extends StatelessWidget {
  final Rx<UserInfo> userData;

  AccInfoCard({
    this.userData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Wrap(
        children: [
          Container(
            padding: EdgeInsets.all(
              15.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  6.0,
                ),
              ),
            ),
            child: Row(
              children: [
                userData.value.icon,
                SizedBox(
                  width: 10.0,
                ),
                Obx(
                  () => Text(
                    userData.value.name,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => Get.to(
                        UpdateAccountScreen(
                          userInfo: userData.value,
                          controller: Get.put(
                            UpdateAccountController(
                              name: userData.value.name,
                            ),
                          ),
                        ),
                      ),
                      child: Text(
                        'edit',
                        style: TextStyle(
                          color: kBlueButtonColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
