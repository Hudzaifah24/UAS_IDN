import 'dart:async';

import 'package:flutter/material.dart';

class AuthNotAllowedPage extends StatefulWidget {
  const AuthNotAllowedPage({Key? key}) : super(key: key);

  @override
  State<AuthNotAllowedPage> createState() => _AuthNotAllowedPageState();
}

class _AuthNotAllowedPageState extends State<AuthNotAllowedPage> {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final timer = Timer(const Duration(seconds: 5), () {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    });

    return Container(
      child: const Center(
        child: Text(
          'Halaman Tidak Tersedia, Karna User Belum Login'
        ),
      )
    );
  }
}