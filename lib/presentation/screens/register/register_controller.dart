import 'package:get/get.dart';
import 'package:medical_blog/presentation/widgets/dialogs/loading_dialog.dart';
import 'package:medical_blog/utils/network/auth_service.dart';
import 'package:medical_blog/utils/network/firestore_service.dart';

class RegisterController extends GetxController {
  String email = "";
  String password = "";
  String firstName = "";
  String lastName = "";
  String country = "";

  AuthService _authService = Get.find();
  FirestoreService _firestoreSerivce = Get.find();

  void emailCallback(String value) {
    email = value;
  }

  void passwordCallback(String value) {
    password = value;
  }

  void firstNameCallback(String value) {
    firstName = value;
  }

  void lastNameCallback(String value) {
    lastName = value;
  }

  void countryCallback(String value) {
    country = value;
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
