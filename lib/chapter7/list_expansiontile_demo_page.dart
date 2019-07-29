import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'module_city_json.dart';

class ExpansiontileViewDemo extends StatefulWidget {
  @override
  _ExpansiontileViewDemo createState() => _ExpansiontileViewDemo();
}

class _ExpansiontileViewDemo extends State<ExpansiontileViewDemo> {
  CityModule _cityModule;
  final _cityUrl =
      'http://zhouxunwang.cn/data/?id=104&key=UOCU8YM3S4z+ipiB9IMzQ2rJMwTgsJeZ/pxz7fk&ske=1';

  List<Widget> _buildItem() {
    return _cityModule.result.map((result) {
      return _buildExpansionTile(result);
    }).toList();
  }

  Widget _buildExpansionTile(Result result) {
    return Container(
      color: Colors.teal,
      margin: EdgeInsets.only(bottom: 5),
      child: ExpansionTile(
        title: Text(
          result.province,
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        children: _buildSubitem(result.city[0].district),
      ),
    );
  }

  List<Widget> _buildSubitem(List<District> districts) {
    return districts.map((District district) {
      return FractionallySizedBox(
        widthFactor: 1,
        child: Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.only(bottom: 2),
          color: Colors.blueAccent,
          child: Text(
            district.district,
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      );
    }).toList();
  }

  void _loadDatas() async {
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
      body: Center(
        child: _cityModule == null
            ? CircularProgressIndicator(
                value: 50,
                backgroundColor: Colors.deepOrange,
              )
            : ListView(
                children: _buildItem(),
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
