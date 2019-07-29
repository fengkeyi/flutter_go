import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'json_module.dart';


class HttpDemo extends StatefulWidget {
  @override
  _HttpDemoState createState() => _HttpDemoState();
}

class _HttpDemoState extends State<HttpDemo> {
//Xe7ArNVnHI7+ipiB9IMzQ2rJMwTgsJeZ/pxz7fU
//UOCU8YM3S4z+ipiB9IMzQ2rJMwTgsJeZ/pxz7fk
//http://zhouxunwang.cn/data/?id=104&key=UOCU8YM3S4z+ipiB9IMzQ2rJMwTgsJeZ/pxz7fk&ske=1
//  String url ='http://zhouxunwang.cn/data/?id=108&key=Xe7ArNVnHI7+ipiB9IMzQ2rJMwTgsJeZ/pxz7fU&name=李清照';
  String url ='http://zhouxunwang.cn/data/?id=108&key=Xe7ArNVnHI7+ipiB9IMzQ2rJMwTgsJeZ/pxz7fU&name=李白';
  String url2 ='http://zhouxunwang.cn/data/?id=108&key=Xe7ArNVnHI7+ipiB9IMzQ2rJMwTgsJeZ/pxz7fU&name=床前明月光';

  PoetryModule _poetryModule;


  Future<PoetryModule> _getPoeTry() async {
    final response = await http.post(url);
    //中文乱码
    Utf8Decoder utf8decoder = Utf8Decoder();
    print(response.body);
    final result = json.decode(utf8decoder.convert(response.bodyBytes));

    return PoetryModule.fromJson(result);
  }

  Future<PoetryModule> _getPoeTrySpecial() async {
    final response = await http.post(url2);
    //中文乱码
    Utf8Decoder utf8decoder = Utf8Decoder();
    print(response.body);
    final result = json.decode(utf8decoder.convert(response.bodyBytes));
    return PoetryModule.fromJson(result);
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Http demo'),
        ),
        body:
        _poetryModule==null?Text('result is null'):_showPoetry(_poetryModule),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            _getPoeTry().then((PoetryModule module){
              setState(() {
                _poetryModule = module;
              });
            });
          },
          child: Icon(Icons.file_download,color: Colors.red,size: 25,),
        ),
        bottomSheet: FutureBuilder<PoetryModule>(
          future: _getPoeTrySpecial(),
          builder: (BuildContext context, AsyncSnapshot<PoetryModule> snapshot){
            print('state:${snapshot.connectionState}');
            switch(snapshot.connectionState) {
              case ConnectionState.none:
                return Text('result is null');
              case ConnectionState.active:
                return Text('status is active');
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              case ConnectionState.done:
                if(snapshot.hasError){
                  print('error');
                  return Text('url error');
                }else{
                  print('show');
                  return _showPoetrybottom(snapshot.data);
                }
            }
          },),
      ),
    );
  }
}

_showPoetrybottom(PoetryModule poetrys) {
  print('size        ppppppppp:${poetrys.results.length}');
  return
    Container(
      height: 100,
      child:ListView(
          children:
          poetrys.results.map((value){
            return _showItem(value);
          }).toList()
      ),);
}

_showPoetry(PoetryModule module) {
  print('size        ppppppppp:${module.results.length}');
  return
    Container(
      height: 800,
        child:ListView(
        children:
        module.results.map((value){
          return _showItem(value);
        }).toList()
    ),);
}

Widget _showItem(Result poetryModule)
 {
  return Column(
    children:
    <Widget>[
      Text('名称:${poetryModule.cname}'),
      Text('作者:${poetryModule.author}'),
      Text('正文:${poetryModule.content}'),
      Text('翻译:${poetryModule.yiwen}'),
      Text('作家简述:${poetryModule.des}'),
    ],
  );
}/*
class Poetrys{
  List<PoetryModule> poetrys;

  Poetrys({this.poetrys});

  factory Poetrys.fromJson(List<dynamic> listJson){

    List<PoetryModule> list = listJson.map((value)=>
    PoetryModule.fromJson(value)).toList();
    return Poetrys(poetrys: list);

  }

}

class PoetryModule {
  String cname;
  String author;
  String content;
  String yiwen;
  String des;

  PoetryModule({this.cname, this.author, this.content, this.yiwen, this.des});

  factory PoetryModule.fromJson(Map<String, dynamic> map){
    return PoetryModule(
      cname: map['cname'],
      author: map['author'],
      content: map['content'],
      yiwen: map['yiwen'],
      des: map['des'],
    );
  }

}
*/
//
//[{
//"cname": "五言绝句",
//"author": "唐代：李白",
//"content": "床前明月光，疑是地上霜。举头望明月，低头思故乡。",
//"yiwen": "直译明亮的月光洒在床前的窗户纸上，好像地上泛起了一层霜。我禁不住抬起头来，看那天窗外空中的一轮明月，不由得低头沉思，想起远方的家乡。",
//"des": "李白（701年－762年），字太白，号青莲居士，唐朝浪漫主义诗人，被后人誉为“诗仙”。祖籍陇西成纪(待考)，出生于西域碎叶城，4岁再随父迁至剑南道绵州。李白存世诗文千余篇，有《李太白集》传世。762年病逝，享年61岁。其墓在今安徽当涂，四川江油、湖北安陆有纪念馆。► 1310篇诗文"
//}]
