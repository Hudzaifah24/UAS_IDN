import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ppdb_ymii/api/auth_api/logout_url.dart';
import 'package:ppdb_ymii/pages/auth/login_page.dart';
import 'package:ppdb_ymii/pages/beranda_page.dart';
import 'package:ppdb_ymii/data/data_auth.dart';
import 'package:ppdb_ymii/pages/document/document_page.dart';
import 'package:ppdb_ymii/pages/profile/profile_page.dart';

import 'package:ppdb_ymii/pages/pembayaran/payment_page.dart';

class DrawerMain extends StatefulWidget {
  const DrawerMain({Key? key}) : super(key: key);

  @override
  State<DrawerMain> createState() => _DrawerMainState();
}

class _DrawerMainState extends State<DrawerMain> {
  final _formKey = GlobalKey<FormState>();
  bool _formLoad = false;

  var dataStorage;
  var localStorage;
  var token;
  Map user = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDataAuth();
  }
  
  _getDataAuth() async {
    dataStorage = await DataAuth().getDataStorage();

    setState(() {
      dataStorage;
    });
    
    user = dataStorage["user_authenticated"];
    localStorage = await dataStorage["localStorage"];
    token = dataStorage["token"];
  }

  Future _logout() async {
    final response = await http.get(
      Uri.parse(logout_url),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token.toString()}'
      },
    );
    
    localStorage.remove('token');
    localStorage.remove('user');
    localStorage.remove('application');

    if (response.statusCode == 200) {
      return true;
    }
    
    return false;
  }
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(user["name"].toString()),
              accountEmail: Text(user["email"].toString()),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10
              ),
              child: Text(
                'INFORMASI',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: Text('Beranda'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => BerandaPage()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
              ),
              title: Text('Profile'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10
              ),
              child: Text(
                'PENDAFTARAN',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.payment,
              ),
              title: Text('Pembayaran'),
              onTap: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PaymentPage()), (route) => false);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.upload_file,
              ),
              title: Text('Upload Document'),
              onTap: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => DocumentPage()), (route) => false);
              },
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 10,
              ),
              child: Form(
                key: _formKey,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(
                      vertical: 15
                    )
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        content: _formLoad ? Center(child: CircularProgressIndicator()) : Text(
                          'Anda yakin untuk keluar?'
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Gajadi'
                            ),
                          ),
                          TextButton(
                            child: Text('Yakin'),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  _formLoad = true;
                                });
                                _logout().then((value) {
                                  if(value) {
                                    final snackBar = SnackBar(
                                      content: const Text(
                                        'Anda berhasil Keluar'
                                      ),
                                      action: SnackBarAction(
                                        label: 'tutup',
                                        onPressed: () {}
                                      ),
                                    );
                
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                
                                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
                                  } else {
                                    final snackBar = SnackBar(
                                      content: const Text(
                                        'Keluar gagal'
                                      ),
                                      action: SnackBarAction(
                                        label: 'tutup',
                                        onPressed: () {},
                                      ),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  }
                                });
                              }
                            },
                          )
                        ],
                      ),
                    );
                  },
                  child: Text(
                    'Keluar',
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}