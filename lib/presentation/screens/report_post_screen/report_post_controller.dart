import 'package:get/get.dart';
import 'package:medical_blog/model/report.dart';
import 'package:medical_blog/presentation/widgets/dialogs/loading_dialog.dart';
import 'package:medical_blog/presentation/widgets/dialogs/modal_info_error_dialog.dart';
import 'package:medical_blog/utils/network/firestore_service.dart';
import 'package:medical_blog/utils/session_temp.dart';

class ReportPostController extends GetxController {
  final FirestoreService _firestoreService = Get.find();

  List<String> reportList = [
    'Nudity',
    'Violence',
    'Harassment',
    'Suicide or self-injury',
    'False information',
    'Spam',
    'Unauthorised sales',
    'Hate speech',
    'Terrorism',
    'Something else',
  ];

  Future<void> reportPost({String postId, String reportReason}) async {
    Get.dialog(LoadingDialog());
    await _firestoreService
        .reportPost(
            postId: postId,
            report: Report(
              userId: userUID,
              reportReason: reportReason,
            ))
        .then((value) async => {
              await _firestoreService
                  .updatePointsForPost(postId: postId, points: -5.0)
                  .then((value) => {
                        Get.back(),
                        Get.back(),
                        Get.back(),
                        Get.dialog(
                          ModalErrorDialog(
                            errorText: 'Thank you for your report!',
                          ),
                        ),
                      }),
            });
  }
}
