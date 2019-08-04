//String startColor	String	NonNull
import 'package:flutter_go/chapter5/model/CommonModel.dart';

////String endColor	String	NonNull
////CommonModel mainItem	Object	NonNull
////CommonModel item1	Object	NonNull
////CommonModel item2	Object	NonNull
////CommonModel item3	Object	NonNull
////CommonModel item4	Object	NonNull

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
    return GridItem(startColor: map['startColor'],
    endColor: map['endColor'],
    mainItem: CommonModel.fromJson(map['mainItem']),
    item1: CommonModel.fromJson(map['item1']),
    item2: CommonModel.fromJson(map['item2']),
    item3: CommonModel.fromJson(map['item3']),
    item4: CommonModel.fromJson(map['item4']),
    );
  }



}