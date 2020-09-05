import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_city_future/http_city/model/base_model.dart';
import 'package:http_city_future/http_city/model/error_model.dart';
import 'package:http_city_future/http_city/model/task_model.dart';

import '../model/http_city_model.dart';
import 'IHttp_city_service.dart';

class HttpCityService extends IHttpCityService {
  final baseUrl = "https://city-turkey.firebaseio.com/";
  final baseUrl2 = "https://jsonplaceholder.typicode.com";

  @override
  Future<List<HttpCityModel>> getHttpList() async {
    return await _httpGet<HttpCityModel>("$baseUrl/city.json", HttpCityModel());
  }

  @override
  Future<List<TaskModel>> getTaskList() async {
    return await _httpGet<TaskModel>("$baseUrl2/todos", TaskModel());
  }

  Future<dynamic> _httpGet<T extends BaseModel>(String path, T model) async {
    try {
      final response = await http.get(path);
      if (response is http.Response) {
        switch (response.statusCode) {
          case HttpStatus.ok:
            return _bodyParser<T>(response.body, model);
            break;
          default:
            throw ErrorModel(response.body);
        }
      }
      return response;
    } catch (e) {
      return ErrorModel("Link is not clear!!");
    }
  }

  dynamic _bodyParser<T extends BaseModel>(String body, BaseModel model) {
    final jsonBody = jsonDecode(body);
    if (jsonBody is List) {
      return jsonBody.map((e) => model.fromJson(e)).cast<T>().toList();
    } else if (jsonBody is Map) {
      return model.fromJson(jsonBody);
    } else {
      return jsonBody;
    }
  }
}
