import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'module_city_json.dart';

class ListViewDemo extends StatefulWidget {
  @override
  _ListViewDemoState createState() => _ListViewDemoState();
}

class _ListViewDemoState extends State<ListViewDemo> {
  ScrollController _controller;
  CityModule _cityModule;
  final _cityUrl =
      'http://zhouxunwang.cn/data/?id=104&key=UOCU8YM3S4z+ipiB9IMzQ2rJMwTgsJeZ/pxz7fk&ske=1';


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener((){
      if(_controller.position.pixels==_controller.position.maxScrollExtent) {
        _loadMoreData();
      }
    });
    super.initState();
  }

  List<Widget> _buildItems() {
    return _cityModule.result.map((city) {
      return _buildItem(city);
    }).toList();
  }

  Widget _buildItem(Result result) {
    return Container(
      color: Colors.teal,
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: 5),
      padding: EdgeInsets.all(10),
      child: Text(
        result.province,
        style: TextStyle(fontSize: 25, color: Colors.grey),
      ),
    );
  }

  void _loadDatas() async {
    var response = await http.get(_cityUrl);
    Utf8Codec utf8codec = Utf8Codec();
    var result = json.decode(utf8codec.decode(response.bodyBytes));
    setState(() {
      _cityModule = CityModule.fromJson(result);
    });
  }

  Future<Null> _loadMoreData() async {
    var response = await http.get(_cityUrl);
    Utf8Codec utf8codec = Utf8Codec();
    var result = json.decode(utf8codec.decode(response.bodyBytes));
    setState(() {
      CityModule cityModule = CityModule.fromJson(result);
      _cityModule.result.addAll(cityModule.result);
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView Demo'),
      ),
      body: _cityModule == null
          ? CircularProgressIndicator(
              value: 50,
              backgroundColor: Colors.deepOrange,
            )
          : RefreshIndicator(
              child: ListView(
                controller: _controller,
                children: _buildItems(),
              ),
              onRefresh: _loadMoreData),
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
