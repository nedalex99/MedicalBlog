import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:medical_blog/utils/network/auth_service.dart';
import 'package:medical_blog/utils/network/firestore_service.dart';

class RegisterController extends GetxController {
  String email;
  String password;
  String firstName;
  String lastName;
  String country;

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
    print(email);
    print(password);
    _authService
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => {
              // _firestoreSerivce.createUser(
              //   uid: value.user.uid,
              //   email: email,
              //   firstName: firstName,
              //   lastName: lastName,
              //   country: country,
              // ),
            });
  }
}
