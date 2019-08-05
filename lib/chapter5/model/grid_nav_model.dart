import 'package:flutter_go/chapter5/model/grid_item.dart';

class GridNavModel {
  final GridItem hotel;
  final GridItem flight;
  final GridItem travel;

  GridNavModel({this.hotel, this.flight, this.travel});

  factory GridNavModel.fromJson(Map<String, dynamic> map) {
    print('GridNavModel get $map');
    return GridNavModel(
      hotel: GridItem.fromJson(map['hotel']),
      flight: GridItem.fromJson(map['flight']),
      travel: GridItem.fromJson(map['travel']),
    );
  }

  Map<String,dynamic> toJson(){
    Map<String,dynamic> data = Map<String,dynamic>();
    data['hotel']=hotel.toJson();
    data['flight']=flight.toJson();
    data['travel']=travel.toJson();
    return data;
  }

}
