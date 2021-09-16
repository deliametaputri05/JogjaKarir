import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jogja_karir/pages/profile/lengkapi_profil.dart';

import 'database.dart';

class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static GoogleSignIn _googleSignIn = GoogleSignIn();

  static FirebaseFirestore fs = FirebaseFirestore.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  static Future<User?> signUp(String email, String password) async {
    var url =
        'https://firebasestorage.googleapis.com/v0/b/jogjakarir-f04ca.appspot.com/o/user.png?alt=media&token=239a9ba2-e751-4047-a60b-456818b04cb7';
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      await DatabaseService(uid: user!.uid)
          .createUserFields('User', email, url);
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<User?> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      UserCredential result = await _auth.signInWithCredential(credential);
      User? user = result.user;

      fs.collection('users').doc(user!.uid).get().then((doc) => {
            if (!doc.exists)
              {
                DatabaseService(uid: user.uid).createUserFields(
                    googleUser.displayName, googleUser.email, user.photoURL),
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (builder) => LengkapiProfil())),
              }
            else
              {Navigator.of(context).pop('/beranda')}
          });

      return result;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<UserCredential?> signUpWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      UserCredential result = await _auth.signInWithCredential(credential);
      User? user = result.user;
      await DatabaseService(uid: user!.uid).createUserFields(
          googleUser.displayName, googleUser.email, user.photoURL);
      return result;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  static Future resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  static Stream<User?> get firebaseUserStream => _auth.authStateChanges();
}
