import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

///
/// Flare 动画
/// https://www.2dimensions.com/a/JuanCarlos/files/flare/teddy/preview

class FlareView extends StatefulWidget {
  @override
  _FlareViewState createState() => _FlareViewState();
}

class _FlareViewState extends State<FlareView> {
  String _animation = 'Untitled';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlareView'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              switch (_animation) {
                case 'success':
                  _animation = 'fail';
                  break;
                case 'fail':
                  _animation = 'idle';
                  break;
                case 'idle':
                  _animation = 'test';
                  break;
                case 'test':
                  _animation = 'success';
                  break;
                default:
                  _animation = 'success';
                  break;
              }
            });
          },
          child: new FlareActor("flrs/success.flr",
              alignment: Alignment.center,
              fit: BoxFit.contain,
              animation: _animation),
        ),
      ),
    );
  }
}
