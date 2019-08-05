
import 'package:flutter_go/chapter5/model/home_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeDao{

    static const String HOME_URL = 'http://www.devio.org/io/flutter_app/json/home_page.json';

    static Future<HomeModel> get() async{
       var response = await http.get(HOME_URL);
       Utf8Codec utf8codec = Utf8Codec();
       var result = json.decode(utf8codec.decode(response.bodyBytes));
       print('http get $result');
       HomeModel homeModel = HomeModel.fromJson(result);
       print('home model decode finish.${homeModel==null}');
       print(homeModel.toJson());
       return homeModel;
    }



}