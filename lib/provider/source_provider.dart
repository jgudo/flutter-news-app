import 'package:flutter/foundation.dart';

class SourceProvider extends ChangeNotifier {
  String _source = 'bbc.co.uk';

  String get source => _source;

  set source(String src) {
    _source = src;
    notifyListeners();
  }
}
