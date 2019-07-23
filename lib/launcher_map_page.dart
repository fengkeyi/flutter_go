import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LauncherMapPage extends StatefulWidget {
  LauncherMapPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LauncherMapPageState createState() => _LauncherMapPageState();
}

class _LauncherMapPageState extends State<LauncherMapPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              RaisedButton(onPressed: _openMap,
                child: Text('打开地图',style: TextStyle(fontSize: 25),),
              )
          ],
        ),
      ),
    );
  }

  _openMap() async{
    const url = 'geo:52.32,4.917';
    if(await canLaunch(url) ) {
      await  launch(url);
    }else {
      const url = 'http://maps.apple.com/?ll=52.32,4.917';
      if(await canLaunch(url) ) {
        await  launch(url);
      }else {
        throw 'could not launch $url';
      }
    }
  }
}
