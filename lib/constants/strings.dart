import 'package:news_demo_livestream/constants/secrets.dart';

final String _baseUrl = 'https://newsapi.org/v2';

class Strings {
  static String newsUrl =
      '$_baseUrl/everything?domains=bbc.co.uk&apiKey=${Secrets.apiKey}';
  static String newsSourceUrl = '$_baseUrl/sources?apiKey=${Secrets.apiKey}';
}
