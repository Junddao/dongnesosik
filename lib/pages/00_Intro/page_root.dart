import 'package:dongnesosik/pages/01_Login/page_login.dart';
import 'package:dongnesosik/pages/02_map/page_map.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PageRoot extends StatelessWidget {
  const PageRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return PageLogin();
          } else {
            return PageMap();
          }
        },
      ),
    );
  }
}
