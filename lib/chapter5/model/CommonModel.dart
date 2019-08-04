//String icon	String	Nullable
//String title	String	Nullable
//String url	String	NonNull
//String statusBarColor	String	Nullable
//bool hideAppBar	bool	Nullable

class CommonModel {
  final String icon;
  final String title;
  final String url;
  final String statusBarColor;
  final bool hideAppBar;

  CommonModel(
      {this.icon, this.title, this.url, this.statusBarColor, this.hideAppBar});

  factory CommonModel.fromJson(Map<String, dynamic> map) {
    return CommonModel(
        icon: map['icon'],
        title: map['title'],
        url: map['url'],
        statusBarColor: map['statusBarColor'],
        hideAppBar: map['hideAppBar']);
  }
}
