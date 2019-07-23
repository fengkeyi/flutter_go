import 'package:flutter/material.dart';


class AnimationPage extends StatefulWidget {
  AnimationPage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> with SingleTickerProviderStateMixin {

  AnimationController controller;
  Animation<double> animation;

  double animationValue;
  AnimationStatus animationStatus;

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 5000), vsync: this);
    animation = Tween(begin: 0.0, end: 300.0).animate(controller)
    ..addListener((){
      setState(() {
        animationValue = animation.value;
      });
    })
    ..addStatusListener((AnimationStatus status){
      setState(() {
        animationStatus = status;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('动画Demo'),
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
           GestureDetector(
             onTap: (){
               setState(() {
                 controller.reset();
                 controller.forward();
               });
             },
             child: Text('start',textDirection: TextDirection.ltr,),
           ),
          Text('Animation status:$animationStatus',
            textDirection: TextDirection.ltr,
          ),
          Text('animation value:'+animation.value.toString(),textDirection: TextDirection.ltr,),
          Container(
            width: animationValue,
            height: animation.value,
            child: FlutterLogo(),
          ),

        ],
      )
    );
  }
}
