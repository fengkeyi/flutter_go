import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TakePhotoPage extends StatefulWidget {
  TakePhotoPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TakePhotoPageState createState() => _TakePhotoPageState();
}

class _TakePhotoPageState extends State<TakePhotoPage> {

  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    bool isImageNull = image==null;
    setState(() {
      print('image is null? $isImageNull');
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image==null?Text('not image to show.'):
             Image.file(_image,width: 100,height: 100,)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: getImage,
      child: Icon(Icons.add_a_photo,size: 50,),
      ),
    );
  }

  _selectDialog()
  {

  }
}
