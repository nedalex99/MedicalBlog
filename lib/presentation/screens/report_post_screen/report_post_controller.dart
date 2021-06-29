import 'package:get/get.dart';
import 'package:medical_blog/model/report.dart';
import 'package:medical_blog/presentation/widgets/dialogs/loading_dialog.dart';
import 'package:medical_blog/presentation/widgets/dialogs/modal_info_error_dialog.dart';
import 'package:medical_blog/utils/network/firestore_service.dart';
import 'package:medical_blog/utils/session_temp.dart';

typedef ReportPostCallback(Report value);
typedef ReportCommentCallback(Report value);

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

  Future<void> reportPost({
    String postId,
    String reportReason,
    Function reportPostCallback,
  }) async {
    Get.dialog(LoadingDialog());
    await _firestoreService
        .reportPost(
          postId: postId,
          report: Report(
            userId: userUID,
            reportReason: reportReason,
          ),
        )
        .then((value) async => {
              reportPostCallback(
                Report(
                  userId: userUID,
                  reportReason: reportReason,
                ),
              ),
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

  Future<void> reportComment({
    String postId,
    String commentId,
    String reportReason,
    Function reportCommentCallback,
  }) async {
    Get.dialog(LoadingDialog());
    await _firestoreService
        .reportComment(
            postId: postId,
            commentId: commentId,
            report: Report(
              userId: userUID,
              reportReason: reportReason,
            ))
        .then((value) async => {
              reportCommentCallback(
                Report(
                  userId: userUID,
                  reportReason: reportReason,
                ),
              ),
              await _firestoreService
                  .updatePointsForComment(
                    postId: postId,
                    commentId: commentId,
                    points: -5.0,
                  )
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
