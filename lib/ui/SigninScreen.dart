import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:streambelize/common/apifunctions/requestLoginAPI.dart';
import 'package:streambelize/common/functions/showDialogSingleButton.dart';
//import 'package:streambelize/common/platform/platformScaffold.dart';
//import 'package:streambelize/common/widgets/basicDrawer.dart';
import 'package:streambelize/common/functions/helpers.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;

const URL = "http://streambelize.live/";

class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {

  bool _isLoading = false;

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _welcomeString = "";

  Future launchURL(String url) async {
    if(await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true);
    } else {
      showDialogSingleButton(context, "Unable to reach your website.", "Currently unable to reach the website $URL. Please try again at a later time.", "OK");
    }
  }

  @override
  void initState() {
    super.initState();
    _saveCurrentRoute("/SigninScreen");
  }

  _saveCurrentRoute(String lastRoute) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('LastScreenRoute', lastRoute);
  }

  Future<bool> _exitApp(BuildContext context) {
    return showDialog(
      context: context,
      child: new AlertDialog(
        title: new Text('Do you want to exit this application?'),
        content: new Text('We hate to see you leave...'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Yes'),
          ),
        ],
      ),
    ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _exitApp(context),
      child: Material(
        child: Scaffold(
          appBar:  AppBar(
            title: Text("LOGIN",
              style: TextStyle(fontSize: 30.0, color: Colors.white,),
            ),
            centerTitle: true,
            backgroundColor: Colors.blue,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          body: Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
              child: ListView(
                children: <Widget>[
                  Container(alignment: Alignment.topCenter,
                      child: Padding(padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 15.0),
                        child: Text("Stream Belize Live", style: TextStyle(fontSize: 40.0, color: Colors.black),),
                      )
                  ),

                  Padding(padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 78.0),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'This is the logon screen. If you would like to search for something you can go to ',
                            style: new TextStyle(fontSize: 20.0, color: Colors.black, ),
                          ),
                          TextSpan(
                            text: 'StreamBelize',
                            style: TextStyle(fontSize: 20.0, color: Colors.blueAccent, decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launchURL(URL);
                              },
                          ),
                          TextSpan(
                            text: '. Normally this link would probably be to the applications corporate website.',
                            style: new TextStyle(fontSize: 20.0, color: Colors.black, ),
                          ),
                        ],
                      ),
                    ),
                  ),


                  Text("Email", style: TextStyle(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.bold, ),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                    child: TextField(
                      controller: _userNameController,
                      decoration: InputDecoration(
                        hintText: "Enter your email",
                      ),
                      style: TextStyle(fontSize: 18.0, color: Colors.grey, fontWeight: FontWeight.bold, ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 35.0, 0.0, 0.0),
                    child: Text("Password", style: TextStyle(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.bold, ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                    child: TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: 'Your password, keep it secret, keep it safe.',
                      ),
                      obscureText: true,
                      style: TextStyle(fontSize: 18.0, color: Colors.grey, fontWeight: FontWeight.bold,),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
                    child: Container(height: 65.0,
                      child: RaisedButton(
                        onPressed: () {
                          setState(() {
                            _isLoading = true;
                          });
                          SystemChannels.textInput.invokeMethod('TextInput.hide');
                          requestLoginAPI(context, _userNameController.text, _passwordController.text);
                        },
                        child: Text("LOGIN",
                            style: TextStyle(color: Colors.white,
                                fontSize: 22.0)
                        ),
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}
