import 'package:flutter/material.dart';
import 'package:flutter_go/chapter5/widget/search_bar.dart';

class NavigationBarSearchPage extends StatefulWidget {
  @override
  _NavigationBarSearchPageState createState() =>
      _NavigationBarSearchPageState();
}

class _NavigationBarSearchPageState extends State<NavigationBarSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: SearchBar(
              hideLeft: true,
              defaultText: '123',
              hintText: '456',
              speakClick: () {},
              leftButtonClick: () {
                Navigator.pop(context);
              },
              onChange: (String) {},
            ),
          ),
        ],
      ),
    );
  }
}
