

class ConfigModel{

  final String searchUrl;

  ConfigModel({this.searchUrl});

  factory ConfigModel.fromJson(Map<String,dynamic> map){
    ConfigModel(searchUrl: map['searchUrl']);
  }

}