import 'package:flutter/material.dart';
import 'package:news_demo_livestream/bloc/news_bloc.dart';
import 'package:news_demo_livestream/pages/homepage.dart';
import 'package:news_demo_livestream/provider/source_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    Provider(create: (context) => SourceProvider()),
    ProxyProvider<SourceProvider, NewsBloc>(update: (BuildContext context, SourceProvider src, NewsBloc news) => NewsBloc(src.source))
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: TextTheme(
            bodyText1: TextStyle(fontSize: 16.0),
          )),
      home: HomePage(),
    );
  }
}
