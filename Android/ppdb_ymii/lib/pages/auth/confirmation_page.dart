import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:ppdb_ymii/api/auth_api/confirmation_url.dart';
import 'package:ppdb_ymii/layouts/drawer_auth.dart';
import 'package:ppdb_ymii/layouts/footer.dart';
import 'package:http/http.dart' as http;
import 'package:ppdb_ymii/pages/auth/resend_page.dart';
import 'package:ppdb_ymii/pages/beranda_page.dart';
import 'package:ppdb_ymii/pages/document/pilih_aplikasi_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmationPage extends StatefulWidget {
  ConfirmationPage({Key? key}) : super(key: key);

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  final _formKey = GlobalKey<FormState>();
  bool _formLoad = true;
  bool _loadConnection = false;
  Map _messages = {}; 
  var _application;

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController token = TextEditingController();

  Future _confirmation() async {
    setState(() {
      _formLoad = false;
      _messages = {};
    });
    
    final response = await http.post(
      Uri.parse(confirmation_url),
      body: {
        "username": username.text,
        "email": email.text,
        "token": token.text,  
      }
    );

    setState(() {
      _formLoad = true;
    });

    var body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['data']['token']));
      localStorage.setString('user', json.encode(body['data']['user_data']));
      localStorage.setString('application', json.encode(body['data']['user_data']['application']));
      setState(() {
        _application = jsonDecode(localStorage.getString('application').toString());
      });

      final snackBar = SnackBar(
        content: const Text(
          'Akun anda berhasil di Aktifkan.'
        ),
        action: SnackBarAction(
          label: 'tutup',
          onPressed: () {}
        ),
      );
                  
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      if (_application == null) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PilihAplikasiPage()), (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => BerandaPage()), (route) => false);
      }
    } else {
      final message = jsonDecode(response.body);

      final snackBar = SnackBar(
        content: const Text(
          'Akun anda Gagal di Aktifkan.'
        ),
        action: SnackBarAction(
          label: 'tutup',
          onPressed: () {}
        ),
      );
                  
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      
      setState(() {
        _messages = message;
      });
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
          title: Text('Konfimasi & Aktifasi'),
        ),
        drawer: DrawerAuth(),
        body: RefreshIndicator(
          onRefresh: () {
            return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ConfirmationPage()), (route) => false);
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
                                      "Konfirmasi & Aktifasi",
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
                                    controller: username,
                                    decoration: InputDecoration(
                                      hintText: "Masukan Username Anda",
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15
                                      )
                                    ),
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
                                    keyboardType: TextInputType.emailAddress,
                                    enabled: _formLoad,
                                    controller: email,
                                    decoration: InputDecoration(
                                      hintText: "Masukan Email Anda",
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15
                                      )
                                    ),
                                    // ignore: body_might_complete_normally_nullable
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Email harus diisi";
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: 20
                                  ),
                                  TextFormField(
                                    enabled: _formLoad,
                                    controller: token,
                                    decoration: InputDecoration(
                                      hintText: "Masukan Kode Konfirmasi",
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15
                                      )
                                    ),
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    // ignore: body_might_complete_normally_nullable
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Kode konfirmasi harus diisi";
                                      }
                                    },
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
                                    height: 30,
                                  ),
                                  Center(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 15,
                                        )
                                      ),
                                      onPressed: _formLoad ? () {
                                        if (_formKey.currentState!.validate()) {
                                          _confirmation();
                                        }
                                      } : null, 
                                      child: Text(
                                        'Aktifkan',
                                      )
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: Text(
                                      '*Jika kode belum terkirim, klik',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        height: 1.5
                                      )
                                    ),
                                  ),
                                  Center(
                                    child: InkWell(
                                      child: Text(
                                        ' Kirim Ulang',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold
                                        )
                                      ),
                                      onTap: () {
                                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ResendPage()), (route) => false);
                                      },
                                    ),
                                  )
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