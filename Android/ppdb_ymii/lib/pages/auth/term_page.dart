import 'package:flutter/material.dart';
import 'package:ppdb_ymii/layouts/drawer_auth.dart';
import 'package:ppdb_ymii/layouts/footer.dart';

class TermPage extends StatefulWidget {
  TermPage({Key? key}) : super(key: key);

  @override
  State<TermPage> createState() => _TermPageState();
}

class _TermPageState extends State<TermPage> {  
  List<Widget> terms = [
    Text(
      'o Umur 6 s/d 16 Tahun',
      style: TextStyle(
        height: 1.5
      ),
    ),
    SizedBox(
      height: 15,
    ),
    Text(
      'o Bisa membaca Alquran',
      style: TextStyle(
        height: 1.5
      ),
    ),
    SizedBox(
      height: 15,
    ),
    Text(
      'o Membayar pendaftaran dan uang gedung + SPP bulanan',
      style: TextStyle(
        height: 1.5
      ),
    ),
  ];
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('Syarat & Ketentuan'),
        ),
        drawer: DrawerAuth(),
        body: RefreshIndicator(
          onRefresh: () {
            return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => TermPage()), (route) => false);
          },
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    Center(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Syarat & Ketentuan",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline
                                ),
                              ),
                              SizedBox(
                                height: 30
                              ),
                              Container(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: terms,
                                ),
                              )
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