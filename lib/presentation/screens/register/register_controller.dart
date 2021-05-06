import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_blog/presentation/widgets/dialogs/loading_dialog.dart';
import 'package:medical_blog/utils/constants/colors.dart';
import 'package:medical_blog/utils/network/auth_service.dart';
import 'package:medical_blog/utils/network/firestore_service.dart';

class RegisterController extends GetxController {
  String email = "";
  String password = "";
  String firstName = "";
  String lastName = "";
  String country = "";
  String dateOfBirth = "";
  Rx<Color> buttonColor = kInactiveBlueButtonColor.obs;
  AuthService _authService = Get.find();
  FirestoreService _firestoreSerivce = Get.find();

  void emailCallback(String value) {
    email = value;
    setButtonColor();
  }

  void passwordCallback(String value) {
    password = value;
    setButtonColor();
  }

  void firstNameCallback(String value) {
    firstName = value;
    setButtonColor();
  }

  void lastNameCallback(String value) {
    lastName = value;
    setButtonColor();
  }

  void countryCallback(String value) {
    country = value;
    setButtonColor();
  }

  void dateOfBirthCallback(String value) {
    dateOfBirth = value;
  }

  void setButtonColor() {
    if (email != "" &&
        password != "" &&
        firstName != "" &&
        lastName != "" &&
        country != "" &&
        dateOfBirth != "") {
      buttonColor.value = kBlueButtonColor;
    } else {
      buttonColor.value = kInactiveBlueButtonColor;
    }
  }

  void registerUser() {
    Get.dialog(LoadingDialog());

    _authService
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((valueUser) => {
              if (valueUser.user != null)
                {
                  valueUser.user.sendEmailVerification().then((value) => {
                        _firestoreSerivce
                            .createUser(
                                uid: valueUser.user.uid,
                                email: email,
                                firstName: firstName,
                                lastName: lastName,
                                country: country)
                            .then((value) => {
                                  Get.back(),
                                }),
                      }),
                }
            });
  }
}
