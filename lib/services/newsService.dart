import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_demo_livestream/constants/strings.dart';
import 'package:news_demo_livestream/models/newsInfo.dart';

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
}
