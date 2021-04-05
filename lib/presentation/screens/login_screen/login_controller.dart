import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:medical_blog/presentation/widgets/dialogs/loading_dialog.dart';
import 'package:medical_blog/utils/constants/colors.dart';
import 'package:medical_blog/utils/constants/routes.dart';
import 'package:medical_blog/utils/constants/strings.dart';
import 'package:medical_blog/utils/network/auth_service.dart';
import 'package:medical_blog/utils/user_preferences.dart';

class LoginController extends GetxController {
  AuthService _firebaseAuthService = Get.find();

  String email = "";
  String password = "";
  RxBool isButtonEnabled = false.obs;
  RxInt buttonColor = kInactiveBlueButtonColorHex.obs;
  RxBool checkboxValue = false.obs;

  PreferencesUtils _preferencesUtils = Get.find();

  void emailCallback(String value) {
    email = value;
    setButtonColor();
  }

  void passwordCallback(String value) {
    password = value;
    setButtonColor();
  }

  void updateCheckbox() {
    checkboxValue.toggle();
  }

  void setButtonColor() {
    if (email != "" && password != "") {
      isButtonEnabled.value = true;
      buttonColor.value = kBlueButtonColorHex;
    } else {
      isButtonEnabled.value = false;
      buttonColor.value = kInactiveBlueButtonColorHex;
    }
  }

  Future<void> loginUser() async {
    Get.dialog(LoadingDialog());
    try {
      await _firebaseAuthService
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
            (value) async => {
              if (value.user != null)
                {
                  if (checkboxValue.value)
                    {
                      await _preferencesUtils.setKeepMeAuthFlag(
                          kKeepMeAuthFlag, true),
                    },
                  Get.back(),
                  Get.offAllNamed(kDashboardRoute),
                },
            },
          );
    } on FirebaseAuthException catch (e) {}
  }
}
