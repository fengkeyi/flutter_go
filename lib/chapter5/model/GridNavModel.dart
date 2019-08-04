

import 'package:flutter_go/chapter5/model/GridItem.dart';

class GridNavModel {
  final GridItem hotel;
  final GridItem flight;
  final GridItem travel;

  GridNavModel({this.hotel, this.flight, this.travel});

  factory GridNavModel.fromJson(Map<String, dynamic> map) {
    return GridNavModel(
      hotel: GridItem.fromJson(map['hotel']),
      flight: GridItem.fromJson(map['flight']),
      travel: GridItem.fromJson(map['travel']),
    );
  }
}
