import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:ppdb_ymii/api/profile_api/edit_profile_url.dart';
import 'package:ppdb_ymii/data/data_auth.dart';
import 'package:ppdb_ymii/layouts/drawer_main.dart';
import 'package:ppdb_ymii/layouts/footer.dart';
import 'package:ppdb_ymii/layouts/app_bar_main.dart';
import 'package:ppdb_ymii/pages/profile/profile_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  Map user = {};
  String _token = '';
  bool _formLoad = true;
  bool _loadConnection = false;
  Map _messages = {};
  String url = '';

  TextEditingController name = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController namaAyah = TextEditingController();
  TextEditingController namaIbu = TextEditingController();
  TextEditingController noTlpAyah = TextEditingController();
  TextEditingController noTlpIbu = TextEditingController();


  void _getDataAuth() async {
    var dataAuth = await DataAuth().getDataStorage();
    
    setState(() {
      user = dataAuth["user_authenticated"];
      _token = dataAuth["token"];
    });
  }

  Future _edit() async {
    setState(() {
      _formLoad = false;
      _messages = {};
    });
    
    final response = await http.post(
      Uri.parse(edit_profile_url),
      body: {
        "name" : name.text,
        "username" : username.text,
        "email" : email.text,
        "alamat" : alamat.text,
        "nama_ayah" : namaAyah.text,
        "nama_ibu" : namaIbu.text,
        "no_tlp_ayah" : noTlpAyah.text,
        "no_tlp_ibu" : noTlpIbu.text,
      },
      headers: {
        'Authorization' : 'Bearer $_token'
      }
    );

    setState(() {
      _formLoad = true;
    });

    final body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove("user");
      localStorage.setString("user", jsonEncode(body['data']));
      
      return true;
    } else {
      final message = body['message'];

      setState(() {
        _messages = message;
      });

      print(_messages);

      return false;
    }
  }

  @override
  void initState() {
    _getDataAuth();
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
    name.text = user['name'].toString();
    username.text = user['username'].toString();
    email.text = user['email'].toString();
    alamat.text = user['alamat'] == null ? '' : user['alamat'].toString();
    namaAyah.text = user['nama_ayah'] == null ? '' : user['nama_ayah'].toString();
    namaIbu.text = user['nama_ibu'] == null ? '' : user['nama_ibu'].toString();
    noTlpAyah.text = user['no_tlp_ayah'] == null ? '' : user['no_tlp_ayah'].toString();
    noTlpIbu.text = user['no_tlp_ibu'] == null ? '' : user['no_tlp_ibu'].toString();
    
    return SafeArea(
      child: Scaffold(
          drawer: DrawerMain(),
          appBar: _loadConnection ? null : appBarMain("Edit Profile"),
          body: RefreshIndicator(
            onRefresh: () {
            return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => EditProfilePage()), (route) => false);
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
                    child: Row(
                      children: [
                        Image.network(
                          user["photo"] == null
                          ? 'https://yayasanmutiaraihsanindonesia.my.id/assets/img/pp.jpg'
                          : 'https://yayasanmutiaraihsanindonesia.my.id/assets/img/profile/${user["photo"]}',
                          fit: BoxFit.cover,
                          scale: 1,
                          width: 75,
                          height: 75
                        ),                      
                        SizedBox(
                          width: 15
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user['name'].toString(),
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal
                              ),
                            ),
                            SizedBox(
                              height: 10
                            ),
                            Text(
                              user['role'].toString(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600
                              ),
                            )
                          ],
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
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Edit Profile',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                                SizedBox(height: 10),
                                Divider(),
                                SizedBox(height: 15),
                                TextFormField(
                                  decoration: InputDecoration(
                                    label: Text(
                                      'Nama'
                                    ),
                                  ),
                                  controller: name,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Nama lengkap wajib diisi";
                                    }
                                    return null;
                                  },
                                ),
                                // ignore: unnecessary_null_comparison
                                _messages != null && _messages['name'] != null ?
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    _messages['name'][0].toString(),
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
                                  height: 15,
                                ),
                                TextFormField(
                                  controller: username,
                                  decoration: InputDecoration(
                                    label: Text(
                                      'Username'
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Username wajin diisi";
                                    }
                                    return null;
                                  },
                                ),
                                // ignore: unnecessary_null_comparison
                                _messages != null && _messages['username'] != null ?
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    _messages['username'][0].toString(),
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
                                  height: 15,
                                ),
                                TextFormField(
                                  controller: email,
                                  decoration: InputDecoration(
                                    label: Text(
                                      'Email'
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Email wajib diisi";
                                    }
                                    return null;
                                  },
                                ),
                                // ignore: unnecessary_null_comparison
                                _messages != null && _messages['email'] != null ?
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    _messages['email'][0].toString(),
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
                                  height: 15,
                                ),
                                TextFormField(
                                  controller: alamat,
                                  decoration: InputDecoration(
                                    label: Text(
                                      'Alamat'
                                    ),
                                  ),
                                ),
                                // ignore: unnecessary_null_comparison
                                _messages != null && _messages['alamat'] != null ?
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    _messages['alamat'][0].toString(),
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
                                  height: 20,
                                ),
                                Text(
                                  'Edit Data Orang Tua',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Divider(),
                                SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  controller: namaAyah,
                                  decoration: InputDecoration(
                                    label: Text(
                                      'Nama Ayah'
                                    ),
                                  ),
                                ),
                                // ignore: unnecessary_null_comparison
                                _messages != null && _messages['nama_ayah'] != null ?
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    _messages['nama_ayah'][0].toString(),
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
                                  height: 15,
                                ),
                                TextFormField(
                                  controller: namaIbu,
                                  decoration: InputDecoration(
                                    label: Text(
                                      'Nama Ibu'
                                    ),
                                  ),
                                ),
                                // ignore: unnecessary_null_comparison
                                _messages != null && _messages['nama_ibu'] != null ?
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    _messages['nama_ibu'][0].toString(),
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
                                  height: 15,
                                ),
                                TextFormField(
                                  controller: noTlpAyah,
                                  decoration: InputDecoration(
                                    label: Text(
                                      'Nomor Telepon Ayah'
                                    ),
                                  ),
                                ),
                                // ignore: unnecessary_null_comparison
                                _messages != null && _messages['no_tlp_ayah'] != null ?
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    _messages['no_tlp_ayah'][0].toString(),
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
                                  height: 15,
                                ),
                                TextFormField(
                                  controller: noTlpIbu,
                                  decoration: InputDecoration(
                                    label: Text(
                                      'Nomor Telepon Ibu'
                                    ),
                                  ),
                                ),
                                // ignore: unnecessary_null_comparison
                                _messages != null && _messages['no_tlp_ibu'] != null ?
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    _messages['no_tlp_ibu'][0].toString(),
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
                                  height: 15,
                                ),
                                ElevatedButton(
                                onPressed: !_formLoad ? null : () {
                                  if (_formKey.currentState!.validate()) {
                                  _edit().then((value) {
                                    if (value) {
                                      final snackBar = SnackBar(
                                        content: const Text('Berhasil Mengedit Data'),
                                        action: SnackBarAction(
                                          label: 'tutup',
                                          onPressed: () {},
                                        ),
                                      );
                          
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      
                                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ProfilePage()), (route) => false);
                                    } else {
                                      final snackBar = SnackBar(
                                        content: const Text('Gagal Mengedit Data'),
                                        action: SnackBarAction(
                                          label: 'tutup',
                                          onPressed: () {},
                                        ),
                                      );
                          
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    }
                                  },);
                                  }
                                }, 
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 15,
                                  ),
                                ),
                                child: Text(
                                  'Edit',
                                )
                              ),
                              ],
                            ),
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
