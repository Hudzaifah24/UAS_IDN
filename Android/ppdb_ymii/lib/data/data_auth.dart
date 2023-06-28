import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class DataAuth {
  var _token;
  var _user_authenticated;
  var _application;

  getDataStorage() async {
    SharedPreferences _localStorage = await SharedPreferences.getInstance();
    _token = jsonDecode(_localStorage.getString('token').toString());
    _user_authenticated = jsonDecode(_localStorage.getString('user').toString());
    _application = jsonDecode(_localStorage.getString('application').toString());

    return {
      "token" : _token,
      "user_authenticated" : _user_authenticated,
      "application" : _application,
      "localStorage" : SharedPreferences.getInstance(),
    };
  }
}