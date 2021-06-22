import 'package:get/get.dart';

class UpdateAccountController extends GetxController {
  String name = '';

  UpdateAccountController({
    this.name,
  });

  void nameCallback(String value) {
    name = value;
  }
}
