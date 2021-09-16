import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jogja_karir/firebase/auth_services.dart';
import 'package:provider/provider.dart';
import 'index/index.dart';
import 'index/index_login.dart';

class Auth extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
        value: AuthServices.firebaseUserStream,
        initialData: null,
        child: Wrapper(),
    );
  }
}

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? firebaseUser = Provider.of<User?>(context);
    return (firebaseUser == null) ? Index() : IndexLogin(firebaseUser);
  }
}

