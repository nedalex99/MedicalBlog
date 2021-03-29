import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  String email;
  String password;
  String firstName;
  String lastName;
  String country;

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
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }
}
