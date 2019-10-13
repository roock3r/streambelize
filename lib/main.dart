
import 'package:flutter/material.dart';
import 'package:streambelize/pages/HomePageView.dart';

import 'package:streambelize/ui/homeScreen.dart';
import 'package:streambelize/ui/loginScreen.dart';
import 'package:streambelize/ui/splashScreen.dart';



//void main() => runApp(StreamBelizeApp());
//
//class StreamBelizeApp extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Stream Belize',
//      theme: ThemeData(
//        // This is the theme of your application.
//        //
//        // Try running your application with "flutter run". You'll see the
//        // application has a blue toolbar. Then, without quitting the app, try
//        // changing the primarySwatch below to Colors.green and then invoke
//        // "hot reload" (press "r" in the console where you ran "flutter run",
//        // or simply save your changes to "hot reload" in a Flutter IDE).
//        // Notice that the counter didn't reset back to zero; the application
//        // is not restarted.
//        primarySwatch: Colors.lightBlue,
//      ),
//      home: BasePage(title: 'Stream Belize'),
//    );
//  }
//}

void main() => runApp(StreamBelizeApp());

class StreamBelizeApp extends StatelessWidget {
  var _splashShown = false;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream Belize',
      routes: <String, WidgetBuilder>{
        "/HomeScreen": (BuildContext context) => HomeScreen(),
        "/LoginScreen": (BuildContext context) => LoginScreen(),
    },
//      theme: ThemeData(
//        // This is the theme of your application.
//        //
//        // Try running your application with "flutter run". You'll see the
//        // application has a blue toolbar. Then, without quitting the app, try
//        // changing the primarySwatch below to Colors.green and then invoke
//        // "hot reload" (press "r" in the console where you ran "flutter run",
//        // or simply save your changes to "hot reload" in a Flutter IDE).
//        // Notice that the counter didn't reset back to zero; the application
//        // is not restarted.
//        primarySwatch: Colors.lightBlue,
//      ),
      home: SplashScreen(),
    );
  }
}