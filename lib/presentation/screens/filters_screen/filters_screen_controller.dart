import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:medical_blog/logic/model/Filter.dart';
import 'package:intl/intl.dart';

typedef ApplyFiltersCallback(Filter filter);

class FiltersScreenController extends GetxController {
  String startDate = "";
  String endDate = "";
  String category = "";
  ApplyFiltersCallback applyFiltersCallback;

  FiltersScreenController({
    this.applyFiltersCallback,
  });

  void startDateCallback(String value) {
    startDate = value;
  }

  void endDateCallback(String value) {
    endDate = value;
  }

  void categoryCallback(String value) {
    category = value;
  }

  void printFields() {
    print(startDate + " " + endDate + " " + category);
  }

  Future<void> applyFilters() async {
    DateTime startDate;
    DateTime endDate;
    if (this.startDate != "") {
      startDate = DateFormat("yyyy-MM-dd").parse(this.startDate);
    }
    if (this.endDate != "") {
      endDate = DateFormat("yyyy-MM-dd").parse(this.endDate);
    }
    await applyFiltersCallback(Filter(
        startDate: this.startDate != "" ? startDate.millisecondsSinceEpoch : 0,
        endDate: this.endDate != "" ? endDate.millisecondsSinceEpoch : 0,
        category: category));
  }
}
