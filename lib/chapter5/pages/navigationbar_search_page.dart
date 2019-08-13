import 'package:flutter/material.dart';
import 'package:flutter_go/chapter5/dao/search_dao.dart';
import 'package:flutter_go/chapter5/model/search_model.dart';
import 'package:flutter_go/chapter5/widget/search_bar.dart';
import 'package:flutter_go/chapter5/widget/webview.dart';

const TYPES = [
  'channelgroup',
  'gs',
  'plane',
  'train',
  'cruise',
  'district',
  'food',
  'hotel',
  'huodong',
  'shop',
  'sight',
  'ticket',
  'travelgroup'
];

const URL =
    'https://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contentType=json&keyword=';

class NavigationBarSearchPage extends StatefulWidget {
  final bool hideLeft;
  final String hint;
  final String searchUrl;
  final keyword;

  const NavigationBarSearchPage(
      {Key key, this.hideLeft, this.hint, this.searchUrl = URL, this.keyword})
      : super(key: key);

  @override
  _NavigationBarSearchPageState createState() =>
      _NavigationBarSearchPageState();
}

class _NavigationBarSearchPageState extends State<NavigationBarSearchPage> {
  SearchModel _searchModel;
  String _keyword;

  @override
  void initState() {
    if (widget.keyword != null) {
      _onTextChange(widget.keyword);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar(),
          MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: Expanded(
                  flex: 1,
                  child: ListView.builder(
                      itemCount: _searchModel?.data?.length ?? 0,
                      itemBuilder: (context, int pos) {
                        return _item(pos);
                      }))),
        ],
      ),
    );
  }

  _appBar() {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0x66000000), Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          child: Container(
            height: 80,
            padding: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(color: Colors.white),
            child: SearchBar(
              hideLeft: widget.hideLeft,
              defaultText: widget.keyword,
              hint: widget.hint,
              speakClick: _jumpToSpeak,
              leftButtonClick: () {
                Navigator.pop(context);
              },
              onChanged: _onTextChange,
            ),
          ),
        ),
      ],
    );
  }

  _item(int pos) {
    if (_searchModel == null || _searchModel.data == null) return null;
    SearchItem item = _searchModel.data[pos];
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return WebView(
            title: '详情',
            url: item.url,
          );
        }));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.3, color: Colors.grey)),
        ),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(1.0),
              child: Image(
                image: AssetImage(_typeImage(item.type)),
                width: 26,
                height: 26,
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  width: 300,
                  child: _title(item),
                ),
                Container(
                  width: 300,
                  child: _subTitle(item),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  _jumpToSpeak() {}

  _onTextChange(String text) {
    _keyword = text;
    if (text.length == 0) {
      setState(() {
        _searchModel = null;
      });
      return;
    }
    String url = URL + text;
    SearchDao.get(text, url).then((SearchModel model) {
      if (model.keyWord == _keyword) {
        setState(() {
          _searchModel = model;
        });
      }
    }).catchError((e) {
      print(e);
    });
  }

  _typeImage(String type) {
    if (type == null || type.length == 0) return 'images/type_travelgroup.png';
    var path = 'travelgroup';
    for (final val in TYPES) {
      if (val.contains(type)) {
        path = val;
        break;
      }
    }
    path = 'images/type_$path.png';
    return path;
  }

  _title(SearchItem item) {
    if (item == null) {
      return null;
    }
    List<TextSpan> spans = [];
    spans.addAll(_keywordTextSpans(item.word, _searchModel.keyWord));
    spans.add(TextSpan(
        text: ' ' + (item.districtname ?? '') + ' ' + (item.zonename ?? ''),
        style: TextStyle(fontSize: 16, color: Colors.grey)));
    return RichText(text: TextSpan(children: spans));
  }

  _subTitle(SearchItem item) {
    return RichText(
      text: TextSpan(children: <TextSpan>[
        TextSpan(
          text: item.price ?? '',
          style: TextStyle(fontSize: 16, color: Colors.orange),
        ),
        TextSpan(
          text: ' ' + (item.star ?? ''),
          style: TextStyle(fontSize: 12, color: Colors.grey),
        )
      ]),
    );
  }

  _keywordTextSpans(String word, String keyword) {
    List<TextSpan> spans = [];
    if (word == null || word.length == 0) return spans;
    var wordL = word.toLowerCase(), keywordL = keyword.toLowerCase();
    List<String> arr = wordL.split(keywordL);
    TextStyle normalStyle = TextStyle(color: Colors.black87, fontSize: 16);
    TextStyle keywordStyle = TextStyle(color: Colors.yellow, fontSize: 16);
    int preIndex = 0;
    for (int i = 0; i < arr.length; i++) {
      if (i != 0) {
        preIndex = wordL.indexOf(keywordL, preIndex);
        spans.add(TextSpan(
            text: word.substring(preIndex, preIndex + keywordL.length),
            style: keywordStyle));
      }
      String val = arr[i];
      if (val != null && val.length > 0) {
        spans.add(TextSpan(text: val, style: normalStyle));
      }
    }
    return spans;
  }
}
