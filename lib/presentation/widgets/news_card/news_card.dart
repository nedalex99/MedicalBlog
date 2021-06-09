import 'package:flutter/material.dart';
import 'package:medical_blog/model/news.dart';
import 'package:medical_blog/presentation/widgets/news_card/news_card_controller.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class NewsCard extends StatelessWidget {
  final NewsCardController newsCardController;
  final News news;

  NewsCard({
    this.news,
    this.newsCardController,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0xFFe6e6e6),
                spreadRadius: 2,
                blurRadius: 10,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              news.urlToImage != null
                  ? Container(
                      padding: EdgeInsets.all(
                        16.0,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        child: Image.network(
                          news.urlToImage,
                          height: 150,
                          fit: BoxFit.fill,
                        ),
                      ),
                    )
                  : Container(),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: Text(
                    news.title,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: 16.0,
                ),
                child: Text(
                  news.content != null
                      ? news.content
                      : news.description != null
                          ? news.description
                          : "",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(
                  16.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          news.sourceName != null ? news.sourceName : 'Unknown',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 2.0,
                        ),
                        Text(
                          DateFormat("yyyy-MM-dd")
                              .format(
                                DateTime.fromMillisecondsSinceEpoch(
                                  int.tryParse(
                                    news.publishedAt,
                                  ),
                                ),
                              )
                              .toString(),
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        children: [
                          IconButton(
                            icon: Obx(
                              () => Icon(
                                newsCardController.isSaved.value
                                    ? Icons.bookmark
                                    : Icons.bookmark_border_outlined,
                              ),
                            ),
                            onPressed: () =>
                                newsCardController.onSaveIconClick(news: news),
                          ),
                          IconButton(
                            icon: Icon(Icons.share),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
