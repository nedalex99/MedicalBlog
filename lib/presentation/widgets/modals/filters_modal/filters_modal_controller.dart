import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medical_blog/utils/util_functions.dart';

class FiltersModalController extends GetxController {
  String startDate = "";
  String endDate = "";
  String category = "";
  String author = "";



  void startDateCallback(String value) {
    startDate = value;
  }

  void endDateCallback(String value) {
    endDate = value;
  }


}
