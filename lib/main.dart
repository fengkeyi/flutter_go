import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_splash_screen/flutter_splash_screen.dart';

import 'animation_page.dart';
import 'chapter5/navigator/tab_navigationbar.dart';
import 'chapter6/http_json_page.dart';
import 'chapter6/share_preference.dart';
import 'chapter7/gridview_demo_page.dart';
import 'chapter7/list_expansiontile_demo_page.dart';
import 'chapter7/listview_demo_page.dart';
import 'chapter7/listview_horizontal_demo_page.dart';
import 'generated/i18n.dart';
import 'gesture_page.dart';
import 'hero_page.dart';
import 'hero_usage_page.dart';
import 'image_widget_page.dart';
import 'imge_page.dart';
import 'launcher_page.dart';
import 'learn/flare_view.dart';
import 'other_page.dart';
import 'second_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'flutter之旅',
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '页面跳转Demo'),
      routes: <String,WidgetBuilder>{
        'other':(BuildContext context)=>OtherPage(),
        'FlareView':(BuildContext context)=>FlareView(),
        'second':(BuildContext context)=>SecondPage(),
        'gesture':(BuildContext context)=>GesturePage(),
        'image':(BuildContext context)=>ImagePage(),
        'launcher':(BuildContext context)=>LauncherPage(),
        'imagedemo':(BuildContext context)=>ImageDemo(),
        'animation':(BuildContext context)=>AnimationPage(),
        'hero':(BuildContext context)=>HeroPage(),
        'radialhero':(BuildContext context)=>HeroHigh(),
        'navigationbar':(BuildContext context)=>NavigationBarPage(),
        'http':(BuildContext context)=>HttpDemo(),
        'sp':(BuildContext context)=>SharedPreferenceDemo(),
        'ListViewDemo':(BuildContext context)=>ListViewDemo(),
        'ListViewHorizontalDemo':(BuildContext context)=>ListViewHorizontalDemo(),
        'ExpansiontileViewDemo':(BuildContext context)=>ExpansiontileViewDemo(),
        'GridViewDemo':(BuildContext context)=>GridViewDemo(),
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
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1500),(){
        FlutterSplashScreen.hide();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            SwitchListTile(value: byName, onChanged: (value){
              setState(() {
                byName = value;
              });
        },),
            _itemt('跳转FlareView页面',FlareView(),'FlareView'),
            _itemt('跳转第一个页面',OtherPage(),'other'),
            _itemt('跳转第二个页面',SecondPage(),'second'),
            _itemt('跳转手势页面',GesturePage(),'gesture'),
            _itemt('跳转图片引用页面',ImagePage(),'image'),
            _itemt('跳转打开应用页面',LauncherPage(),'launcher'),
            _itemt('跳转Image应用页面',ImageDemo(),'imagedemo'),
            _itemt('跳转Animation应用页面',AnimationPage(),'animation'),
            _itemt('跳转Hero应用页面',HeroPage(),'hero'),
            _itemt('跳转RadialHero应用页面',HeroHigh(),'radialhero'),
            _itemt('跳转NavigationBar应用页面',NavigationBarPage(),'navigationbar'),
            _itemt('跳转Http应用页面',HttpDemo(),'http'),
            _itemt('跳转SharedPreferenceDemo应用页面',SharedPreferenceDemo(),'sp'),
            _itemt('跳转ListViewDemo应用页面',ListViewDemo(),'ListViewDemo'),
            _itemt('跳转ListViewHorizontalDemo应用页面',ListViewHorizontalDemo(),'ListViewHorizontalDemo'),
            _itemt('跳转ExpansiontileViewDemo应用页面',ExpansiontileViewDemo(),'ExpansiontileViewDemo'),
            _itemt('跳转GridViewDemo应用页面',GridViewDemo(),'GridViewDemo'),
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
