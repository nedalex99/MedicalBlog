import 'package:get/get.dart';
import 'package:medical_blog/utils/network/firestore_service.dart';

class DashboardController extends GetxController {
  FirestoreService _firestoreService = Get.find();

  @override
  Future<void> onInit() async {
    await getAllNews();
    super.onInit();
  }

  Future<void> getAllNews() async {
    await _firestoreService.getAllNews().then((value) => {
          value.docs.forEach((element) {
            print(element.data());
          }),
        });
  }
}
