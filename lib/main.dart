import 'package:flutter/material.dart';

import 'animation_page.dart';
import 'gesture_page.dart';
import 'image_widget_page.dart';
import 'imge_page.dart';
import 'launcher_page.dart';
import 'other_page.dart';
import 'second_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '页面跳转Demo'),
      routes: <String,WidgetBuilder>{
        'other':(BuildContext context)=>OtherPage(),
        'second':(BuildContext context)=>SecondPage(),
        'gesture':(BuildContext context)=>GesturePage(),
        'image':(BuildContext context)=>ImagePage(),
        'launcher':(BuildContext context)=>LauncherPage(),
        'imagedemo':(BuildContext context)=>ImageDemo(),
        'animation':(BuildContext context)=>AnimationPage(),
      } ,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool byName = false;

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
            SwitchListTile(value: byName, onChanged: (value){
              setState(() {
                byName = value;
              });
        },),
            _itemt('跳转第一个页面',OtherPage(),'other'),
            _itemt('跳转第二个页面',SecondPage(),'second'),
            _itemt('跳转手势页面',GesturePage(),'gesture'),
            _itemt('跳转图片引用页面',ImagePage(),'image'),
            _itemt('跳转打开应用页面',LauncherPage(),'launcher'),
            _itemt('跳转Image应用页面',ImageDemo(),'imagedemo'),
            _itemt('跳转Animation应用页面',AnimationPage(),'animation'),
          ],
        ),
      ),
    );



  }

  _itemt(String content, page, String routName) {
    return Container(
      child: RaisedButton(onPressed: (){
        if(byName){
          Navigator.pushNamed(context, routName);
        }else {
          Navigator.push(context,
              MaterialPageRoute(builder:(context)=>page));
        }
      },
        child: Text(content),
      ),
    );
  }


}
