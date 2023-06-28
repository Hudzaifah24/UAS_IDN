import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:ppdb_ymii/api/application_api/pilih_aplication_url.dart';
import 'package:ppdb_ymii/data/data_auth.dart';
import 'package:ppdb_ymii/layouts/drawer_pilih_aplikasi.dart';
import 'package:ppdb_ymii/layouts/footer.dart';
import 'package:http/http.dart' as http;
import 'package:ppdb_ymii/pages/beranda_page.dart';

class PilihAplikasiPage extends StatefulWidget {
  PilihAplikasiPage({Key? key}) : super(key: key);

  @override
  State<PilihAplikasiPage> createState() => _PilihAplikasiPageState();
}

class _PilihAplikasiPageState extends State<PilihAplikasiPage> {
  final _formKey = GlobalKey<FormState>();
  bool _formLoad = true;
  bool _loadConnection = false;
  Map _messages = {};
  String _status = 'pp';
  String _token = '';

  void _getDataAuth() async {
    var dataAuth = await DataAuth().getDataStorage();

    setState(() {
      _token = dataAuth['token'];
    });
  }

  Future _pilihAplikasi() async {
    setState(() {
      _formLoad = false;
      _messages = {'message': null};
    });

    final response = await http.post(
      Uri.parse(pilih_aplication_url),
      body: {
        "status" : _status,
      },
      headers: {
        'Authorization' : 'Bearer $_token'
      }
    );

    setState(() {
      _formLoad = true;
    });

    var body = json.decode(response.body);

    print(response);
    
    if (response.statusCode == 200) {
      final snackBar = SnackBar(
        content: const Text('Anda Berhasil Menentukan Jenis Pendaftaran Anda'),
        action: SnackBarAction(
          label: 'tutup',
          onPressed: () {},
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => BerandaPage()), (route) => false);
    } else {
      final snackBar = SnackBar(
        content: const Text('Menentukan Jenis Pendaftaran Anda Gagal'),
        action: SnackBarAction(
          label: 'tutup',
          onPressed: () {},
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      final message = body;

      setState(() {
        _messages = message;
      });
      
      return false;
    }
  }

  @override
  void initState() {
    _messages;
    _getDataAuth();

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
          title: Text('Pilih Jenis Pendaftaran'),
        ),
        drawer: DrawerPilihAplikasi(),
        body: RefreshIndicator(
          onRefresh: () {
            return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PilihAplikasiPage()), (route) => false);
          },
          child: _loadConnection ? Center(child: CircularProgressIndicator()) : ListView(
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
                                "Pilih Jenis Pendaftaran",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline
                                ),
                              ),
                              SizedBox(
                                height: 30
                              ),
                              Row(
                                children: [
                                  Radio(
                                    value: 'pp',
                                    groupValue: _status,
                                    onChanged: (value) {
                                      setState(() {
                                        _status = 'pp';
                                      });
                                    },
                                  ),
                                  Text(
                                    "Pulang Pergi"
                                  )
                                ]
                              ),
                              Row(
                                children: [
                                  Radio(
                                    value: 'pondok',
                                    groupValue: _status,
                                    onChanged: (value) {
                                      setState(() {
                                        _status = 'pondok';
                                      });
                                    },
                                  ),
                                  Text(
                                    "Pondok"
                                  )
                                ]
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
                                  _pilihAplikasi();
                                  }
                                }, 
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 15,
                                  ),
                                ),
                                child: Text(
                                  'Tentukan',
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