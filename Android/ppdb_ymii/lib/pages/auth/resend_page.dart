import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:ppdb_ymii/api/auth_api/resend_url.dart';
import 'package:ppdb_ymii/layouts/drawer_auth.dart';
import 'package:ppdb_ymii/layouts/footer.dart';
import 'package:http/http.dart' as http;
import 'package:ppdb_ymii/pages/auth/confirmation_page.dart';

class ResendPage extends StatefulWidget {
  ResendPage({Key? key}) : super(key: key);

  @override
  State<ResendPage> createState() => _ResendPageState();
}

class _ResendPageState extends State<ResendPage> {
  final _formKey = GlobalKey<FormState>();
  bool _formLoad = true;
  bool _loadConnection = false;
  Map _messages = {};
  
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();

  Future _resend() async {
    setState(() {
      _formLoad = false;
      _messages = {};
    });
    
    final response = await http.post(
      Uri.parse(resend_url),
      body: {
        "username": username.text,
        "email": email.text,
      }
    );

    print(response);

    setState(() {
      _formLoad = !_formLoad;
    });

    var body = jsonDecode(response.body);
    
    if (response.statusCode == 200) {
      return true;
    } else {
      final message = body;
      
      setState(() {
        _messages = message;
      });
      
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    
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
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _loadConnection ? null : AppBar(
          backgroundColor: Colors.blue,
          title: Text('Kirim Ulang Kode'),
        ),
        drawer: DrawerAuth(),
        body: RefreshIndicator(
          onRefresh: () {
            return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ResendPage()), (route) => false);
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Kirim Ulang Kode",
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
                                    enabled: _formLoad,
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
                                    controller: email,
                                    enabled: _formLoad,
                                    keyboardType: TextInputType.emailAddress,
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
                                    height: 30,
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
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 15,
                                      )
                                    ),
                                    onPressed: _formLoad ? () {
                                      if (_formKey.currentState!.validate()) {
                                        _resend().then((value) {
                                          if (value) {
                                            final snackBar = SnackBar(
                                              content: Text(
                                                "Berhasil mengirim email"
                                              ),
                                              action: SnackBarAction(
                                                label: "tutup",
                                                onPressed: () {},
                                              ),
                                            );
        
                                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
        
                                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ConfirmationPage()), (route) => false);
                                          } else {
                                            final snackBar = SnackBar(
                                              content: Text(
                                                'Gagal mengirim email'
                                              ),
                                              action: SnackBarAction(
                                                label: "tutup", 
                                                onPressed: () {}
                                              ),
                                            );
                                            
                                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                          }
                                        });
                                      }
                                    } : null,
                                    child: Text(
                                      'kirim',
                                    )
                                  ),
                                  SizedBox(
                                    height: 20,
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