import 'package:flutter/material.dart';
import 'package:news_demo_livestream/pages/all_news.dart';
import 'package:news_demo_livestream/widgets/drop_down_sources.dart';
import 'package:news_demo_livestream/widgets/nav_drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
                title: Text(_index == 0 ? AllNews.tabName : 'Top Headlines'),
                actions: [
                  IconButton(icon: Icon(Icons.search), onPressed: () {}),
                  SizedBox(width: 10)
                ],
                bottom: PreferredSize(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[DropDownSources()]),
                    ),
                    preferredSize: Size.fromHeight(40.0))),
            drawer: NavDrawer(),
            body: TabBarView(
              controller: _tabController,
              children: [AllNews(), Center(child: DropDownSources())],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _index,
              onTap: (int index) {
                setState(() {
                  _index = index;
                  _tabController.index = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                    icon: SizedBox(height: 25, child: Icon(Icons.list)),
                    label: 'All News'),
                BottomNavigationBarItem(
                    icon: SizedBox(height: 25, child: Icon(Icons.star)),
                    label: 'Top Headlines')
              ],
            )));
  }
}
