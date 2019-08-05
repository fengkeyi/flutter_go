import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebView extends StatefulWidget {
  final String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;

  const WebView(
      {Key key,
      this.url,
      this.statusBarColor,
      this.title,
      this.hideAppBar,
      this.backForbid = false})
      : super(key: key);

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  FlutterWebviewPlugin _webviewPlugin;
  StreamSubscription<WebViewStateChanged> _StateChangedScription;
  StreamSubscription<String> _streamUrlChanged;
  StreamSubscription<WebViewHttpError> _subscriptionError;

  @override
  void initState() {
    _webviewPlugin = FlutterWebviewPlugin();
    _StateChangedScription =
        _webviewPlugin.onStateChanged.listen((WebViewStateChanged state) {});
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
    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar(null, null),
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

  Widget _appBar(Color backgroundColor, Color backButtonColor) {
    if(widget.hideAppBar??false){
      return Container(
        color: backgroundColor,
        height: 30,
      );
    }
    return Container(
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Stack(
          children: <Widget>[
            GestureDetector(

            ),
          ],
        ),
      ),
    );
  }
}
