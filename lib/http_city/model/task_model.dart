import 'package:http_city_future/http_city/model/base_model.dart';

class TaskModel extends BaseModel<TaskModel> {
  int userId;
  int id;
  String title;
  bool completed;

  TaskModel({this.userId, this.id, this.title, this.completed});

  TaskModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    completed = json['completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['completed'] = this.completed;
    return data;
  }

  @override
  TaskModel fromJson(Map<String, Object> json) {
    return TaskModel.fromJson(json);
  }
}
