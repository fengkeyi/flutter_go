import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class SharedPreferenceDemo extends StatefulWidget {
  @override
  _SharedPreferenceDemoState createState() => _SharedPreferenceDemoState();
}

class _SharedPreferenceDemoState extends State<SharedPreferenceDemo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Shared Preference Demo'),),
        body:Center(
          child: RaisedButton(onPressed:_sharedPreferenceDemo,
          child: Icon(Icons.font_download,size: 50,color: Colors.red,),
        ),
      ),
    )
    );
  }
}


_sharedPreferenceDemo()async{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  int count = sharedPreferences.getInt('sp_demo')??0;
  print(count);
  await sharedPreferences.setInt('sp_demo', count+5);
  count = sharedPreferences.getInt('sp_demo');
  print(count);

}