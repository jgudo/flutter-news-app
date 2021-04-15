import 'dart:async';

import 'package:news_demo_livestream/models/newsInfo.dart';
import 'package:news_demo_livestream/services/newsService.dart';

enum NewsAction {
  FETCH
}

class NewsBloc {
  final _newsService = NewsService();

  StreamController<NewsModel> _newsStreamController = StreamController.broadcast();
  StreamSink<NewsModel> get _newsSink => _newsStreamController.sink;
  Stream<NewsModel> get newsStream => _newsStreamController.stream;

  StreamController _newsEventStreamController = StreamController();
  StreamSink get newsEventSink => _newsEventStreamController.sink;
  Stream get _newsEventStream => _newsEventStreamController.stream;

  NewsBloc() {
    _newsEventStream.listen((event) async {
      switch (event) {
        case NewsAction.FETCH: {
          try {
            var news =  await _newsService.getNews();
            _newsSink.add(news);
          } catch(err) {
            _newsSink.addError(err);
          }
        }
      }
    });
  }

  void dispose() {
    _newsStreamController.close();
    _newsEventStreamController.close();
  }
}