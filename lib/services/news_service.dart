import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:news_demo_livestream/constants/strings.dart';
import 'package:news_demo_livestream/models/newsInfo.dart';
import 'package:news_demo_livestream/models/news_source.dart';

// ignore: camel_case_types
class NewsService {
  Future<NewsModel> getNews() async {
    NewsModel newsModel;

    try {
      var response = await http.get(Uri.parse(Strings.newsUrl));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        newsModel = NewsModel.fromJson(jsonMap);
      }
    } on SocketException catch (err) {
      print(err);
    } catch (Exception) {
      return newsModel;
    }

    return newsModel;
  }

  Future<List<NewsSource>> getSources() async {
    List<NewsSource> sources = [];

    try {
      print('CALLEDD -------------------');
      var response = await http.get(Uri.parse(Strings.newsSourceUrl));
      if (response.statusCode == 200) {
        var jsonMap = json.decode(response.body)['sources'] as List;

        for (var el in jsonMap) {
          NewsSource source = NewsSource.fromJson(el);
          sources.add(source);
        }
      }
    } on SocketException catch (err) {
      print('ERRR----- $err');
    } catch (err) {
      print('ERR -----------');
      return sources;
    }

    return sources;
  }
}
