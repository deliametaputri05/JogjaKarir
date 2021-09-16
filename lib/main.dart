import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'base/auth.dart';
import 'base/splash_screen.dart';
import 'widgets/loading.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _init = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _init,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error Occured');
          } else if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
                title: 'Jogja Karir',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                home: Scaffold(body: SplashScreen()),
                routes: <String, WidgetBuilder>{
                  '/beranda': (BuildContext context) => new Auth(),
                });
          }
          return MaterialApp(
              home: Scaffold(
            body: Loading(),
          ));
        });
  }
}
