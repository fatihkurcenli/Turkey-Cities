import 'package:flutter/material.dart';

import 'http_city/view/http_city.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TURKEY",
      home: HttpCity(),
    );
  }
}
