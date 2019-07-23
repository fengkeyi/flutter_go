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

  List _images = [];

  Future getImage(bool isTakePhoto) async {
    var image = await ImagePicker.pickImage(source: isTakePhoto?ImageSource.camera:ImageSource.gallery);
    bool isImageNull = image==null;
    Navigator.pop(context);
    setState(() {
      print('image is null? $isImageNull');
      _images.add(image);
    });
  }

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
          children:_showImages()
        )
      ),
      floatingActionButton: FloatingActionButton(onPressed: _showImgeSelect,
      child: Icon(Icons.add_a_photo,size: 50,),
      ),
    );
  }


   _showImgeSelect() {
    showModalBottomSheet(context: context, builder: (context)=>
    Container(
      height: 160,
      child: Column(
        children: <Widget>[
          _item("拍照",true),
          _item("相册",false),
        ],
      ),
    ));
  }

  _item(String title, bool isTakePhoto) {
      return GestureDetector(
        onTap:()=>getImage(isTakePhoto),
        child: ListTile(
          leading: Icon(isTakePhoto?Icons.camera_alt:Icons.photo_library),
            title: Text(title),
        ),
      );
  }

  _showImages() {
    return _images.map((file){
      return Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(file,width: 120,height: 90,fit: BoxFit.fill,),
          ),
          Positioned(
            right:5,
            top: 5,
          child: GestureDetector(
            onTap: (){
              setState(() {
                  _images.remove(file);
              });
            },
            child: ClipOval(
           child: Container(
               padding: EdgeInsets.all(5),
               decoration: BoxDecoration(color: Colors.black54),
               child: Icon(Icons.close,color: Colors.white,size: 18,),
           ),
          ),
          ),
          ),
        ],
      );
    }).toList();
  }

}




