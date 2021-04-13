import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_demo_livestream/models/newsInfo.dart';
import 'package:news_demo_livestream/services/newsService.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final newsService = NewsService();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    new GlobalKey<RefreshIndicatorState>();
  Future<NewsModel> futureArticles;

  @override
  void initState() {
    super.initState();
    futureArticles = newsService.getNews();
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

    return Container(
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
            child: AspectRatio(
                aspectRatio: 1,
                child: Image.network(
                  article.urlToImage,
                  fit: BoxFit.cover,
                )),
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
                Text(formattedTime, style: TextStyle(color: Colors.grey[600])),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      futureArticles = newsService.getNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
      ),
      body: Container(
        child: FutureBuilder<NewsModel>(
          future: futureArticles,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return RefreshIndicator(
                onRefresh: _refresh,
                child: ListView.builder(
                  itemCount: snapshot.data.articles.length,
                  itemBuilder: (context, index) {
                    var article = snapshot.data.articles[index];
                    return _articleItem(article);
                  }
              )
              );
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error));
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
