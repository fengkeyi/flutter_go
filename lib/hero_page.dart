import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;


class HeroPage extends StatefulWidget {
  HeroPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HeroPageState createState() => _HeroPageState();
}

class _HeroPageState extends State<HeroPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hero Demo'),
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
            child: PhotoHero(
              width: 300,
              photo: 'https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1563955155&di=16561b01e839d015ba56a15884a0879c&src=http://b-ssl.duitang.com/uploads/blog/201510/15/20151015210110_xQUCk.jpeg',
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return Scaffold(
                    appBar: AppBar(title: Text('Hero Page'),),
                    backgroundColor: Colors.greenAccent,
                    body: Stack(
                      children: <Widget>[
                        PhotoHero(
                          onTap: ()=>Navigator.of(context).pop(),
                          photo: 'https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1563955155&di=16561b01e839d015ba56a15884a0879c&src=http://b-ssl.duitang.com/uploads/blog/201510/15/20151015210110_xQUCk.jpeg',
                          width: 50,
                        )
                      ],
                    ),
                  );
                }));
              },
            ),
        ),
    );
  }

}

class PhotoHero extends StatelessWidget {

  const PhotoHero({Key key, this.photo, this.onTap, this.width}) : super(key: key);

  final String photo;
  final VoidCallback onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    timeDilation = 10.0;
    return SizedBox(
      width: width,
      child: Hero(tag: photo,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Image.network(photo,fit: BoxFit.contain,),
            ),
          )),
    );
  }
}

