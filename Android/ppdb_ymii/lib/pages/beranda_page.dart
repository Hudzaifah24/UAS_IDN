import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:ppdb_ymii/data/data_auth.dart';
import 'package:ppdb_ymii/layouts/drawer_main.dart';
import 'package:ppdb_ymii/layouts/footer.dart';
import 'package:ppdb_ymii/layouts/app_bar_main.dart';
import 'package:ppdb_ymii/api/progress_api/count_progress_url.dart';
import 'package:http/http.dart' as http;

class BerandaPage extends StatefulWidget {
  BerandaPage({Key? key}) : super(key: key);

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  Map user = {};
  bool _isLoadProgress = true;
  bool _loadConnection = false;
  Color? color;
  Widget icon = Icon(Icons.abc);
  var token;
  var _countProgress;
  var _pembayaran;
  var _akteKelahiran;
  var _kartuKeluarga;
  var _ktpAyah;
  var _ktpIbu;
  var _ijazah;

  Future _getCountProgress() async {
    var dataAuth = await DataAuth().getDataStorage();
    setState(() {
      user = dataAuth["user_authenticated"];
      token = dataAuth["token"];
    });
    
    final response = await http.get(
      Uri.parse(count_progress_url),
      headers: {
        "Authorization" : 'Bearer $token',
      }
    );

    if (response.statusCode == 200) {
      setState(() {
        _isLoadProgress = false;
      });
    }

    final body = jsonDecode(response.body);

    setState(() {
      _countProgress = body['data']['progress'];
      _pembayaran = body['data']['application']['bukti_pembayaran'];
      _akteKelahiran = body['data']['application']['akte_kelahiran'];
      _kartuKeluarga = body['data']['application']['kartu_keluarga'];
      _ktpAyah = body['data']['application']['ktp_ayah'];
      _ktpIbu = body['data']['application']['ktp_ibu'];
      _ijazah = body['data']['application']['ijazah_terakhir'];

      if (int.parse(_countProgress.toString()) == 0) {
        color = Colors.red;
        icon = Icon(
          Icons.bar_chart_sharp,
          color: Colors.red,
          size: 15,
        );
      } else if (int.parse(_countProgress.toString()) <= 99) {
        color = Colors.blue;
        icon = Icon(
          Icons.miscellaneous_services_outlined,
          color: Colors.blue,
          size: 15,
        );
      } else if (int.parse(_countProgress.toString()) == 100) {
        color = Colors.green;
        icon = Icon(
          Icons.auto_awesome_rounded,
          color: Colors.green,
          size: 15,
        );
      }
    });
  }

  @override
  void initState() {
    _getCountProgress();

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
          drawer: _loadConnection ? null : DrawerMain(),
          appBar: appBarMain("Beranda"),
          body: _isLoadProgress ? Center(child: CircularProgressIndicator()) : RefreshIndicator(
            onRefresh: () {
            return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => BerandaPage()), (route) => false);
          },
            child: _loadConnection ? Center(child: CircularProgressIndicator()) : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 20
                  ),
                  child: Column(children: [
                Card(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Text(
                              'Informasi Singkat Profile',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text('Nama Lengkap',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                        SizedBox(height: 10),
                        Text(user["name"].toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                            )),
                        SizedBox(
                          height: 15,
                        ),
                        Text('Username',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                        SizedBox(height: 10),
                        Text(user["username"].toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                            )),
                        SizedBox(
                          height: 15,
                        ),
                        Text('Email',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                        SizedBox(height: 10),
                        Text(user["email"].toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                            )),
                        SizedBox(
                          height: 15,
                        ),
                        Text('Alamat',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                        SizedBox(height: 10),
                        Text(
                            user["alamat"] == null
                                ? '-'
                                : user["alamat"].toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                            )),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Card(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 15,
                            bottom: 10
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Progres',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              Spacer(),
                              icon,
                              SizedBox(
                                width: 5
                              ),
                              Text(
                                _countProgress.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: color,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Icon(
                              Icons.money,
                              color: _pembayaran != null ? Colors.green : Colors.grey,
                            ),
                            SizedBox(width: 10),
                            InkWell(
                              child: Text(
                                'Pembayaran',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                              )),
                              onTap: () {},
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.document_scanner_outlined,
                              color: _akteKelahiran != null ? Colors.green : Colors.grey,
                            ),
                            SizedBox(width: 10),
                            InkWell(
                              child: Text(
                                'Upload Akte Kelahiran',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                              )),
                              onTap: () {},
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.document_scanner,
                              color: _kartuKeluarga != null ? Colors.green : Colors.grey,
                            ),
                            SizedBox(width: 10),
                            InkWell(
                              child: Text(
                                'Upload Kartu Keluarga',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                              )),
                              onTap: () {},
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.add_card_outlined,
                              color: _ktpAyah != null ? Colors.green : Colors.grey,
                            ),
                            SizedBox(width: 10),
                            InkWell(
                              child: Text(
                                'Upload KTP Ayah',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                              )),
                              onTap: () {},
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.add_card_sharp,
                              color: _ktpIbu != null ? Colors.green : Colors.grey,
                            ),
                            SizedBox(width: 10),
                            InkWell(
                              child: Text(
                                'Upload KTP Ummi',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                              )),
                              onTap: () {},
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.book_rounded,
                              color: _ijazah != null ? Colors.green : Colors.grey,
                            ),
                            SizedBox(width: 10),
                            InkWell(
                              child: Text(
                                'Upload Ijazah Terakhir',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                              )),
                              onTap: () {},
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 25
                ),
                copyRight,
                SizedBox(
                  height: 25
                ),
                  ]),
                ),
              ],
            ),
          )),
    );
  }
}
