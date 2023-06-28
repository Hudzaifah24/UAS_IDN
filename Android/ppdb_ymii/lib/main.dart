import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:ppdb_ymii/pages/splash/splash_page.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "PPDB Mutiara Ihsan",
      debugShowCheckedModeBanner: false,
      home: CheckLoggedIn(),
    );
  }
}

class CheckLoggedIn extends StatefulWidget {
  const CheckLoggedIn({Key? key}) : super(key: key);

  @override
  State<CheckLoggedIn> createState() => _CheckLoggedInState();
}

class _CheckLoggedInState extends State<CheckLoggedIn> {
  bool _isLoadProgress = true;
  
  @override
  void initState() {
    _checkConnectivity();
    super.initState();
  }

  Future _checkConnectivity() async {
    InternetConnectionChecker().onStatusChange.listen(
      (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            setState(() {
              _isLoadProgress = false;
            });
          
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
              _isLoadProgress = true;
            });

            print('You are disconnected from the internet.');
            break;
        }
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoadProgress ? Center(child: CircularProgressIndicator()) : SplashPage(),
    );
  }
}
