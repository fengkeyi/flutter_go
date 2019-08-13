import 'package:flutter_go/chapter5/model/search_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchDao {
  static Future<SearchModel> get(String keyword,String url) async {
    var response = await http.get(url);
    if(response.statusCode==200) {
      Utf8Codec utf8codec = Utf8Codec();
      SearchModel model =
      SearchModel.fromJson(json.decode(utf8codec.decode(response.bodyBytes)));
      model.keyWord = keyword;
      return model;
    }else{
      throw Exception('fetch url is invaliable');
    }
  }
}
