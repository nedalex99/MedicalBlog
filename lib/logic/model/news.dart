import 'package:cloud_firestore/cloud_firestore.dart';

class News {
  String author;
  String content;
  String description;
  String publishedAt;
  String sourceName;
  String title;
  String url;
  String urlToImage;

  News({
    this.author,
    this.content,
    this.description,
    this.publishedAt,
    this.sourceName,
    this.title,
    this.url,
    this.urlToImage,
  });

  Map<String, dynamic> toJson() => {
    'author': author,
    'content': content,
    'description': description,
    'publishedAt': publishedAt,
    'sourceName': sourceName,
    'title': title,
    'url': url,
    'urlToImage': urlToImage,
  };

}
