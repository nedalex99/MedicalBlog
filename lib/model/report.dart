import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  String userId;
  String reportReason;

  Report({
    this.userId,
    this.reportReason,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'reportReason': reportReason,
      };

  factory Report.fromJson(Map<String, Object> documentSnapshot) {
    if (documentSnapshot == null || documentSnapshot.isEmpty) {
      return Report();
    }

    return Report(
      userId: documentSnapshot['userId'],
      reportReason: documentSnapshot['reportReason'],
    );
  }
}
