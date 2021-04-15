import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_demo_livestream/bloc/news_bloc.dart';
import 'package:news_demo_livestream/models/newsInfo.dart';
import 'package:news_demo_livestream/pages/article_details.dart';

class AllNews extends StatefulWidget {
  static String tabName = 'All News';

  @override
  _AllNewsState createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  final _newsBloc = NewsBloc();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  Future<NewsModel> futureArticles;

  @override
  void initState() {
    super.initState();
    _newsBloc.newsEventSink.add(NewsAction.FETCH);
  }

  @override
  void dispose() {
    _newsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<NewsModel>(
        stream: _newsBloc.newsStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return RefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: _refresh,
                child: ListView.builder(
                    itemCount: snapshot.data.articles.length,
                    itemBuilder: (context, index) {
                      var article = snapshot.data.articles[index];
                      return _articleItem(article);
                    }));
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error));
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _articleTitle(Article article) {
    return Text(
      article.title,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  Widget _articleExcerpt(Article article) {
    return Text(
      article.description,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _articleItem(Article article) {
    var formattedTime =
        DateFormat('dd MMM - HH:mm').format(article.publishedAt);

    return InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return ArticleDetails(article: article);
          }));
        },
        child: Container(
          height: 100,
          padding: EdgeInsets.only(right: 15),
          margin: const EdgeInsets.all(8),
          child: Row(
            children: <Widget>[
              Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Hero(
                    tag: article.url,
                    child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.network(
                          article.urlToImage,
                          fit: BoxFit.cover,
                        ))),
              ),
              SizedBox(width: 16),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _articleTitle(article),
                    SizedBox(height: 5),
                    _articleExcerpt(article),
                    SizedBox(height: 5),
                    Text(formattedTime,
                        style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _newsBloc.newsEventSink.add(NewsAction.FETCH);
    });
  }
}
