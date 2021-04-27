import 'package:get/get.dart';

class FiltersModalController extends GetxController {
  String startDate = "";
  String endDate = "";
  String category = "";
  String author = "";

  void startDateCallback(String value) {
    startDate = value;
  }

  void endDateCallback(String value){
    endDate = value;
  }
}
