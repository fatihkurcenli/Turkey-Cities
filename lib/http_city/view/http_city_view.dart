import 'package:flutter/material.dart';

import '../model/error_model.dart';
import '../model/http_city_model.dart';
import '../model/task_model.dart';
import '../viewModel/http_city_view_model.dart';

class HttpCityView extends HttpCityViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildFutureBuilderTaskModel(),
    );
  }

  FutureBuilder<List<TaskModel>> buildFutureBuilderTaskModel() {
    return FutureBuilder<List<TaskModel>>(
      future: httpCityService.getTaskList(),
      builder: (BuildContext context, AsyncSnapshot<List<TaskModel>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) => ListTile(
                  title: Text(snapshot.data[index].title),
                  trailing: Icon(Icons.check,
                      color: snapshot.data[index].completed
                          ? Colors.green
                          : Colors.grey),
                  subtitle: Text(
                    snapshot.data[index].userId.toString(),
                  ),
                ),
              );
            } else {
              final error = snapshot.error as ErrorModel;
              return Center(
                child: Text(error.text),
              );
            }
            break;
          default:
            return Text("Something went wrong");
        }
      },
    );
  }

  FutureBuilder<List<HttpCityModel>> buildFutureBuilder() {
    return FutureBuilder<List<HttpCityModel>>(
      future: httpCityService.getHttpList(),
      builder:
          (BuildContext context, AsyncSnapshot<List<HttpCityModel>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            if (snapshot.hasData) {
              return buildListViewHttp2(snapshot.data);
            } else {
              final error = snapshot.error as ErrorModel;
              return Center(
                child: Text(error.text),
              );
            }
            break;
          default:
            return Text("Something went Wrong !!");
        }
      },
    );
  }

  ListView buildListViewHttp() {
    return ListView.builder(
      itemCount: httpCity.length,
      itemBuilder: (context, index) => buildCardHttp(httpCity[index]),
    );
  }

  ListView buildListViewHttp2(List<HttpCityModel> city) {
    return ListView.builder(
      itemCount: city.length,
      itemBuilder: (context, index) => buildCardHttp(city[index]),
    );
  }

  Card buildCardHttp(HttpCityModel city) {
    return Card(
      margin: EdgeInsets.all(20),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.35,
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.network(city.imageUrl),
          ),
          subtitle: Text(
            city.description,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: appBarBuildText(),
      leading: buildPaddingProgress,
    );
  }

  Widget get buildPaddingProgress {
    return Visibility(
      visible: isLoading,
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }

  Text appBarBuildText() => Text("Turkey");
}
