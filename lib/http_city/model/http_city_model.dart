import 'package:http_city_future/http_city/model/base_model.dart';

class HttpCityModel extends BaseModel<HttpCityModel> {
  String description;
  String imageUrl;
  int statusCode;

  HttpCityModel({this.description, this.imageUrl, this.statusCode});

  HttpCityModel.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    imageUrl = json['imageUrl'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['imageUrl'] = this.imageUrl;
    data['statusCode'] = this.statusCode;
    return data;
  }

  @override
  HttpCityModel fromJson(Map<String, Object> json) {
    return HttpCityModel.fromJson(json);
  }
}
