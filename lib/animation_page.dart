import 'package:flutter/material.dart';


class AnimationPage extends StatefulWidget {
  AnimationPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AnimationPageState createState() => _AnimationPageState();
}

/**
 * animation 2
 */
class AnimatedLogo extends AnimatedWidget {

  AnimatedLogo({Key key,Animation<double> animation})
      :super(key:key,listenable:animation);

    @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Center(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          width: animation.value,
          height: animation.value,
          child: FlutterLogo(),
        ),
    );
  }
}

class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: FlutterLogo(),
    );
  }
}

class GrowTransitioin extends StatelessWidget {

  GrowTransitioin({this.child,this.animation});

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(animation: animation,
          builder: (context,child)=>Container(
            width: animation.value,
            height: animation.value,
            child: child,
          ),
      child: child,),
    );
  }
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
    controller.forward();

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
      body:
      GrowTransitioin(child: LogoWidget(),animation: animation,)
      /*AnimatedLogo(animation: animation,),*/
      /*Column(
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
      )*/
    );
  }
}
