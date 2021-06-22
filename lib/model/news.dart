import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medical_blog/utils/util_functions.dart';

class News {
  String id;
  String author;
  String content;
  String description;
  String publishedAt;
  String sourceName;
  String title;
  String url;
  String urlToImage;
  List<String> savedBy;

  News({
    this.id,
    this.author,
    this.content,
    this.description,
    this.publishedAt,
    this.sourceName,
    this.title,
    this.url,
    this.urlToImage,
    this.savedBy = const [],
  });

  factory News.fromJson(DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.data() == null ||
        (documentSnapshot.data() as Map).isEmpty) {
      return News();
    }

    return News(
      id: documentSnapshot.id,
      author: (documentSnapshot.data() as Map)['author'],
      content: (documentSnapshot.data() as Map)['content'],
      description: (documentSnapshot.data() as Map)['description'],
      sourceName: (documentSnapshot.data() as Map)['name'],
      title: (documentSnapshot.data() as Map)['title'],
      publishedAt: (documentSnapshot.data() as Map)['publishedAt'],
      url: (documentSnapshot.data() as Map)['url'],
      urlToImage: (documentSnapshot.data() as Map)['urlToImage'],
      savedBy: ((documentSnapshot.data() as Map)['savedBy'] as List)
          .map((e) => e.toString())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'author': author,
        'content': content,
        'description': description,
        'publishedAt': publishedAt,
        'sourceName': sourceName,
        'title': title,
        'url': url,
        'urlToImage': urlToImage,
        'caseSearch': getWordsToSearch(text: title),
        'savedBy': savedBy,
      };
}
