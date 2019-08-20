import 'package:flutter/material.dart';
import 'package:flutter_go/chapter5/widget/webview.dart';

class NavigationBarMyPage extends StatefulWidget {
  @override
  _NavigationBarMyPageState createState() => _NavigationBarMyPageState();
}

class _NavigationBarMyPageState extends State<NavigationBarMyPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:WebView(
        url: 'https://m.ctrip.com/webapp/myctrip/',
        hideAppBar: true,
        backForbid: true,
        statusBarColor: '4c5bca',
      ),
    );
  }

}
