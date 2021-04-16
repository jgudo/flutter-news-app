import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_demo_livestream/constants/strings.dart';
import 'package:news_demo_livestream/models/newsInfo.dart';
import 'package:news_demo_livestream/models/news_source.dart';

// ignore: camel_case_types
class NewsService {
  Future<NewsModel> getNews() async {
    var newsModel;

    try {
      print('CALLEDD -------------------');
      var response = await http.get(Uri.parse(Strings.newsUrl));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        print(jsonMap['articles']);
        newsModel = NewsModel.fromJson(jsonMap);
      }
    } catch (Exception) {
      return newsModel;
    }

    return newsModel;
  }

  Future<List<NewsSource>> getSources() async {
    List<NewsSource> sources;

    try {
      print('CALLEDD -------------------');
      var response = await http.get(Uri.parse(Strings.newsSourceUrl));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString)['sources'];

        for (var el in jsonMap) {
          NewsSource source = NewsSource.fromJson(el);
          sources.add(source);
        }
      }
    } catch (Exception) {
      return sources;
    }

    return sources;
  }
}
