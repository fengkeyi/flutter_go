class CommonModel {
  final String icon;
  final String title;
  final String url;
  final String statusBarColor;
  final bool hideAppBar;

  CommonModel(
      {this.icon, this.title, this.url, this.statusBarColor, this.hideAppBar});

  factory CommonModel.fromJson(Map<String, dynamic> map) {
//    print('CommonModel get $map');
    return CommonModel(
        icon: map['icon'],
        title: map['title'],
        url: map['url'],
        statusBarColor: map['statusBarColor'],
        hideAppBar: map['hideAppBar']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['icon'] = icon;
    data['title'] = title;
    data['url'] = url;
    data['statusBarColor'] = statusBarColor;
    data['hideAppBar'] = hideAppBar;
    return data;
  }
}
