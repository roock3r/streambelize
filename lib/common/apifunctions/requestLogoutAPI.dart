import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:streambelize/common/functions/getToken.dart';
import 'package:streambelize/common/functions/saveLogout.dart';
import 'package:streambelize/model/json/loginModel.dart';

Future<LoginModel> requestLogoutAPI(BuildContext context) async {
  final url = "http://streambelizelive.us-west-2.elasticbeanstalk.com/api/users/logout";

  var token;

  await getToken().then((result) {
    token = result;
  });
  saveLogout();
  final response = await http.post(
    url,
    headers: {HttpHeaders.authorizationHeader: "Token $token"},
  );

  if (response.statusCode == 200) {
    saveLogout();
    return null;
  } else {
    saveLogout();
    return null;
  }
}