import 'package:cloud_firestore/cloud_firestore.dart';

class News {
  String title;

  News({
    this.title,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
      };

  factory News.fromQuerySnapshot(QueryDocumentSnapshot queryDocumentSnapshot) {
    if (queryDocumentSnapshot == null || !queryDocumentSnapshot.exists) {
      return News();
    }

    return News(
      title: queryDocumentSnapshot['title'],
    );
  }
}
