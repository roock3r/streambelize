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
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:streambelize/model/json/loginModel.dart';


class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}


class BasePage extends StatefulWidget {
  BasePage({Key key, this.title}) : super(key: key);

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
  _BasePageState createState() => _BasePageState();
}



class _BasePageState extends State<BasePage> {

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    firebaseCloudMessaging_Listeners();
  }
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
              title: Text(message['aps']['alert']['title']),
              subtitle: Text(message['aps']['alert']['body']),
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
        return new MyHomePage(title: 'Home');
      case 1:
        return new Channel5(title: 'Channel 5',url: 'https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_ts/master.m3u8', color: Colors.lightGreenAccent);
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
        title: Text(widget.title),
      ),
      drawer: new Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Cristian Silva"),
              accountEmail: Text("csilva@silvatech.org"),
              currentAccountPicture: CircleAvatar(
                backgroundColor:
                Theme.of(context).platform == TargetPlatform.iOS
                    ? Colors.blue
                    : Colors.white,
                child: Text(
                  "C",
                  style: TextStyle(fontSize: 40.0),
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
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;




  void _incrementCounter() {
    setState(() {

      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body:
      //3.put the player display in widget tree

        Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}