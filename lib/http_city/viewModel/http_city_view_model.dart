import 'package:flutter/material.dart';

import '../model/http_city_model.dart';
import '../service/IHttp_city_service.dart';
import '../service/http_city_service.dart';
import '../view/http_city.dart';

abstract class HttpCityViewModel extends State<HttpCity> {
  bool isLoading = false;
  List<HttpCityModel> httpCity = [];

  IHttpCityService httpCityService;

  @override
  void initState() {
    super.initState();
    httpCityService = HttpCityService();
    callItems();
  }

  Future<void> callItems() async {
    changeLoading();
    await _getHttpCity();
    changeLoading();
    checkErrorList();
  }

  void checkErrorList() {
    if (httpCity.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          child: Text("Opps.. Something get Wrong"),
        ),
      );
    }
  }

  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  Future<void> _getHttpCity() async {
    httpCity = await httpCityService.getHttpList();
  }
}
