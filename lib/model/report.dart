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

  factory Report.fromJson(DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.data() == null || (documentSnapshot.data() as Map).isEmpty) {
      return Report();
    }

    return Report(
      userId: (documentSnapshot.data() as Map)['userId'],
      reportReason: (documentSnapshot.data() as Map)['reportReason'],
    );
  }
}
