import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_demo_livestream/models/newsInfo.dart';

class ArticleDetails extends StatelessWidget {
  final Article article;

  ArticleDetails({@required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('View Article')),
        body: Container(
            padding: EdgeInsets.all(15),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(height: 40),
              Text(article.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text(DateFormat('dd MMM - HH:mm').format(article.publishedAt),
                  style: TextStyle(
                    color: Colors.grey[700],
                  )),
              SizedBox(height: 20),
              Hero(
                  tag: article.url,
                  child: Container(
                      height: 200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(article.urlToImage,
                            fit: BoxFit.cover),
                      ))),
              SizedBox(height: 20),
              Text(article.content,
                  style: TextStyle(fontSize: 15, color: Colors.grey[800]))
            ])));
  }
}
