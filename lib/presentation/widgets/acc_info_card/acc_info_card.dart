import 'package:flutter/material.dart';
import 'package:medical_blog/model/user_info.dart';
import 'package:medical_blog/presentation/screens/update_account_screen/update_account_controller.dart';
import 'package:medical_blog/presentation/screens/update_account_screen/update_account_screen.dart';
import 'package:get/get.dart';

class AccInfoCard extends StatelessWidget {
  final UserInfo userData;

  AccInfoCard({
    this.userData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Wrap(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  6.0,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  userData.icon,
                  Text(
                    userData.name,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () => Get.to(
                          UpdateAccountScreen(
                            userInfo: userData,
                            controller: Get.put(
                              UpdateAccountController(
                                name: userData.name,
                              ),
                            ),
                          ),
                        ),
                        child: Text(
                          'edit',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
