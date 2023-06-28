import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RedirectAuth {
  var _token;

  _getToken() async {
    SharedPreferences _localStorage = await SharedPreferences.getInstance();
    _token = jsonDecode(_localStorage.getString('token').toString());

    return _token;
  }
  
  auth(context, redirect) async {
    if (await _getToken() != null) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => redirect), (route) => false);
    }
  }

  guest(context, redirect) async {
    if (await _getToken() == null) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => redirect), (route) => false);
    }
  }
}