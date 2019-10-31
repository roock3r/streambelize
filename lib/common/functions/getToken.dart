import 'package:shared_preferences/shared_preferences.dart';

getToken() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  String getToken = await preferences.getString("LastToken");
  return getToken;
}

Future<String> getNamePreference()  async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String name = preferences.getString("LastUser");
  return name;
}

Future<String> getTokenPreference()  async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String token = preferences.getString("LastToken");
  return token;
}

Future<String> getEmailPreference()  async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String email = preferences.getString("LastEmail");
  return email;
}

Future<String> getUserIDPreference()  async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String userID = preferences.getString("LastUserId");
  return userID;
}

Future<String> getUserAvatarPreference()  async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String userAvatar = preferences.getString("LastUserAvatar");
  return userAvatar;
}


Future<bool> showLoginPage() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String token = preferences.getString("LastToken");
  return token == null;
}