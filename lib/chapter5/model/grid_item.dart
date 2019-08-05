import 'package:flutter_go/chapter5/model/common_model.dart';

class GridItem{
  final String startColor;
  final String endColor;
  final CommonModel mainItem;
  final CommonModel item1;
  final CommonModel item2;
  final CommonModel item3;
  final CommonModel item4;

  GridItem({this.startColor, this.endColor, this.mainItem, this.item1, this.item2, this.item3, this.item4});

  factory GridItem.fromJson(Map<String,dynamic> map){
    print('GridItem get $map');
    return GridItem(startColor: map['startColor'],
    endColor: map['endColor'],
    mainItem: CommonModel.fromJson(map['mainItem']),
    item1: CommonModel.fromJson(map['item1']),
    item2: CommonModel.fromJson(map['item2']),
    item3: CommonModel.fromJson(map['item3']),
    item4: CommonModel.fromJson(map['item4']),
    );
  }

  Map<String,dynamic> toJson(){
    Map<String,dynamic> data = Map<String,dynamic>();
    data['startColor']=startColor;
    data['endColor']=endColor;
    data['mainItem']=mainItem.toJson();
    data['item1']=item1.toJson();
    data['item2']=item2.toJson();
    data['item3']=item3.toJson();
    data['item4']=item4.toJson();
    return data;
  }

}