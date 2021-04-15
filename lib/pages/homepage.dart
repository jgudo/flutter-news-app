import 'package:flutter/material.dart';
import 'package:news_demo_livestream/pages/all_news.dart';
import 'package:news_demo_livestream/widgets/nav_drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  List<Tab> categories = [
    Tab(child: Text(AllNews.tabName)),
    Tab(
      child: Text('Investment'),
    ),
    Tab(
      child: Text('Your Earning'),
    ),
    Tab(
      child: Text('Current Balance'),
    ),
    Tab(
      child: Text('Tab 5'),
    ),
    Tab(
      child: Text('Tab 6'),
    )
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: categories.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _tabBar() {
    return PreferredSize(
        child: TabBar(
            isScrollable: true,
            unselectedLabelColor: Colors.white.withOpacity(0.3),
            indicatorColor: Colors.white,
            controller: _tabController,
            tabs: categories),
        preferredSize: Size.fromHeight(40.0));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: categories.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text('News App'),
            bottom: _tabBar(),
            actions: [
              IconButton(icon: Icon(Icons.search), onPressed: () {}),
              SizedBox(width: 10)
            ],
          ),
          drawer: NavDrawer(),
          body: TabBarView(
            controller: _tabController,
            children: [
              AllNews(),
              Text('Tab2'),
              Text('Tab3'),
              Text('Tab4'),
              Text('Tab5'),
              Text('Tab6'),
            ],
          ),
        ));
  }
}
