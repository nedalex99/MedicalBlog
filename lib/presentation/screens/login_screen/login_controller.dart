import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medical_blog/main.dart';
import 'package:medical_blog/presentation/widgets/dialogs/loading_dialog.dart';
import 'package:medical_blog/utils/constants/routes.dart';
import 'package:medical_blog/utils/constants/strings.dart';
import 'package:medical_blog/utils/network/auth_service.dart';

class LoginController extends GetxController {
  AuthService _firebaseAuthService = Get.find();

  String email = "";
  String password = "";

  void emailCallback(String value) {
    email = value;
  }

  void passwordCallback(String value) {
    password = value;
  }

  Future<void> loginUser() async {
    Get.dialog(LoadingDialog());
    try {
      await _firebaseAuthService
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
            (value) => {
              if (value.user != null)
                {
                  Get.back(),
                  Get.offAllNamed(kDashboardRoute),
                },
            },
          );
    } on FirebaseAuthException catch (e) {}
  }
}
