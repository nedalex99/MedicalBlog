import 'package:get/get.dart';

class AddCommentsController extends GetxController {
  String commentText;

  void commentTextCallback(String value){
    commentText = value;
  }
}
