import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:ppdb_ymii/layouts/drawer_auth.dart';
import 'package:ppdb_ymii/layouts/footer.dart';
import 'package:ppdb_ymii/api/auth_api/login_url.dart';
import 'package:http/http.dart' as http;
import 'package:ppdb_ymii/pages/beranda_page.dart';
import 'package:ppdb_ymii/pages/document/pilih_aplikasi_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _formLoad = true;
  bool _loadConnection = false;
  Map _messages = {};
  var _application;

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  Future _login() async {
    setState(() {
      _formLoad = false;
      _messages = {'message': null};
    });


    final response = await http.post(
      Uri.parse(login_url),
      body: {
        "username" : username.text,
        "password" : password.text,
      },
    );

    setState(() {
      _formLoad = true;
    });

    var body = json.decode(response.body);

    if (response.statusCode == 200) {
      
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['data']['token']));
      localStorage.setString('user', json.encode(body['data']['user_data']));
      localStorage.setString('application', json.encode(body['data']['user_data']['application']));
      setState(() {
        _application = jsonDecode(localStorage.getString('application').toString());
      });

      final snackBar = SnackBar(
        content: const Text('Anda Berhasil Login'),
        action: SnackBarAction(
          label: 'tutup',
          onPressed: () {},
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      
      if (_application == null) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PilihAplikasiPage()), (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => BerandaPage()), (route) => false);
      }
    } else {
      
      final message = body;

      setState(() {
        _messages = message;
      });
      
      final snackBar = SnackBar(
        content: const Text('Login Gagal'),
        action: SnackBarAction(
          label: 'tutup',
          onPressed: () {},
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void initState() {
    _messages;
    
    InternetConnectionChecker().onStatusChange.listen(
      (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            setState(() {
              _loadConnection = false;
            });
            final snackBar = SnackBar(
              content: const Text('Anda Kembali Online'),
              action: SnackBarAction(
                label: 'tutup',
                onPressed: () {},
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          
            // ignore: avoid_print
            print('Data connection is available.');
            break;
          case InternetConnectionStatus.disconnected:
            // ignore: avoid_print
            final snackBar = SnackBar(
              content: const Text('Anda Sedang Offline, Periksa Kembali Jaringan Anda'),
              action: SnackBarAction(
                label: 'tutup',
                onPressed: () {},
              ),
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);

            setState(() {
              _loadConnection = true;
            });

            print('You are disconnected from the internet.');
            break;
        }
      },
    );
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _loadConnection ? null : AppBar(
          backgroundColor: Colors.blue,
          title: Text('Masuk'),
        ),
        drawer: DrawerAuth(),
        body: RefreshIndicator(
          onRefresh: () {
            return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
          },
          child: _loadConnection ? Center(child: CircularProgressIndicator(),) : ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Form(
                      key: _formKey,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline
                                ),
                              ),
                              SizedBox(
                                height: 30
                              ),
                              TextFormField(
                                controller: username,
                                style: TextStyle(
                                  color: _formLoad ? Colors.black : Colors.grey
                                ),
                                decoration: InputDecoration(
                                  hintText: "Username",
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15
                                  )
                                ),
                                enabled: _formLoad,
                                // ignore: body_might_complete_normally_nullable
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Username harus diisi";
                                  }
                                },
                              ),
                              SizedBox(
                                height: 20
                              ),
                              TextFormField(
                                controller: password,
                                style: TextStyle(
                                  color: _formLoad ? Colors.black : Colors.grey
                                ),
                                decoration: InputDecoration(
                                  hintText: "Kata Sandi",
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15
                                  ),
                                ),
                                enabled: _formLoad,
                                obscureText: true,
                                autocorrect: false,
                                enableSuggestions: false,
                                // ignore: body_might_complete_normally_nullable
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Kata Sandi harus diisi";
                                  }
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              _messages['message'] != null ?
                              Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    _messages['message'].toString(),
                                    style: TextStyle(
                                      color: Colors.red
                                    ),
                                  ),
                                ),
                              ) : SizedBox(),
                              SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                onPressed: !_formLoad ? null : () {
                                  if (_formKey.currentState!.validate()) {
                                  _login();
                                  }
                                }, 
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 15,
                                  ),
                                ),
                                child: Text(
                                  'masuk',
                                )
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    // Footer
                    copyRight
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}