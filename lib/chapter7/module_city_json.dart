// https://javiercbk.github.io/json_to_dart/
//http://zhouxunwang.cn/data/?id=104&key=UOCU8YM3S4z+ipiB9IMzQ2rJMwTgsJeZ/pxz7fk&ske=1
class CityModule {
  String reason;
  List<Result> result;
  int errorCode;

  CityModule({this.reason, this.result, this.errorCode});

  CityModule.fromJson(Map<String, dynamic> json) {
    reason = json['reason'];
    if (json['result'] != null) {
      result = new List<Result>();
      json['result'].forEach((v) {
        result.add(new Result.fromJson(v));
      });
    }
    errorCode = json['error_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reason'] = this.reason;
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    data['error_code'] = this.errorCode;
    return data;
  }
}

class Result {
  String id;
  String province;
  List<City> city;

  Result({this.id, this.province, this.city});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    province = json['province'];
    if (json['city'] != null) {
      city = new List<City>();
      json['city'].forEach((v) {
        city.add(new City.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['province'] = this.province;
    if (this.city != null) {
      data['city'] = this.city.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class City {
  String id;
  String city;
  List<District> district;

  City({this.id, this.city, this.district});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    city = json['city'];
    if (json['district'] != null) {
      district = new List<District>();
      json['district'].forEach((v) {
        district.add(new District.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['city'] = this.city;
    if (this.district != null) {
      data['district'] = this.district.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class District {
  String id;
  String district;

  District({this.id, this.district});

  District.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    district = json['district'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['district'] = this.district;
    return data;
  }
}