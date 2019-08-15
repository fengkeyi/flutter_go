import 'package:flutter/material.dart';
import 'package:flutter_go/chapter5/pages/navigationbar_search_page.dart';
import 'package:flutter_go/chapter5/plugin/asr_manager.dart';

class SpeakPage extends StatefulWidget {
  @override
  _SpeakPageState createState() => _SpeakPageState();
}

class _SpeakPageState extends State<SpeakPage>
    with SingleTickerProviderStateMixin {
  String speakTies = '长按说话';
  String speakResult = '';
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn)
      ..addStatusListener((status) {
        switch (status) {
          case AnimationStatus.completed:
            controller.reverse();
            break;
          case AnimationStatus.dismissed:
            controller.forward();
            break;
          default:
            break;
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(30),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _topItem(),
            _bottomItem(),
          ],
        ),
      ),
    ));
  }

  _speakStart(){
    controller.forward();
    setState(() {
      speakTies = '-识别中-';
    });
    AsrManager.start().then((result){
      if(result!=null && result.length!=0){
        setState(() {
          speakResult = result;
        });
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return NavigationBarSearchPage(keyword: speakResult,);
        }));
      }
    }).catchError((e){
      print(e);
    });
  }

  _speakStop(){
    setState(() {
      speakTies = '长按说话';
    });
    controller.reset();
    controller.stop();
    AsrManager.stop();
  }

  _topItem() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
          child: Text(
            '你可以这样问我',
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ),
        Text(
          '故宫门票\n北京一日游\n迪士尼乐园',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15, color: Colors.grey),
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            speakResult,
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }

  _bottomItem() {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTapDown: (e) {_speakStart();},
            onTapUp: (e) {_speakStop();},
            onTapCancel: () {_speakStop();},
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    speakTies,
                    style: TextStyle(color: Colors.blue, fontSize: 12),
                  ),
                ),
                Stack(
                  children: <Widget>[
                    Container(
                      width: MIC_SIZE,
                      height: MIC_SIZE,
                    ),
                    Center(
                      child: AnimatedMic(
                        listenable: animation,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            bottom: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.close,
                color: Colors.grey,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const double MIC_SIZE = 80;

class AnimatedMic extends AnimatedWidget {
  static final _opacityTween = Tween<double>(begin: 1, end: 0.5);
  static final _sizeTween = Tween<double>(begin: MIC_SIZE, end: MIC_SIZE - 20);

  AnimatedMic({
    Key key,
    Animation<double> listenable,
  }) : super(key: key, listenable: listenable);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Opacity(
      opacity: _opacityTween.evaluate(animation),
      child: Container(
        width: _sizeTween.evaluate(animation),
        height: _sizeTween.evaluate(animation),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(MIC_SIZE / 2),
          color: Colors.blue,
        ),
        child: Icon(
          Icons.mic,
          color: Colors.grey,
          size: 30,
        ),
      ),
    );
  }
}
