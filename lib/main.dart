import 'package:flutter/material.dart';
import 'package:streambelize/ui/ScaffoldScreen.dart';
import 'package:streambelize/ui/homeScreen.dart';
//import 'package:streambelize/ui/loginScreen.dart';
//import 'package:streambelize/ui/splashScreen.dart';
import 'package:streambelize/ui/SigninScreen.dart';
import 'package:streambelize/ui/MaterialSplashScreen.dart';

//void main() => runApp(StreamBelizeApp());
void main() => runApp(StreamBelizeApp());

class StreamBelizeApp extends StatelessWidget {
  var _splashShown = false;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream Belize Live ',
      routes: <String, WidgetBuilder>{
//        "/HomeScreen": (BuildContext context) => HomeScreen(title: 'Stream Belize Live',),
//        "/LoginScreen": (BuildContext context) => LoginScreen(),
        "/SigninScreen": (BuildContext context) => SigninScreen(),
        "/ScaffoldScreen": (BuildContext context) => ScaffoldScreen(),
    },

      home: MaterialSplashScreen(),
    );
  }
}