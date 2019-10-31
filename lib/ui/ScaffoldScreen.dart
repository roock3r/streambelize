import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:streambelize/channels/Channel5View.dart';
import 'package:streambelize/channels/Channel7View.dart';
import 'package:streambelize/channels/Ctv3View.dart';
import 'package:streambelize/channels/FiestaTvView.dart';
import 'package:streambelize/channels/KremTvView.dart';
import 'package:streambelize/channels/LoveTvView.dart';
import 'package:streambelize/channels/MaxTvView.dart';
import 'package:streambelize/channels/PlusTvView.dart';
import 'package:streambelize/channels/VibesTvView.dart';
import 'package:streambelize/channels/WaveTvView.dart';
import 'package:streambelize/channels/HomeView.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:streambelize/common/functions/getToken.dart';
import 'package:streambelize/common/apifunctions/requestLogoutAPI.dart';
import 'package:streambelize/ui/SigninScreen.dart';


class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class ScaffoldScreen extends StatefulWidget {
//  ScaffoldScreen({Key key, this.title}) : super(key: key);

  final drawerItems = [
    new DrawerItem("Home Page", Icons.home),
    new DrawerItem("Channel 5", Icons.arrow_forward),
    new DrawerItem("Channel 7", Icons.arrow_forward),
    new DrawerItem("Love TV", Icons.arrow_forward),
    new DrawerItem("Krem TV", Icons.arrow_forward),
    new DrawerItem("Plus TV", Icons.arrow_forward),
    new DrawerItem("CTV3 TV", Icons.arrow_forward),
    new DrawerItem("Vibes TV", Icons.arrow_forward),
    new DrawerItem("Wave TV", Icons.arrow_forward),
    new DrawerItem("MAX TV", Icons.arrow_forward),
    new DrawerItem("Fiesta TV", Icons.arrow_forward)

  ];

//  final String title;

  @override
  _ScaffoldScreenState createState() => _ScaffoldScreenState();
}

class _ScaffoldScreenState extends State<ScaffoldScreen> {

  bool isSignedIn = false;
  bool isAuthorized = false;
  int _selectedDrawerIndex = 0;
  String _name  = "";
  String _email = "";
  String _token = "";


  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
//    getTokenPreference().then(updateToken);
//    getNamePreference().then(updateName);
//    getEmailPreference().then(updateEmail);
    _saveCurrentRoute("/ScaffoldScreen");
    firebaseCloudMessaging_Listeners();


  }

  //Modifcation starts here

  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging.getToken().then((token){
      print(token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true)
    );
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings)
    {
      print("Settings registered: $settings");
    });
  }


  Widget _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new HomePage();
      case 1:
        return new Channel5(title: 'Channel 5',url: 'https://test.antmedia.io:5443/LiveApp/streams/867503970567813339763778.m3u8', color: Colors.lightBlue);
      case 2:
        return new Channel7(title: 'Channel 7',url: 'https://record.streambelize.live/LiveApp/streams/930413663553097102911106.mp4',color: Colors.lightBlue);
      case 3:
        return new LoveTv(title: 'Love TV',url: 'https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_ts/master.m3u8', color: Colors.red,);
      case 4:
        return new KremTv(title: 'KREM TV',url: 'https://streambelize.com/kremtv/b3c92z.m3u8',color: Colors.lightBlue,);
      case 5:
        return new PlusTv(title: 'Plus TV',url: 'https://streambelize.com/plustv/8v9r4k.m3u8',color: Colors.lightBlue,);
      case 6:
        return new Ctv3(title: 'CTV 3',url: 'https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_ts/master.m3u8',color: Colors.lightBlue,);
      case 7:
        return new VibesTv(title: 'Vibes TV',url: 'https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_ts/master.m3u8',color: Colors.lightBlue);
      case 8:
        return new WaveTv(title: 'Wave TV',url: 'https://streambelize.com/wavetv/3q8p9c.m3u8',color: Colors.redAccent);
      case 9:
        return new MaxTv(title: 'Max TV',url: 'https://streambelize.com/maxtv/test.m3u8',color: Colors.lightBlue,);
      case 10:
        return new FiestaTv(title: 'Fiesta TV',url: 'https://streambelize.com/fiesta/a1s2d3.m3u8',color: Colors.lightBlue,);

      default:
        return new Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }
  //modification ends here
  _saveCurrentRoute(String lastRoute) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('LastScreenRoute', lastRoute);
  }

  void updateName(String name) {
    setState(() {
      this._name = name;
      print("AUTH STATE CHANGED NAME '$_name' ");
    });
  }

  void updateToken(String token) {
    setState(() {
      this._token = token;
      print("AUTH STATE CHANGED TOKEN '$_token' ");
    });
  }

  void updateEmail(String email) {
    setState(() {
      this._email = email;
      print("AUTH STATE CHANGED EMAIL '$_email' ");
    });
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
    List<Widget> drawerOptions = [];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(
          new ListTile(
            leading: new Icon(d.icon),
            title: new Text(d.title),
            selected: i == _selectedDrawerIndex,
            onTap: () => _onSelectItem(i),
          ),

      );
    }

//    return WillPopScope(
//      onWillPop: () => _exitApp(context),
//      child: Scaffold(
//            appBar: AppBar(
//              // Here we take the value from the MyHomePage object that was created by
//              // the App.build method, and use it to set our appbar title.
//              title: Text("Stream Belize Live"),
//            ),
//            drawer: new Drawer(
//                child: ListView(
//                  padding: EdgeInsets.zero,
//                  children: <Widget>[
//                    UserAccountsDrawerHeader(
//                      accountName: Text(_name.toUpperCase()),
//                      accountEmail: Text(_email),
//                      currentAccountPicture: CircleAvatar(
//                        backgroundImage: Image.network('http://www.gravatar.com/avatar/a6cc615ece03f1f1b42a4f4635065011?s=200&r=pg&d=mm').image,
//                        backgroundColor:
//                        Theme.of(context).platform == TargetPlatform.iOS
//                            ? Colors.blue
//                            : Colors.white,
//                        child: Text(
//                          _name.substring(0, 1),
//                          style: TextStyle(fontSize: 40.0,),
//
//                        ),
//                      ),
//                    ),
//                    new Column(children: drawerOptions),
//
//
//                    ListTile(title: Text("About", style: TextStyle(
//                        color: Colors.black, fontSize: 20.0),),
//                      onTap: () {
//                        SystemChannels.textInput.invokeMethod('TextInput.hide');
////              Here I have not implemented an actual about screen, but if you did you would navigate to it's route
////              Navigator.of(context).pushReplacementNamed('/AboutScreen');
//                      },
//                    ),
//                    ListTile(title: Text("Logout", style: TextStyle(
//                        color: Colors.black, fontSize: 20.0),),
//                      onTap: () {
//                        requestLogoutAPI(context);
//                        Navigator.of(context).pushReplacementNamed('/SigninScreen');
//                      },
//                    )
//
//
//                  ],
//                )
//            ),
//            body: _getDrawerItemWidget(_selectedDrawerIndex),
//          ),
//        );
//    );

    return WillPopScope(
      onWillPop: () => _exitApp(context),
      child: FutureBuilder<bool>(
        future: showLoginPage(),
        builder: (buildContext, snapshot) {
          if(snapshot.hasData) {
            if(snapshot.data){
              // Return your login here
              return SigninScreen();
            }

            // Return your home here
            return Scaffold(
              appBar: AppBar(
                // Here we take the value from the MyHomePage object that was created by
                // the App.build method, and use it to set our appbar title.
                title: Text("Stream Belize Live"),
              ),
              drawer: new Drawer(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      UserAccountsDrawerHeader(
                        accountName: Text("Test".toUpperCase()),
                        accountEmail: Text("Test@testmail.com"),
                        currentAccountPicture: CircleAvatar(
                          backgroundImage: Image.network('http://www.gravatar.com/avatar/a6cc615ece03f1f1b42a4f4635065011?s=200&r=pg&d=mm').image,
                          backgroundColor:
                          Theme.of(context).platform == TargetPlatform.iOS
                              ? Colors.blue
                              : Colors.white,
                          child: Text(
                            "test".substring(0, 1),
                            style: TextStyle(fontSize: 40.0,),

                          ),
                        ),
                      ),
                      new Column(children: drawerOptions),


                      ListTile(title: Text("About", style: TextStyle(
                          color: Colors.black, fontSize: 20.0),),
                        onTap: () {
                          SystemChannels.textInput.invokeMethod('TextInput.hide');
//              Here I have not implemented an actual about screen, but if you did you would navigate to it's route
//              Navigator.of(context).pushReplacementNamed('/AboutScreen');
                        },
                      ),
                      ListTile(title: Text("Logout", style: TextStyle(
                          color: Colors.black, fontSize: 20.0),),
                        onTap: () {
                          requestLogoutAPI(context);
                          Navigator.of(context).pushReplacementNamed('/SigninScreen');
                        },
                      )
                    ],
                  )
              ),
              body: _getDrawerItemWidget(_selectedDrawerIndex),
            );
          } else {

            // Return loading screen while reading preferences
            return Center(child: CircularProgressIndicator());
          }
        },
      )


//      child: Builder(
//        builder: (BuildContext buildContext) => !isSignedIn
//            ? SigninScreen()
//            : Scaffold(
//          appBar: AppBar(
//            // Here we take the value from the MyHomePage object that was created by
//            // the App.build method, and use it to set our appbar title.
//            title: Text(widget.title),
//          ),
//          drawer: new Drawer(
//              child: ListView(
//                padding: EdgeInsets.zero,
//                children: <Widget>[
//                  UserAccountsDrawerHeader(
//                    accountName: Text(_name.toUpperCase()),
//                    accountEmail: Text(_email),
//                    currentAccountPicture: CircleAvatar(
//                      backgroundImage: Image.network('http://www.gravatar.com/avatar/a6cc615ece03f1f1b42a4f4635065011?s=200&r=pg&d=mm').image,
//                      backgroundColor:
//                      Theme.of(context).platform == TargetPlatform.iOS
//                          ? Colors.blue
//                          : Colors.white,
//                      child: Text(
//                        _name.substring(0, 1),
//                        style: TextStyle(fontSize: 40.0,),
//
//                      ),
//                    ),
//                  ),
//                  new Column(children: drawerOptions),
//
//
//                  ListTile(title: Text("About", style: TextStyle(
//                      color: Colors.black, fontSize: 20.0),),
//                    onTap: () {
//                      SystemChannels.textInput.invokeMethod('TextInput.hide');
////              Here I have not implemented an actual about screen, but if you did you would navigate to it's route
////              Navigator.of(context).pushReplacementNamed('/AboutScreen');
//                    },
//                  ),
//                  ListTile(title: Text("Logout", style: TextStyle(
//                      color: Colors.black, fontSize: 20.0),),
//                    onTap: () {
//                      requestLogoutAPI(context);
//                      Navigator.of(context).pushReplacementNamed('/SigninScreen');
//                    },
//                  )
//
//
//                ],
//              )
//          ),
//          body: _getDrawerItemWidget(_selectedDrawerIndex),
//        ),
//      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
