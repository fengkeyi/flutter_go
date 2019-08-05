class ConfigModel{

  final String searchUrl;

  ConfigModel({this.searchUrl});

  factory ConfigModel.fromJson(Map<String,dynamic> map){
    print('ConfigModel get $map');
    print('ConfigModel get $map');
    return ConfigModel(searchUrl: map['searchUrl']);
  }

  Map<String,dynamic> toJson(){
    Map<String,dynamic> data = Map<String,dynamic>();
    data['searchUrl']=searchUrl;
    return data;
  }

}