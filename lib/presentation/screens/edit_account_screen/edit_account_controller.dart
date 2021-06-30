import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_blog/model/user_data.dart';
import 'package:medical_blog/model/user_info.dart';
import 'package:medical_blog/presentation/widgets/dialogs/loading_dialog.dart';
import 'package:medical_blog/utils/network/auth_service.dart';
import 'package:medical_blog/utils/network/firestore_service.dart';

class EditAccountController extends GetxController {
  FirestoreService _firestoreService = Get.find();
  AuthService _authService = Get.find();

  Rx<UserData> userData = UserData(firstName: '').obs;
  RxList<UserInfo> userInfoList = List<UserInfo>().obs;

  @override
  void onInit() {
    getUserData();
    super.onInit();
  }

  Future<void> getUserData() async {
    await _firestoreService.getUserData().then((value) => {
          userData.value = UserData.fromJson(value),
          userInfoList.add(
            UserInfo(
              name: userData.value.firstName + " " + userData.value.lastName,
              hint: 'First Name',
              icon: Icon(
                Icons.person,
              ),
              function: () {},
            ),
          ),
          userInfoList.add(
            UserInfo(
              name: userData.value.email,
              hint: 'Email',
              icon: Icon(
                Icons.mail,
              ),
              function: updateEmail,
            ),
          ),
          userInfoList.add(
            UserInfo(
              name: userData.value.country,
              hint: 'Country',
              icon: Icon(
                Icons.public,
              ),
              function: updateCountry,
            ),
          ),
          userInfoList.add(
            UserInfo(
              name: userData.value.profession,
              hint: 'Profession',
              icon: Icon(
                Icons.work,
              ),
              function: updateProfession,
            ),
          ),
          userInfoList.add(
            UserInfo(
              name: userData.value.specialty,
              hint: 'Specialty',
              icon: Icon(
                Icons.domain,
              ),
              function: updateSpecialty,
            ),
          ),
          userInfoList.add(
            UserInfo(
              name: userData.value.yearsOfExperience.toString(),
              hint: 'Years Of Experience',
              icon: Icon(
                Icons.date_range,
              ),
              function: updateYearsOfExperience,
            ),
          ),
        });
  }

  Future<void> updateProfession(String profession) async {
    Get.dialog(LoadingDialog());
    await _firestoreService
        .updateProfession(profession: profession)
        .then((value) => {
              userData.value.profession = profession,
              userInfoList[1].name = profession,
              Get.back(),
              Get.back(),
            });
  }

  Future<void> updateEmail(String email) async {
    Get.dialog(LoadingDialog());
    await _authService.updateEmail(email: email).then((value) async => {
          await _firestoreService.updateEmail(email: email).then((value) => {
                userData.value.email = email,
                Get.back(),
                Get.back(),
              }),
        });
  }

  Future<void> updateCountry(String country) async {
    Get.dialog(LoadingDialog());
    await _firestoreService.updateCountry(country: country).then((value) => {
          Get.back(),
          Get.back(),
        });
  }

  Future<void> updateSpecialty(String specialty) async {
    Get.dialog(LoadingDialog());
    await _firestoreService
        .updateSpecialty(specialty: specialty)
        .then((value) => {
              Get.back(),
              Get.back(),
            });
  }

  Future<void> updateYearsOfExperience(String yearsOfExperience) async {
    Get.dialog(LoadingDialog());
    await _firestoreService
        .updateYearsOfExperience(
            yearsOfExperience: int.tryParse(yearsOfExperience))
        .then((value) => {
              Get.back(),
              Get.back(),
            });
  }
}
