import 'package:flutter/material.dart';
import 'package:streambelize/common/platform/platformScaffold.dart';
import 'package:streambelize/common/widgets/basicDrawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: AppBar(title: Text("Home Screen", style: TextStyle(color: Colors
          .black),),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation:
        Theme
            .of(context)
            .platform == TargetPlatform.iOS ? 0.0 : 6.0,
      ),
      drawer:
      BasicDrawer(),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Text("Something here"),

            ],
          ),
        ),
      ),
    );
  }
}