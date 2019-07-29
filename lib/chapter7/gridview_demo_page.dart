import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'module_city_json.dart';

class GridViewDemo extends StatefulWidget {
  @override
  _GridViewDemoState createState() => _GridViewDemoState();
}

class _GridViewDemoState extends State<GridViewDemo> {
  CityModule _cityModule;
  final _cityUrl = 'http://zhouxunwang.cn/data/?id=104&key=UOCU8YM3S4z+ipiB9IMzQ2rJMwTgsJeZ/pxz7fk&ske=1';

  List<Widget> _buildItems() {
    return _cityModule.result.map((city){
      return _buildItem(city);
    }).toList();
  }
  
  Widget _buildItem(Result result){
    return Container(
      color: Colors.teal,
      height: 80,
      width: 80,
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: 5,left: 5),
      padding: EdgeInsets.all(10),
      child: Text(result.province,style: TextStyle(fontSize: 25,color: Colors.white),),
    );
  }

  void _loadDatas() async{
      var response = await http.get(_cityUrl);
      Utf8Codec utf8codec = Utf8Codec();
      var result = json.decode(utf8codec.decode(response.bodyBytes));
      setState(() {
        _cityModule = CityModule.fromJson(result);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView Demo'),
      ),
      body: _cityModule == null
          ? CircularProgressIndicator(
              value: 150,
              backgroundColor: Colors.deepOrange,
            )
          : Container(
            height: 360,
            child:GridView.count(
              scrollDirection: Axis.horizontal,
              crossAxisCount: 2,
              children: _buildItems(),
            ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadDatas,
        backgroundColor: Colors.transparent,
        child: Icon(
          Icons.cloud_download,
          color: Colors.deepOrange,
          size: 50,
        ),
      ),
    );
  }
}
