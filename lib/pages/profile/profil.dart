import 'package:flutter/material.dart';
import 'package:jogja_karir/pages/auth/login.dart';
import 'widget/clipper.dart';

class Profil extends StatelessWidget {
  const Profil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: Text("Profil Kamu",
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      body: Column(
        children: [
          clipPath(),
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => Login()
                    )
                );
              },
              child: Text("Sign In"),
            ),
          ),
        ],
      )
    );
  }
}

Widget clipPath() {
  return Stack(
    alignment: Alignment.center,
    children: [
      ClipPath(
        clipper: MyClipper(),
        child: Container(
          width: double.infinity,
          height: 195,
          decoration: BoxDecoration(
              color: Colors.blue
          ),
        ),
      ),
      new Positioned(
        top: 65.0,
        child: Container(
            height: 110,
            width: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(55),
              color: Colors.lightBlueAccent,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  offset: Offset(2.0, 4.0), //(x,y)
                  blurRadius: 30,
                  spreadRadius: -9,
                ),
              ],
            ),
            child: Icon(Icons.person, color: Colors.white, size: 80,)
        ),
      )
    ],
  );
}