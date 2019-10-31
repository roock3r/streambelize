import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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