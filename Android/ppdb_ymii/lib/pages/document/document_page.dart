// ignore_for_file: await_only_futures, unused_field
import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:ppdb_ymii/data/data_auth.dart';
import 'package:ppdb_ymii/layouts/drawer_main.dart';
import 'package:ppdb_ymii/layouts/footer.dart';
import 'package:ppdb_ymii/layouts/app_bar_main.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:ppdb_ymii/api/application_api/document_url.dart';
import 'package:ppdb_ymii/api/application_api/get_documents_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DocumentPage extends StatefulWidget {
  DocumentPage({Key? key}) : super(key: key);

  @override
  State<DocumentPage> createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
  final _formKey = GlobalKey<FormState>();
  Map user = {};
  bool _isLoad = true;
  bool _isSend = false;
  bool _loadConnection = false;
  Map _messages = {};
  bool _formLoad = true;
  var _documents;
  var token;
  var _akteKelahiran;
  var _kartuKeluarga;
  var _ktpAyah;
  var _ktpIbu;
  var _ijazah;
  
  @override
  void initState() {
    _getDocuments();

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
      _akteKelahiran = body['data']['akte_kelahiran'];
      _kartuKeluarga = body['data']['kartu_keluarga'];
      _ktpAyah = body['data']['ktp_ayah'];
      _ktpIbu = body['data']['ktp_ibu'];
      _ijazah = body['data']['ijazah_terakhir'];
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

  Future _document(source, String _messageSuccess, String _messageFail, String _jenis) async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: source);
    //TO convert Xfile into file
    File file = File(image!.path);
    setState(() {
      _isSend = true;
    });

    final response = await http.MultipartRequest(
      "POST",
      Uri.parse(document_url),
    );

    response.headers['authorization'] = "Bearer $token";

    setState(() {
      _jenis;
    });

    response.fields['jenis'] = _jenis;

    response.files.add(http.MultipartFile.fromBytes('document', File(file.path).readAsBytesSync(), filename: file.path));

    var res = await response.send();

    setState(() {
      _isSend = false;
    });

    if (res.statusCode == 200) {
      final snackBar = SnackBar(
        content: Text(_messageSuccess),
        action: SnackBarAction(
          label: 'tutup',
          onPressed: () {},
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => DocumentPage()), (route) => false);
    } else {
      final snackBar = SnackBar(
        content: Text(_messageFail),
        action: SnackBarAction(
          label: 'tutup',
          onPressed: () {},
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          drawer: DrawerMain(),
          appBar: _loadConnection ? null : appBarMain("Upload Document"),
          body: _isLoad ||_isSend 
          ? Center(child: CircularProgressIndicator()) 
          : RefreshIndicator(
            onRefresh: () {
            return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => DocumentPage()), (route) => false);
          },
            child: _loadConnection ? Center(child: CircularProgressIndicator()) : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 20
                  ),
                  child: Column(children: [
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
                                'Akte Kelahiran',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              SizedBox(height: 15),
                              if (_akteKelahiran != null)
                              _isLoad
                              ? CircularProgressIndicator()
                              : Image.network(
                                "https://yayasanmutiaraihsanindonesia.my.id/assets/img/documents/$_akteKelahiran",
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
                                        _document(ImageSource.gallery, "Berhasil Mengupload Akte Kelahiran", "Gagal Mengupload Akte Kelahiran", "akte_kelahiran");
                                      },
                                      heroTag: 'akte_kelahiran',
                                      tooltip: 'Pilih Foto Dari Gallery',
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
                                        _document(ImageSource.camera, "Berhasil Mengupload Akte Kelahiran", "Gagal Mengupload Akte Kelahiran", "akte_kelahiran");
                                      },
                                      heroTag: 'akte_kelahiran',
                                      tooltip: 'Pilih Foto Dari Kamera',
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
                SizedBox(height: 15),
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
                                'Kartu Keluarga',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              SizedBox(height: 15),
                              if (_kartuKeluarga != null)
                              _isLoad
                              ? CircularProgressIndicator()
                              : Image.network(
                                "https://yayasanmutiaraihsanindonesia.my.id/assets/img/documents/$_kartuKeluarga",
                                fit: BoxFit.cover,
                                scale: 1,
                                width: 150,
                                height: 150
                              ),
                              SizedBox(height: 15),
                              Row(
                                children: [
                                  Semantics(
                                    label: 'Upload Kartu Keluarga dari gallery',
                                    child: FloatingActionButton(
                                      onPressed: () async {
                                        _document(ImageSource.gallery, "Berhasil Mengupload Kartu Keluarga", "Gagal Mengupload Kartu Keluarga", "kartu_keluarga");
                                      },
                                      heroTag: 'kartu_keluarga',
                                      tooltip: 'Pilih Foto Dari Gallery',
                                      child: const Icon(Icons.photo),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Text("Atau"),
                                  SizedBox(width: 10,),
                                  Semantics(
                                    label: 'Upload Kartu Keluarga dari kamera',
                                    child: FloatingActionButton(
                                      onPressed: () async {
                                        _document(ImageSource.camera, "Berhasil Mengupload Kartu Keluarga", "Gagal Mengupload Kartu Keluarga", "kartu_keluarga");
                                      },
                                      heroTag: 'kartu_keluarga',
                                      tooltip: 'Pilih Foto Dari Kamera',
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
                SizedBox(height: 15),
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
                                'KTP Ayah',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              SizedBox(height: 15),
                              if (_ktpAyah != null)
                              _isLoad
                              ? CircularProgressIndicator()
                              : Image.network(
                                "https://yayasanmutiaraihsanindonesia.my.id/assets/img/documents/$_ktpAyah",
                                fit: BoxFit.cover,
                                scale: 1,
                                width: 150,
                                height: 150
                              ),
                              SizedBox(height: 15),
                              Row(
                                children: [
                                  Semantics(
                                    label: 'Upload KTP Ayah dari gallery',
                                    child: FloatingActionButton(
                                      onPressed: () async {
                                        _document(ImageSource.gallery, "Berhasil Mengupload KTP ayah", "Gagal Mengupload KTP ayah", "ktp_ayah");
                                      },
                                      heroTag: 'ktp_ayah',
                                      tooltip: 'Pilih Foto Dari Gallery',
                                      child: const Icon(Icons.photo),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Text("Atau"),
                                  SizedBox(width: 10,),
                                  Semantics(
                                    label: 'Upload KTP Ayah dari kamera',
                                    child: FloatingActionButton(
                                      onPressed: () async {
                                        _document(ImageSource.camera, "Berhasil Mengupload KTP ayah", "Gagal Mengupload KTP ayah", "ktp_ayah");
                                      },
                                      heroTag: 'ktp_ayah',
                                      tooltip: 'Pilih Foto Dari Kamera',
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
                SizedBox(height: 15),
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
                                'KTP Ibu',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              SizedBox(height: 15),
                              if (_ktpIbu != null)
                              _isLoad
                              ? CircularProgressIndicator()
                              : Image.network(
                                "https://yayasanmutiaraihsanindonesia.my.id/assets/img/documents/$_ktpIbu",
                                fit: BoxFit.cover,
                                scale: 1,
                                width: 150,
                                height: 150
                              ),
                              SizedBox(height: 15),
                              Row(
                                children: [
                                  Semantics(
                                    label: 'Upload KTP Ibu dari gallery',
                                    child: FloatingActionButton(
                                      onPressed: () async {
                                        _document(ImageSource.gallery, "Berhasil Mengupload KTP Ibu", "Gagal Mengupload KTP Ibu", "ktp_ibu");
                                      },
                                      heroTag: 'ktp_ibu',
                                      tooltip: 'Pilih Foto Dari Gallery',
                                      child: const Icon(Icons.photo),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Text("Atau"),
                                  SizedBox(width: 10,),
                                  Semantics(
                                    label: 'Upload KTP Ibu dari kamera',
                                    child: FloatingActionButton(
                                      onPressed: () async {
                                        _document(ImageSource.camera, "Berhasil Mengupload KTP Ibu", "Gagal Mengupload KTP Ibu", "ktp_ibu");
                                      },
                                      heroTag: 'ktp_ibu',
                                      tooltip: 'Pilih Foto Dari Kamera',
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
                SizedBox(height: 15),
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
                                'Ijazah',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              SizedBox(height: 15),
                              if (_ijazah != null)
                              _isLoad
                              ? CircularProgressIndicator()
                              : Image.network(
                                "https://yayasanmutiaraihsanindonesia.my.id/assets/img/documents/$_ijazah",
                                fit: BoxFit.cover,
                                scale: 1,
                                width: 150,
                                height: 150
                              ),
                              SizedBox(height: 15),
                              Row(
                                children: [
                                  Semantics(
                                    label: 'Upload Ijazah dari gallery',
                                    child: FloatingActionButton(
                                      onPressed: () async {
                                        _document(ImageSource.gallery, "Berhasil Mengupload Foto Ijazah", "Gagal Mengupload Foto Ijazah", "ijazah");
                                      },
                                      heroTag: 'ijazah',
                                      tooltip: 'Pilih Foto Dari Gallery',
                                      child: const Icon(Icons.photo),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Text("Atau"),
                                  SizedBox(width: 10,),
                                  Semantics(
                                    label: 'Upload Ijazah dari kamera',
                                    child: FloatingActionButton(
                                      onPressed: () async {
                                        _document(ImageSource.camera, "Berhasil Mengupload Foto Ijazah", "Gagal Mengupload Foto Ijazah", "ijazah");
                                      },
                                      heroTag: 'ijazah',
                                      tooltip: 'Pilih Foto Dari Kamera',
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
