import 'package:flutter/material.dart';
import 'package:medical_blog/presentation/widgets/bottom_nav_bar/bottom_navigation_bar.dart';
import 'package:get/get.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_text_field/input_text_field.dart';
import 'package:medical_blog/presentation/widgets/input_fields/input_text_field/input_text_field_controller.dart';
import 'package:medical_blog/utils/constants/routes.dart';
import 'package:pull_to_reveal/pull_to_reveal.dart';

class PostsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 50.0,
          left: 20.0,
          right: 20.0,
        ),
        child: Center(
          child: PullToRevealTopItemList(
            startRevealed: true,
            itemCount: 100,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                color: index % 2 == 0 ? Colors.cyan : Colors.yellow,
                child: Container(
                  height: 50,
                ),
              );
            },
            revealableHeight: 50,
            revealableBuilder: (BuildContext context, RevealableToggler opener,
                RevealableToggler closer, BoxConstraints constraints) {
              return Row(
                children: [
                  Flexible(
                    child: TextField(
                      textAlign: TextAlign.start,
                      readOnly: true,
                      controller: TextEditingController()
                        ..text = "Tell us something new...",
                      onTap: () => Get.toNamed(kAddPostRoute),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(6.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 1,
      ),
    );
  }
}
