import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'dart:math' as math;

class HeroHigh extends StatelessWidget {
  static const double kMinRadius = 32.0;
  static const double kMaxRadius = 128.0;
  static const opacityCurve =
      const Interval(0.0, 0.75, curve: Curves.fastOutSlowIn);

  static RectTween _createRectTween(Rect begin, Rect end) {
    return MaterialRectCenterArcTween(begin: begin, end: end);
  }

  static Widget _buildPage(
      BuildContext context, String photoName, String descriptioin) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Center(
        child: Card(
          elevation: 8.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: 2.0 * kMaxRadius,
                height: 2.0 * kMaxRadius,
                child: Hero(
                  createRectTween: _createRectTween,
                    tag: photoName,
                    child: RadiaExpansion(
                      maxRadius: kMaxRadius,
                        child:Photo(
                      photo: photoName,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ))),
              ),
              Text(
                descriptioin,
                style: TextStyle(fontWeight: FontWeight.bold),
                textScaleFactor: 3,
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHero(
      BuildContext context, String photoName, String descriptioin) {
    return Container(
      width: kMinRadius * 2,
      height: kMinRadius * 2,
      child: Hero(
        createRectTween: _createRectTween,
        tag: photoName,
        child: RadiaExpansion(
          maxRadius: kMaxRadius,
          child: Photo(
            photo: photoName,
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder<void>(pageBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation) {
                  return AnimatedBuilder(
                      animation: animation,
                      builder: (context, widget) {
                        return Opacity(
                          opacity: opacityCurve.transform(animation.value),
                          child: _buildPage(context, photoName, descriptioin),
                        );
                      });
                }),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    timeDilation = 10.0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Radial Transition Dmeo'),
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        alignment: FractionalOffset.bottomLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildHero(
                context,
                'http://img.netbian.com/file/2019/0722/small1021e6a3801e1bcebc73696017b279c61563774787.jpg',
                'Chair'),
            _buildHero(
                context,
                'http://img.netbian.com/file/2019/0722/small46a77e637238b439e445a8e11279eb281563792905.jpg',
                'Binoculars'),
            _buildHero(
                context,
                'http://img.netbian.com/file/2019/0722/ddf99c15c7819220f3bb7be67616af0d.jpg',
                'Beach ball'),
          ],
        ),
      ),
    );
  }
}

class RadiaExpansion extends StatelessWidget {
  const RadiaExpansion({Key key, this.maxRadius, this.child})
      : clipRectSize = 2.0 * (maxRadius / math.sqrt2),
        super(key: key);

  final double maxRadius;
  final clipRectSize;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Center(
        child: SizedBox(
          width: clipRectSize,
          height: clipRectSize,
          child: ClipRect(
            child: child,
          ),
        ),
      ),
    );
  }
}

class Photo extends StatelessWidget {
  final String photo;
  final Color color;
  final VoidCallback onTap;

  const Photo({Key key, this.photo, this.color, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor.withOpacity(0.25),
      child: InkWell(
        onTap: onTap,
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Image.network(
            photo,
            fit: BoxFit.fill,
          );
        }),
      ),
    );
  }
}
