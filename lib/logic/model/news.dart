import 'package:cloud_firestore/cloud_firestore.dart';

class News {
  String author;
  String content;
  String description;
  String publishedAt;
  String name;
  String title;
  String url;
  String urlToImage;

  News({
    this.author,
    this.content,
    this.description,
    this.publishedAt,
    this.name,
    this.title,
    this.url,
    this.urlToImage,
  });
}
