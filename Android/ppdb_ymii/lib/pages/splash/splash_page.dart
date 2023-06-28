import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ppdb_ymii/data/data_auth.dart';
import 'package:ppdb_ymii/pages/auth/login_page.dart';
import 'package:ppdb_ymii/pages/beranda_page.dart';
import 'package:ppdb_ymii/pages/document/pilih_aplikasi_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  SplashPage({ Key? key }) : super(key: key);

  @override
  State<SplashPage> createState() => _SplachPagshtate();
}

class _SplachPagshtate extends State<SplashPage> {
  var _dataAuth;
  bool _application = false;
  bool _isAuth = false;
  Widget body = LoginPage();

    
  void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var token = localStorage.getString('token');

    _dataAuth = await DataAuth().getDataStorage();

    if (token != null) {
      setState(() {
        _isAuth = !_isAuth;
        if (_dataAuth['application'] == null) {
          _application = true;
        } else {
          _application = false;
        }
      });
    }

    setState(() {
      if (_isAuth) {
        if (_application) {
          body = PilihAplikasiPage();
        } else {
          body = BerandaPage();
        }
      } else {
        body = LoginPage();
      }
    });
  }
  
  @override
  void initState() {
    _checkIfLoggedIn();
    
    Timer(Duration(seconds: 3), () {
        Navigator.pushAndRemoveUntil(
          context, 
          MaterialPageRoute(builder: (context) => body),
          (route) => false,
        );  
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image(image: AssetImage("assets/images/logo.png"), height: 150, width: 150,),
            ),
            SizedBox(height: 19,),
            Container(
              child: Text("Y.M.I.I", style: TextStyle(color: Color(0xff0000FF), fontSize: 16, fontWeight: FontWeight.w700),),
            )
          ],
        ),
      ),
    );
  }
}