import 'package:flutter/material.dart';


class GesturePage extends StatefulWidget {
  GesturePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _GesturePageState createState() => _GesturePageState();
}

class _GesturePageState extends State<GesturePage> {

  String _msg='-';
  double moveX=0,moveY =0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('手势'),
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
//            GestureDetector(
//              onTap: ()=>_printMsg('点击'),
//              onDoubleTap: ()=>_printMsg('双击'),
//              onTapDown: (e)=>_printMsg('按下'),
//              onTapUp: (e)=>_printMsg('松开'),
//              onTapCancel: ()=>_printMsg('取消'),
//              onLongPress: ()=>_printMsg('长按'),
//              child: Container(
//                alignment: Alignment.center,
//                width: 50,
//                height: 50,
//                color: Colors.green,
//                child: Text('点我'),
//              ),
//            ),
//            Container(
//              padding: EdgeInsets.all(10),
//              child: Text(_msg,style: TextStyle(color: Colors.black,fontSize: 25),),
//            ),
                Positioned(
                  left: moveX,
                  top: moveY,
                  child:GestureDetector(
                    onPanUpdate: (e)=>_move(e),
                  child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(color: Colors.red,
                  borderRadius: BorderRadius.circular(36)),
                  ),
                  ),
            )
          ],
        ),
      ),
    );
  }

  _printMsg(String s) {
    _msg += ',$s';
    setState(() {
      
    });
  }

  _move(DragUpdateDetails e) {
    setState(() {
      moveX += e.delta.dx;
      moveY += e.delta.dy;
    });
  }
  
  

}
