import 'package:http_city_future/http_city/model/task_model.dart';

import '../model/http_city_model.dart';

abstract class IHttpCityService {
  Future<List<HttpCityModel>> getHttpList();
  Future<List<TaskModel>> getTaskList();
}
