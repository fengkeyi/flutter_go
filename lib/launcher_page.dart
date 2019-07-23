import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';



class LauncherPage extends StatefulWidget {
  LauncherPage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<LauncherPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('页面跳转'),
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(onPressed: _launchURL,
              child: Text('打开flutter官网',style: TextStyle(color: Colors.black,fontSize: 30),),
            ),
          ],
        ),
      ),
    );
  }

  _launchURL() async {
    const url = 'https://flutterchina.club/upgrading/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
