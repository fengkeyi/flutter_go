//ConfigModel config	Object	NonNull
//List<CommonModel> bannerList	Array	NonNull
//List<CommonModel> localNavList	Array	NonNull
//GridNavModel gridNav	Object	NonNull
//List<CommonModel> subNavList	Array	NonNull
//SalesBoxModel salesBox	Object	NonNull


import 'package:flutter_go/chapter5/model/CommonModel.dart';
import 'package:flutter_go/chapter5/model/ConfigModel.dart';
import 'package:flutter_go/chapter5/model/GridNavModel.dart';
import 'package:flutter_go/chapter5/model/SalesBoxModel.dart';

class HomeModel{

  final ConfigModel configModel;
  final List<CommonModel> bannerList;
  final List<CommonModel> localNavList;
  final List<CommonModel> subNavList;
  final GridNavModel gridNav;
  final SalesBoxModel salesBox;

  HomeModel({this.configModel, this.bannerList, this.localNavList, this.subNavList, this.gridNav, this.salesBox});

  factory HomeModel.fromJson(Map<String,dynamic> map){
    return HomeModel(
      configModel: ConfigModel.fromJson(map['']),
      bannerList: ConfigModel.fromJson(map['']),
      localNavList: ConfigModel.fromJson(map['']),
      subNavList: ConfigModel.fromJson(map['']),
      gridNav: ConfigModel.fromJson(map['']),
      salesBoxModel: ConfigModel.fromJson(map['']),
    );
  }




}