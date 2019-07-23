import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
        title: Text(widget.title),
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
           Image.asset('images/circle.png',width: 50,height: 50,),
            Image(width: 50,height: 50,image: AssetImage('images/circle.png'),),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed:(){},
      child: Icon(Icons.add_a_photo,size: 50,),
      ),
    );
  }


}




