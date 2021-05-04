import 'dart:convert';

import 'package:medical_blog/logic/model/news.dart';
import 'package:medical_blog/utils/constants/strings.dart';
import 'package:http/http.dart' as http;

class GetNewsRequest {
  static Future<GetNewsRequest> get _instance async =>
      _getNewsInstance ??= GetNewsRequest();
  static GetNewsRequest _getNewsInstance;

  static Future<GetNewsRequest> init() async {
    if (_getNewsInstance == null) _getNewsInstance = await _instance;
    return _getNewsInstance;
  }

  Future<List<News>> getNews(String country) async {
    final String _uri =
        "https://newsapi.org/v2/top-headlines?country=$country&apiKey=$api_key";
    try {
      final http.Response response = await http.get(Uri.parse(_uri));
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        return (json['articles'] as List)
            .map(
              (e) => News(
                name: e['source']['name'],
                author: e['author'],
                title: e['title'],
                description: e['description'],
                url: e['url'],
                urlToImage: e['urlToImage'],
                publishedAt: e['publishedAt'],
                content: e['content'],
              ),
            )
            .toList(growable: true);
      }
    } catch (e) {}
  }
}
