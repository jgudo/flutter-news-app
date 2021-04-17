import 'package:flutter/material.dart';
import 'package:news_demo_livestream/models/news_source.dart';
import 'package:news_demo_livestream/services/news_service.dart';

class DropDownSources extends StatefulWidget {
  @override
  _DropDownSourcesState createState() => _DropDownSourcesState();
}

class _DropDownSourcesState extends State<DropDownSources> {
  String _chosenValue;
  final newsService = NewsService();
  Future<List<NewsSource>> _sources;

  @override
  void initState() {
    _sources = newsService.getSources();
    super.initState();
  }

  TextStyle _itemTextStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.red[600]),
        child: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Colors.red.shade600,
            ),
            child: FutureBuilder<List<NewsSource>>(
              future: _sources,
              builder: (context, snapshot) {
                if (snapshot.hasError) return Text('Error');

                if (snapshot.hasData) {
                  return DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                    value: _chosenValue,
                    //elevation: 5,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    iconEnabledColor: Colors.white,
                    iconDisabledColor: Colors.white,
                    items: snapshot.data.map((el) {
                      return DropdownMenuItem(
                          child: Text(el.name,
                              overflow: TextOverflow.ellipsis,
                              style: _itemTextStyle),
                          value: el.url);
                    }).toList(),
                    hint: Text(
                      "Select Source",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        _chosenValue = value;
                      });
                    },
                  ));
                }

                return SizedBox(
                    height: 20,
                    child: Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ),
                    ));
              },
            )),
      ),
    );
  }
}
