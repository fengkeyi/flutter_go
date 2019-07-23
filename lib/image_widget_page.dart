import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageDemo extends StatefulWidget {
  ImageDemo({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TakePhotoPageState createState() => _TakePhotoPageState();
}

class _TakePhotoPageState extends State<ImageDemo> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('图片image'),
      ),
      body: Center(
        child: Wrap(
          spacing: 5,
          runSpacing: 5,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child:  Image.network('http://www.devio.org/img/avatar.png'),
            ),
           Image.asset('images/circle.png',width: 150,height: 150,),
            CachedNetworkImage(imageUrl: 'http://www.devio.org/img/avatar.png',
              placeholder: (context,url)=>CircularProgressIndicator(),
              errorWidget: (context,url,error)=>Icon(Icons.error),
            ),
            CachedNetworkImage(
              imageUrl: "http://via.placeholder.com/350x150",
              placeholder: (context, url) => new CircularProgressIndicator(),
              errorWidget: (context, url, error) => new Icon(Icons.error),
            ),
            CachedNetworkImage(
              imageUrl: "http://via.placeholder.com/200x150",
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      colorFilter:
                      ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
                ),
              ),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed:(){},
      child: Icon(Icons.add_a_photo,size: 50,),
      ),
    );
  }


}




