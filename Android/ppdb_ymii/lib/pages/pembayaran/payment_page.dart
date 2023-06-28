// ignore_for_file: unused_field
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:ppdb_ymii/api/application_api/pembayaran_url.dart';
import 'package:ppdb_ymii/data/data_auth.dart';
import 'package:ppdb_ymii/layouts/drawer_main.dart';
import 'package:ppdb_ymii/layouts/footer.dart';
import 'package:ppdb_ymii/layouts/app_bar_main.dart';
import 'package:ppdb_ymii/api/application_api/get_documents_url.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PaymentPage extends StatefulWidget {
  PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String token = '';
  bool _isLoad = true;
  bool _loadConnection = false;
  bool _isSend = false;
  var _bukti_pembayaran;
  var _typeApplication;
  Map user = {};
  Map _messages = {};
  Map application = {};

  TextEditingController buktiPembayaran = TextEditingController();

  void _getDataAuth() async {
    var dataAuth = await DataAuth().getDataStorage();
    
    setState(() {
      token = dataAuth["token"];
      user = dataAuth["user_authenticated"];
    });
  }

  Future _getDocuments() async {
    var dataAuth = await DataAuth().getDataStorage();
    
    setState(() {
      token = dataAuth["token"];
    });

    final response = await http.get(
      Uri.parse(get_documents),
      headers: {
        "Authorization" : 'Bearer $token',
      }
    );

    final body = jsonDecode(response.body);

    setState(() {
      _bukti_pembayaran = body['data']['bukti_pembayaran'];
      _typeApplication = body['data']['status'];
    });

    if (response.statusCode == 200) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('application', jsonEncode(body['data']));
      setState(() {
        _isLoad = false;
      });
    } else {
      setState(() {
        _isLoad = true;
      });
    }
  }

  Future _bukti(source) async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: source);
    //TO convert Xfile into file
    File file = File(image!.path);
    setState(() {
      _isSend = true;
    });

    print(file);

    final response = await http.MultipartRequest(
      "POST",
      Uri.parse(pembayaran_url),
    );

    response.headers['authorization'] = "Bearer $token";

    response.files.add(http.MultipartFile.fromBytes('bukti_pembayaran', File(file.path).readAsBytesSync(), filename: file.path));

    var res = await response.send();

    setState(() {
      _isSend = false;
    });

    if (res.statusCode == 200) {
      final snackBar = SnackBar(
        content: const Text('Berhasil Mengirim Bukti Pembayaran'),
        action: SnackBarAction(
          label: 'tutup',
          onPressed: () {},
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PaymentPage()), (route) => false);
    } else {
      final snackBar = SnackBar(
        content: const Text('Gagal Mengirim Bukti Pembayaran'),
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
    _getDocuments();
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
          drawer: DrawerMain(),
          appBar: _loadConnection ? null : appBarMain("Pembayaran"),
          body: _isLoad || _isSend 
          ? Center(child: CircularProgressIndicator()) 
          : RefreshIndicator(
            onRefresh: () {
            return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PaymentPage()), (route) => false);
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
                        Padding(
                          padding: EdgeInsets.only(
                            top: 15,
                            bottom: 10
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Informasi Aplikasi',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              SizedBox(height: 10),
                              Divider(),
                              SizedBox(height: 15),
                              Text('Jenis Aplikasi',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(height: 10),
                              Text(user["name"].toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Biaya yang harus dibayarkan',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              SizedBox(height: 10),
                              Divider(),
                              SizedBox(height: 15),
                              Text('Pendaftaran',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(height: 10),
                              Text('Rp 200.000',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                  )),
                              SizedBox(
                                height: 15,
                              ),
                              Text('Uang Pangkal',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(height: 10),
                              Text('Rp 6.000.000',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                  )),
                              SizedBox(
                                height: 15,
                              ),
                              Text('SPP Bulanan',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(height: 10),
                              Text(_typeApplication == 'pondok' ? 'Rp 800.000' : 'Rp 300.000',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 15,
                            bottom: 10
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pembayaran',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              SizedBox(height: 10),
                              Divider(),
                              SizedBox(height: 15),
                              Text('No Rekening',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(height: 10),
                              Text('7154343697',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                  )),
                              SizedBox(
                                height: 15,
                              ),
                              Text('Bank',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(height: 10),
                              Text('BSI (Bank Syariah Indonesia)',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                  )),
                              SizedBox(
                                height: 15,
                              ),
                              Text('Nasabah',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(height: 10),
                              Text('Sari Romlah',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                  )),
                              SizedBox(
                                height: 15,
                              ),
                              Text('Jika sudah transfer, mohon untuk mengkonfirmasi ke WA 081575319184, dengan mengetikkan :',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    height: 1.5
                                  )),
                              SizedBox(height: 10),
                              Text('BAYAR/spasi/pendaftaran/spasi/biaya/spasi/200000/spasi/NAMA BANK/spasi/NAMA PENGIRIM',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    height: 1.5
                                  ),
                                  softWrap: true,
                                ),
                              SizedBox(height: 10),
                              Divider(),
                              SizedBox(height: 10),
                              Text(
                                'Bukti Pembayaran',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              SizedBox(height: 15),
                              if (_bukti_pembayaran != null)
                              _isLoad
                              ? CircularProgressIndicator()
                              : Image.network(
                                'https://yayasanmutiaraihsanindonesia.my.id/assets/img/bukti-pembayaran/$_bukti_pembayaran',
                                fit: BoxFit.cover,
                                scale: 1,
                                width: 150,
                                height: 150
                              ),
                              SizedBox(height: 15),
                              Row(
                                children: [
                                  Semantics(
                                    label: 'Upload Akte kelahiran dari gallery',
                                    child: FloatingActionButton(
                                      onPressed: () async {
                                        return await _bukti(ImageSource.gallery);
                                      },
                                      heroTag: 'bukti_pembayaran',
                                      tooltip: 'Pick Image from gallery',
                                      child: const Icon(Icons.photo),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Text("Atau"),
                                  SizedBox(width: 10,),
                                  Semantics(
                                    label: 'Upload Akte kelahiran dari kamera',
                                    child: FloatingActionButton(
                                      onPressed: () async {
                                        return await _bukti(ImageSource.camera);
                                      },
                                      heroTag: 'bukti_pembayaran',
                                      tooltip: 'Pick Image from camera',
                                      child: const Icon(Icons.camera_alt),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  SizedBox(width: 10,),
                                ]
                              ),
                              SizedBox(height: 15),
                            ],
                          ),
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
