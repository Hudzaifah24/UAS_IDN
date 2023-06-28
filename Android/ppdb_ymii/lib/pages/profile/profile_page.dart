import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:ppdb_ymii/data/data_auth.dart';
import 'package:ppdb_ymii/layouts/drawer_main.dart';
import 'package:ppdb_ymii/layouts/footer.dart';
import 'package:ppdb_ymii/layouts/app_bar_main.dart';
import 'package:ppdb_ymii/pages/profile/edit_profile_page.dart';
import 'package:ppdb_ymii/api/profile_api/get_profile_url.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map user = {};
  var token;
  String url = '';
  bool _isLoad = true;
  bool _loadConnection = false;

  Future _getDataAuth() async {
    var dataAuth = await DataAuth().getDataStorage();
    
    setState(() {
      user = dataAuth["user_authenticated"];
      token = dataAuth["token"];
    });

    final response = await http.get(
      Uri.parse(get_profile_url),
      headers: {
        "Authorization" : 'Bearer $token',
      }
    );

    if (response.statusCode == 200) {
      setState(() {
        _isLoad = false;
      });
    }

  }

  @override
  void initState() {
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
          appBar: _loadConnection ? null : appBarMain("Profile"),
          body: _isLoad ? Center(child: CircularProgressIndicator()) : RefreshIndicator(
            onRefresh: () {
            return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ProfilePage()), (route) => false);
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
                        Spacer(),
                        IconButton(
                          icon: Icon(
                            Icons.mode_edit_outline_outlined
                          ),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => EditProfilePage()
                            ));
                          }, 
                        )
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
                                'Informasi Profile',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              SizedBox(height: 10),
                              Divider(),
                              SizedBox(height: 15),
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
                                  user["alamat"] == null ? '-' : user["alamat"].toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Informasi Orang Tua',
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
                              Text('Nama Ayah',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(height: 10),
                              Text(user["nama_ayah"] == null ? '-' : user["nama_ayah"].toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                  )),
                              SizedBox(
                                height: 15,
                              ),
                              Text('Nama Ibu',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(height: 10),
                              Text(user["nama_ibu"] == null ? '-' : user["nama_ibu"].toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                  )),
                              SizedBox(
                                height: 15,
                              ),
                              Text('Nomor Telepon Ayah',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(height: 10),
                              Text('${user["no_tlp_ayah"] == null ? "-" : "+62" + user["no_tlp_ayah"].toString()}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                  )),
                              SizedBox(
                                height: 15,
                              ),
                              Text('Nomor Telepon Ibu',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(height: 10),
                              Text('${user["no_tlp_ibu"] == null ? "-" : "+62" + user["no_tlp_ibu"].toString()}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                  )),
                              SizedBox(
                                height: 15,
                              ),
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
