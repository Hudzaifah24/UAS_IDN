import 'package:flutter/material.dart';
import 'package:ppdb_ymii/pages/auth/confirmation_page.dart';
import 'package:ppdb_ymii/pages/auth/login_page.dart';
import 'package:ppdb_ymii/pages/auth/register_page.dart';
import 'package:ppdb_ymii/pages/auth/term_page.dart';

class DrawerAuth extends StatelessWidget {
  const DrawerAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.symmetric(
            vertical: 30
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'AUTENTIKASI',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.login,
              ),
              title: Text('Masuk'),
              onTap: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.app_registration_rounded,
              ),
              title: Text('Daftar'),
              onTap: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => RegisterPage()), (route) => false);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.verified_user_outlined,
              ),
              title: Text('Konfirmasi & Aktifasi Akun'),
              onTap: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ConfirmationPage()), (route) => false);
              },
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'SYARAT & KETENTUAN',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.not_listed_location_outlined,
              ),
              title: Text('S&K'),
              onTap: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => TermPage()), (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}