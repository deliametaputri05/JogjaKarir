import 'package:flutter/material.dart';
import 'package:jogja_karir/pages/auth/register.dart';

class Bookmark extends StatefulWidget {
  @override
  _BookmarkState createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 200,
              height: 200,
              child: Image.asset("images/maaf.png"),
            ),
            Padding(padding: EdgeInsets.only(top: 20),),
            Text("Yah, Kami belum kenal sama kamu. Kamu harus Log In/Register dulu supaya bisa menggunakan fitur ini.",
              style: TextStyle(
                color: Colors.black38,
                fontSize: 23,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(padding: EdgeInsets.only(top: 16),),
            InkWell(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                width: double.infinity,
                child: Text("Register di Sini",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(5)
                ),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
              },
            )
          ],
        ),
      ),
    );
  }
}