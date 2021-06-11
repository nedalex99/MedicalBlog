import 'package:get/get.dart';
import 'package:medical_blog/model/user_data.dart';
import 'package:medical_blog/utils/network/firestore_service.dart';

class EditAccountController extends GetxController {
  FirestoreService _firestoreService = Get.find();

  Rx<UserData> userData = UserData(firstName: '').obs;
  List<UserInfo> userInfoList = [];


  @override
  void onInit() {
    getUserData();
    super.onInit();
  }

  Future<void> getUserData() async {
    _firestoreService.getUserData().then((value) =>
    {
      userData.value = UserData.fromJson(value),
    });
  }
}
