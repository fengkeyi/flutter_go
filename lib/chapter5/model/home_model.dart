import 'package:flutter_go/chapter5/model/common_model.dart';
import 'package:flutter_go/chapter5/model/config_model.dart';
import 'package:flutter_go/chapter5/model/grid_nav_model.dart';
import 'package:flutter_go/chapter5/model/salesbox_model.dart';

class HomeModel{

  final ConfigModel config;
  final List<CommonModel> bannerList;
  final List<CommonModel> localNavList;
  final List<CommonModel> subNavList;
  final GridNavModel gridNav;
  final SalesBoxModel salesBox;

  HomeModel({this.config, this.bannerList, this.localNavList, this.subNavList, this.gridNav, this.salesBox});

  factory HomeModel.fromJson(Map<String,dynamic> map){

    List<CommonModel> bannerlist = (map['bannerList'] as List).map((i){
      return CommonModel.fromJson(i);
    }).toList();

    List<CommonModel> localList = (map['localNavList'] as List).map((i){
      return CommonModel.fromJson(i);
    }).toList();

    List<CommonModel> subList = (map['subNavList'] as List).map((i){
      return CommonModel.fromJson(i);
    }).toList();

    return HomeModel(
      config: ConfigModel.fromJson(map['config']),
      bannerList: bannerlist,
      localNavList: localList,
      subNavList: subList,
      gridNav: GridNavModel.fromJson(map['gridNav']),
      salesBox: SalesBoxModel.fromJson(map['salesBox']),
    );
  }

  Map<String,dynamic> toJson(){
    Map<String,dynamic> data = Map<String,dynamic>();
    data['config']=config.toJson();
    data['bannerList']=bannerList.map((model)=>model.toJson()).toList();
    data['localNavList']=localNavList.map((model)=>model.toJson()).toList();
    data['subNavList']=subNavList.map((model)=>model.toJson()).toList();
    data['gridNav']=gridNav.toJson();
    data['salesBox']=salesBox.toJson();
    return data;
  }

}