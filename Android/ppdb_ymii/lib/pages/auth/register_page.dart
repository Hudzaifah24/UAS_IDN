import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:ppdb_ymii/api/auth_api/register_url.dart';
import 'package:ppdb_ymii/layouts/drawer_auth.dart';
import 'package:ppdb_ymii/layouts/footer.dart';
import 'package:http/http.dart' as http;
import 'package:ppdb_ymii/pages/auth/confirmation_page.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool agree = false;
  bool _formLoad = true;
  bool _loadConnection = false;
  Map _messages = {};

  void _onAgreed(bool? value) => setState(() {
    agree = value!;
  });

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController password_confirmation = TextEditingController();

  Future _register() async {
    setState(() {
      _formLoad = false;
      _messages = {};
    });

    final response = await http.post(
      Uri.parse(register_url),
      body: {
        "name" : name.text,
        "email" : email.text,
        "username" : username.text,
        "password" : password.text,
        "password_confirmation" : password_confirmation.text,
      }
    );

    setState(() {
      _formLoad = true;
    });
    
    if (response.statusCode == 200) {
      return true;
    } else {
      final message = jsonDecode(response.body);
      
      print(message);
      
      setState(() {
        _messages = message;
      });

      return false;
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
          title: Text('Daftar'),
        ),
        drawer: DrawerAuth(),
        body: RefreshIndicator(
          onRefresh: () {
            return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => RegisterPage()), (route) => false);
          },
          child: _loadConnection ? Center(child: CircularProgressIndicator()) : ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    Container(
                      child: Center(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Text(
                                      "Daftar",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30
                                  ),
                                  TextFormField(
                                    enabled: _formLoad,
                                    controller: name,
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15
                                      ),
                                      label: Text(
                                        'Nama Pendaftar'
                                      ),
                                    ),
                                    // ignore: body_might_complete_normally_nullable
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Nama Lengkap harus diisi";
                                      }
                                    },
                                  ),
                                  _messages['message'] != null && _messages['message']['name'] != null ?
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text(
                                      _messages['message']['name'][0].toString(),
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 13,
                                      ),
                                      textAlign: TextAlign.left,
                                      textDirection: TextDirection.ltr,
                                      overflow: TextOverflow.clip,
                                    ),
                                  ) : SizedBox(),
                                  SizedBox(
                                    height: 20
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    enabled: _formLoad,
                                    controller: email,
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15
                                      ),
                                      label: Text(
                                        'Email'
                                      ),
                                    ),
                                    // ignore: body_might_complete_normally_nullable
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Email harus diisi";
                                      }
                                    },
                                  ),
                                  _messages['message'] != null && _messages['message']['email'] != null ?
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text(
                                      _messages['message']['email'][0].toString(),
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 13,
                                      ),
                                      textAlign: TextAlign.left,
                                      textDirection: TextDirection.ltr,
                                      overflow: TextOverflow.clip,
                                    ),
                                  ) : SizedBox(),
                                  SizedBox(
                                    height: 20
                                  ),
                                  TextFormField(
                                    enabled: _formLoad,
                                    controller: username,
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15
                                      ),
                                      label: Text(
                                        'Username'
                                      ),
                                    ),
                                    // ignore: body_might_complete_normally_nullable
                                    validator: (value) {
                                    if (value!.isEmpty) {
                                        return "Username harus diisi";
                                      }
                                    },
                                  ),
                                  _messages['message'] != null && _messages['message']['username'] != null ?
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text(
                                      _messages['message']['username'][0].toString(),
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 13,
                                      ),
                                      textAlign: TextAlign.left,
                                      textDirection: TextDirection.ltr,
                                      overflow: TextOverflow.clip,
                                    ),
                                  ) : SizedBox(),
                                  SizedBox(
                                    height: 20
                                  ),
                                  TextFormField(
                                    enabled: _formLoad,
                                    controller: password,
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15
                                      ),
                                      label: Text(
                                        'Kata Sandi'
                                      ),
                                    ),
                                    // ignore: body_might_complete_normally_nullable
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Password harus diisi";
                                      }
                                    },
                                    obscureText: true,
                                    enableSuggestions: false,
                                    autocorrect: false
                                  ),
                                  _messages['message'] != null && _messages['message']['password'] != null ?
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text(
                                      _messages['message']['password'][0].toString(),
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 13,
                                      ),
                                      textAlign: TextAlign.left,
                                      textDirection: TextDirection.ltr,
                                      overflow: TextOverflow.clip,
                                    ),
                                  ) : SizedBox(),
                                  SizedBox(
                                    height: 20
                                  ),
                                  TextFormField(
                                    enabled: _formLoad,
                                    controller: password_confirmation,
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15
                                      ),
                                      label: Text(
                                        'Ulangi Kata Sandi'
                                      ),
                                    ),
                                    // ignore: body_might_complete_normally_nullable
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Ulangi Password harus diisi";
                                      }
                                    },
                                    obscureText: true,
                                    enableSuggestions: false,
                                    autocorrect: false
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: agree,
                                        onChanged: _onAgreed
                                      ),
                                      Text(
                                        "Setujui Syarat & Ketentuan",
                                        style: TextStyle(
                                          color: Colors.grey[800],
                                        )
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  
                                  Center(
                                    child: ElevatedButton(
                                      onPressed: agree && _formLoad ? () {
                                        if (_formKey.currentState!.validate()) {
                                          _register().then((value) {
                                            if (value) {
                                              final snackBar = SnackBar(
                                                content: const Text('Anda Berhasil Daftar'),
                                                action: SnackBarAction(
                                                  label: 'tutup',
                                                  onPressed: () {},
                                                ),
                                              );
                                  
                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                              
                                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ConfirmationPage()), (route) => false);
                                            } else {
                                              final snackBar = SnackBar(
                                                content: const Text('Daftar Gagal'),
                                                action: SnackBarAction(
                                                  label: 'tutup',
                                                  onPressed: () {},
                                                ),
                                              );
                                  
                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                            }
                                          });
                                        }
                                      } : null,
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 15,
                                        )
                                      ),
                                      child: Text(
                                        'daftar',
                                      )
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
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
