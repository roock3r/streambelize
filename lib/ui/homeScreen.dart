import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:streambelize/channels/Channel5View.dart';
import 'package:streambelize/channels/Channel7View.dart';
import 'package:streambelize/channels/ChannelView.dart';
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


class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}


class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final drawerItems = [
    new DrawerItem("Home Page", Icons.home),
    new DrawerItem("Channel 5", Icons.arrow_forward),
    new DrawerItem("Channel 7", Icons.arrow_forward),
    new DrawerItem("CTV 3", Icons.arrow_forward),
    new DrawerItem("Fiesta TV", Icons.arrow_forward),
    new DrawerItem("Krem TV", Icons.arrow_forward),
    new DrawerItem("Love TV", Icons.arrow_forward),
    new DrawerItem("Max TV", Icons.arrow_forward),
    new DrawerItem("Plus TV", Icons.arrow_forward),
    new DrawerItem("Vibes TV", Icons.arrow_forward),
    new DrawerItem("Wave TV", Icons.arrow_forward)

  ];

  final String title;

  @override
  _HomeScreenState createState() =>  _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool isSignedIn = false;
  String _name  = "";
  String _email = "";
  String _token = "";

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();


  @override
  void initState() {
    getTokenPreference().then(updateToken);
    getNamePreference().then(updateName);
    getEmailPreference().then(updateEmail);

    super.initState();

    _saveCurrentRoute("/HomeScreen");
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


  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new HomePage();
      case 1:
        return new Channel5(title: 'Channel 5',url: 'https://streambelize.com/hls/channel5.m3u8', color: Colors.lightGreenAccent);
      case 2:
        return new Channel7(title: 'Channel 7',url: 'https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_ts/master.m3u8',color: Colors.lightGreenAccent);
      case 3:
        return new Ctv3(title: 'CTV 3',url: 'https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_ts/master.m3u8',color: Colors.lightGreenAccent,);
      case 4:
        return new FiestaTv(title: 'Fiesta TV',url: 'https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_ts/master.m3u8',color: Colors.lightGreenAccent,);
      case 5:
        return new KremTv(title: 'KREM TV',url: 'https://streambelize.com/kremtv/b3c92z.m3u8',color: Colors.lightGreenAccent,);
      case 6:
        return new LoveTv(title: 'Love TV',url: 'https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_ts/master.m3u8', color: Colors.red,);
      case 7:
        return new MaxTv(title: 'Max TV',url: 'https://streambelize.com/maxtv/test.m3u8',color: Colors.lightGreenAccent,);
      case 8:
        return new PlusTv(title: 'Plus TV',url: 'https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_ts/master.m3u8',color: Colors.lightGreenAccent,);
      case 9:
        return new VibesTv(title: 'Vibes TV',url: 'https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_ts/master.m3u8',color: Colors.lightGreenAccent);
      case 10:
        return new WaveTv(title: 'Wave TV',url: 'https://streambelize.com/wavetv/3q8p9c.m3u8',color: Colors.redAccent);

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
          )
      );
    }

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Home"),
      ),
      drawer: new Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(_name.toUpperCase()),
                accountEmail: Text(_email),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: Image.network('http://www.gravatar.com/avatar/a6cc615ece03f1f1b42a4f4635065011?s=200&r=pg&d=mm').image,
                  backgroundColor:
                  Theme.of(context).platform == TargetPlatform.iOS
                      ? Colors.blue
                      : Colors.white,
                  child: Text(
                    _name.substring(0, 1),
                    style: TextStyle(fontSize: 40.0,),
                    
                  ),
                ),
              ),
              new Column(children: drawerOptions)
            ],
          )
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }

  void updateName(String name) {
    setState(() {
      this._name = name;
    });
  }

  void updateToken(String token) {
    setState(() {
      this._token = token;
    });
  }

  void updateEmail(String email) {
    setState(() {
      this._email = email;
    });
  }

}
