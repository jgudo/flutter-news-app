import 'package:flutter/material.dart';

class NavDrawer extends StatefulWidget {
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
            color: Colors.red,
            padding: EdgeInsets.all(10.0),
            child: SizedBox(
              height: 70,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Categories',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18,
                        ))
                  ]),
            )),
        ListTile(
            leading: Icon(Icons.list),
            title: Text('All News',
                style: TextStyle(fontWeight: FontWeight.bold))),
        ListTile(
            leading: Icon(Icons.star),
            title: Text('Top Headlines',
                style: TextStyle(fontWeight: FontWeight.bold))),
      ],
    ));
  }
}
