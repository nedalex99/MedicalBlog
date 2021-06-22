import 'package:get/get.dart';
import 'package:medical_blog/presentation/screens/login_screen/login_screen.dart';
import 'package:medical_blog/presentation/widgets/dialogs/loading_dialog.dart';
import 'package:medical_blog/utils/network/firestore_service.dart';

class RegisterProfessionController extends GetxController {
  RxString profession = ''.obs;
  RxString specialty = ''.obs;
  RxString yearOfGraduation = ''.obs;

  final FirestoreService _firestoreService = Get.find();

  void updateProfessionCallback(String value) {
    profession.value = value;
  }

  void updateSpecialtyCallback(String value) {
    specialty.value = value;
  }

  void updateYearOfGraduationCallback(String value) {
    yearOfGraduation.value = value;
  }

  Future<void> updateUserProfile({
    String uid,
  }) async {
    Get.dialog(LoadingDialog());
    await _firestoreService
        .updateProfessionForUser(
          uid: uid,
          profession: profession.value,
          specialty: specialty.value,
          yearsOfExperience: yearOfGraduation.value,
        )
        .then((value) => {
              Get.back(),
              Get.offAll(() => LoginScreen()),
            });
  }
}
