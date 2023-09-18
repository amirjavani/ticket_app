import 'package:flutter/material.dart';
import 'package:mogodb_project/LoginPage.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'dart:io' show Platform;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static String userName = '';
  static String host =
      Platform.environment['MONGO_DART_DRIVER_HOST'] ?? '127.0.0.1';
  static String port =
      Platform.environment['MONGO_DART_DRIVER_PORT'] ?? '27017';
  static var db = Db("mongodb://10.0.2.2:27017/mongo_dart-blog");
  static var db2 = Db("mongodb://10.0.2.2:27017/mongo_dart-blog");

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginPage());
  }
}
