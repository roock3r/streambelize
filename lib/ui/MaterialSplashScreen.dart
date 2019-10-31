import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:streambelize/common/platform/platformScaffold.dart';
import 'package:streambelize/ui/ScaffoldScreen.dart';
import 'package:streambelize/ui/SigninScreen.dart';

class MaterialSplashScreen extends StatefulWidget {
  @override
  _MaterialSplashScreenState createState() => _MaterialSplashScreenState();
}

class _MaterialSplashScreenState extends State<MaterialSplashScreen> {
  final int splashDuration = 2;

  startTime() async {
    return Timer(
        Duration(seconds: splashDuration),
            () {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          Navigator.of(context).pushReplacementNamed('/SigninScreen');
//            navigateToHomeScreen();
        }
    );
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          decoration: BoxDecoration(color: Colors.redAccent),
          child: Column(
            children: <Widget>[
              Expanded(child:
              Container(decoration: BoxDecoration(color: Colors.blueAccent),
                alignment: FractionalOffset(0.5, 0.3),
                child:
                Text("Stream Belize Live", style: TextStyle(fontSize: 40.0, color: Colors.white),),
              ),
              ),
              Container(margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 30.0),
                child:
                Text("© Copyright Stream Belize Live 2019", style: TextStyle(fontSize: 16.0, color: Colors.white,),
                ),
              ),
            ],
          )
      ),
    );
  }
//  void navigateToHomeScreen() {
//    /// Push home screen and replace (close/exit) splash screen.
//    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => new SigninScreen()));
//  }
}
