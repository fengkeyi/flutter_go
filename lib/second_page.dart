import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_go/generated/i18n.dart';

class SecondPage extends StatefulWidget {
  SecondPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SecondPage createState() => _SecondPage();
}

class _SecondPage extends State<SecondPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown,DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight]);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('页面跳转'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 130,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: PhysicalShape(
                  clipper: ShapeBorderClipper(
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)))),
                  color: Colors.black,
                child: FlatButton(onPressed: (){}, child: Text('132465',style: TextStyle(color: Colors.white),)),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              color: Colors.grey,
              width: 50,
              height: 50,
              child: RawMaterialButton(onPressed: (){},
                child: Text('RawMaterialButton'),
              ),
            ),
            Text(S.of(context).title)
            ,
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
