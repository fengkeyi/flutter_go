import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

const CATCH_URLS = ['m.ctrip.com/', 'm.ctrip.com/html5/', 'm.ctrip.com/html5'];

class WebView extends StatefulWidget {
  String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;

  WebView(
      {Key key,
      this.url,
      this.statusBarColor,
      this.title,
      this.hideAppBar,
      this.backForbid = false}) {
    if (url != null && url.contains('ctrip.com')) {
      //fix 携程H5 http://无法打开问题
      url = url.replaceAll("http://", 'https://');
    }
  }

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  FlutterWebviewPlugin _webviewPlugin;
  StreamSubscription<WebViewStateChanged> _StateChangedScription;
  StreamSubscription<String> _streamUrlChanged;
  StreamSubscription<WebViewHttpError> _subscriptionError;
  bool exist = false;

  @override
  void initState() {
    _webviewPlugin = FlutterWebviewPlugin();
    _webviewPlugin.close();
    _StateChangedScription =
        _webviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      switch (state.type) {
        case WebViewState.startLoad:
          print('url=${state.url}');
          if (_isToMain(state.url) && !exist) {
            if (widget.backForbid) {
              print('url=launch');
              _webviewPlugin.launch(widget.url);
            } else {
              print('url=pop');
              Navigator.pop(context);
              exist = true;
            }
          }else{
            print('url=_isToMain=false');
          }
          break;
        default:
          break;
      }
    });
    _streamUrlChanged = _webviewPlugin.onUrlChanged.listen((url) {});
    _subscriptionError = _webviewPlugin.onHttpError.listen((e) {
      print(e);
    });
    super.initState();
  }

  @override
  void dispose() {
    _StateChangedScription.cancel();
    _streamUrlChanged.cancel();
    _subscriptionError.cancel();
    _webviewPlugin.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';
    Color backButtonColor;
    if (statusBarColorStr == 'ffffff') {
      backButtonColor = Colors.black;
    } else {
      backButtonColor = Colors.white;
    }
    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar(Color(int.parse('0xff$statusBarColorStr')), backButtonColor),
          Expanded(
            child: WebviewScaffold(
              url: widget.url,
              withZoom: true,
              withLocalStorage: true,
              hidden: true,
              initialChild: Container(
                color: Colors.white,
                child: Center(
                  child: Text('Waiting...'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _isToMain(String url) {
    bool contain = false;
    for (final value in CATCH_URLS) {
      if (url?.endsWith(value) ?? false) {
          contain = true;
          break;
      }
    }
    return contain;
  }

  Widget _appBar(Color backgroundColor, Color backButtonColor) {
    if (widget.hideAppBar ?? false) {
      return Container(
        color: backgroundColor,
        height: 30,
      );
    }
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.close,
                  size: 25,
                  color: backButtonColor,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  widget.title,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
