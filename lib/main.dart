import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

import 'home_view.dart';

void main() //entry point of ur code, where the app starts from
{
  runApp(
    DevicePreview(
      enabled: !kDebugMode,
      builder: (context) => MyApp(),
    ),
  );
} //a unique function that creates the root of the flutter tree and it is taking a widget called my App

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      // Application name . this overrides the build method and returns material app
      title: 'To Do App', // title  of the app
      // Application theme data, you can set the colors for the application as
      // you want
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(37, 43, 103, 1),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(37, 43, 103, 1),
          elevation: 0,
        ),
      ), //theme depicts how the app is displayed
      // A widget which will be started on application startup
      home: HomeView(),
    ); //home - the first page the user encounters, it can either take a stateful or stateless widget
  }
}
