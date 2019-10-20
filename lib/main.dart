import 'package:flutter/material.dart';
import 'package:streambelize/ui/homeScreen.dart';
import 'package:streambelize/ui/loginScreen.dart';
import 'package:streambelize/ui/splashScreen.dart';


void main() => runApp(StreamBelizeApp());

class StreamBelizeApp extends StatelessWidget {
  var _splashShown = false;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream Belize Live ',
      routes: <String, WidgetBuilder>{
        "/HomeScreen": (BuildContext context) => HomeScreen(),
        "/LoginScreen": (BuildContext context) => LoginScreen(),
    },

      home: SplashScreen(),
    );
  }
}