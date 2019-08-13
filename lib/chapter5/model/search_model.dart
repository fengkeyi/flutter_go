class SearchModel {
  String keyWord;
  Head head;
  List<SearchItem> data;

  SearchModel({this.head, this.data});

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    SearchModel model = SearchModel();
    model.head = json['head'] != null ? new Head.fromJson(json['head']) : null;
    List<SearchItem> data;
    if (json['data'] != null) {
      data = new List<SearchItem>();
      json['data'].forEach((v) {
        data.add(SearchItem.fromJson(v));
      });
    }
    model.data = data;
    return model;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> model = new Map<String, dynamic>();
    if (this.head != null) {
      model['head'] = this.head.toJson();
    }
    if (this.data != null) {
      model['data'] =
          this.data.map((v) => v.toJson()).toList();
    }
    return model;
  }
}

class Head {
  Null auth;
  int errcode;

  Head({this.auth, this.errcode});

  Head.fromJson(Map<String, dynamic> json) {
    auth = json['auth'];
    errcode = json['errcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> SearchItem = new Map<String, dynamic>();
    SearchItem['auth'] = this.auth;
    SearchItem['errcode'] = this.errcode;
    return SearchItem;
  }
}

class SearchItem {
  String word;
  String type;
  String price;
  String star;
  String zonename;
  String districtname;
  String url;

  SearchItem(
      {this.word,
      this.type,
      this.price,
      this.star,
      this.zonename,
      this.districtname,
      this.url});

  factory SearchItem.fromJson(Map<String, dynamic> json) {
    return SearchItem(
        word: json['word'],
        type: json['type'],
        price: json['price'],
        star: json['star'],
        zonename: json['zonename'],
        districtname: json['districtname'],
        url: json['url']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> SearchItem = new Map<String, dynamic>();
    SearchItem['word'] = this.word;
    SearchItem['type'] = this.type;
    SearchItem['price'] = this.price;
    SearchItem['star'] = this.star;
    SearchItem['zonename'] = this.zonename;
    SearchItem['districtname'] = this.districtname;
    SearchItem['url'] = this.url;
    return SearchItem;
  }
}
