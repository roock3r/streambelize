import 'package:shared_preferences/shared_preferences.dart';
import 'package:streambelize/model/json/loginModel.dart';

saveCurrentLogin(Map responseJson) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();


  var user;
  if ((responseJson != null && !responseJson.isEmpty)) {
    user = LoginModel.fromJson(responseJson).userName;
  } else {
    user = "";
  }
  var token = (responseJson != null && !responseJson.isEmpty) ? LoginModel.fromJson(responseJson).token : "";
  var email = (responseJson != null && !responseJson.isEmpty) ? LoginModel.fromJson(responseJson).email : "";
  var pk = (responseJson != null && !responseJson.isEmpty) ? LoginModel.fromJson(responseJson).userId : "";
  var avatar = (responseJson != null && !responseJson.isEmpty) ? LoginModel.fromJson(responseJson).userAvatar : "";

  await preferences.setString('LastUser', (user != null && user.length > 0) ? user : "");
  await preferences.setString('LastToken', (token != null && token.length > 0) ? token : "");
  await preferences.setString('LastEmail', (email != null && email.length > 0) ? email : "");
  await preferences.setString('LastUserId', (pk != null && pk.length > 0) ? pk : "");
  await preferences.setString('LastUserAvatar', (avatar != null && avatar.length > 0) ? avatar : "");

}