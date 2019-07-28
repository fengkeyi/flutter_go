/*{
"error_code": 0,
"result": [{
"cname": "五言绝句",
"author": "唐代：李白",
"content": "床前明月光，疑是地上霜。举头望明月，低头思故乡。",
"yiwen": "直译明亮的月光洒在床前的窗户纸上，好像地上泛起了一层霜。我禁不住抬起头来，看那天窗外空中的一轮明月，不由得低头沉思，想起远方的家乡。",
"des": "李白（701年－762年），字太白，号青莲居士，唐朝浪漫主义诗人，被后人誉为“诗仙”。祖籍陇西成纪(待考)，出生于西域碎叶城，4岁再随父迁至剑南道绵州。李白存世诗文千余篇，有《李太白集》传世。762年病逝，享年61岁。其墓在今安徽当涂，四川江油、湖北安陆有纪念馆。► 1310篇诗文"
}]
}*/

//自动生成JSON class
//https://javiercbk.github.io/json_to_dart/
//大型项目
//json_serializable 3.1.0
class PoetryModule{

  int error_code;
  List<Result> results;


  PoetryModule({this.error_code, this.results});

  PoetryModule.fromJson(Map<String,dynamic> map){
    print('module');
    print(map);
    error_code=map['error_code'];
    results = (map['result'] as List).map((v){
      print(v);
      return Result.fromJson(v);}).toList();

  }

}

class Result{
  String cname;
  String author;
  String content;
  String yiwen;
  String des;

  Result({this.cname, this.author, this.content, this.yiwen, this.des});

  factory Result.fromJson(Map<String,dynamic> map){
    print('Result-------');
    print(map);
    return Result(
      cname : map['cname'],
      author : map['author'],
      content : map['content'],
      yiwen : map['yiwen'],
      des : map['des'],
    );
  }



  @override
  String toString() {
    return 'Result{cname: $cname, author: $author, content: $content, yiwen: $yiwen, des: $des}';
  }


}
