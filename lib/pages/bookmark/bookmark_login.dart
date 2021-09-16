import 'package:flutter/material.dart';

class BookmarkLogin extends StatefulWidget {
  @override
  _BookmarkLogin createState() => new _BookmarkLogin();
}

class _BookmarkLogin extends State<BookmarkLogin> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SafeArea(
        child: new Scaffold(
          body: new Container(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                height: 550,
                width: double.maxFinite,
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 16.0),
                    ),
                    Card(
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.all(7),
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerRight,
                              child: Stack(
                                children: <Widget>[
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(left: 10, top: 5),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            bniIcon(),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            namaPekerjaan(),
                                            Spacer(),
                                            iconSimpan(),
                                            SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            gajilokasi(),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            syarat1(),
                                            syarat2(),
                                            Spacer(),
                                            tanggal(),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget bniIcon() {
  return Padding(
    padding: const EdgeInsets.only(left: 15),
    child: Align(
        alignment: Alignment.centerLeft,
        child: new Image.asset(
          'images/bni.png',
          width: 50,
          height: 50,
        )),
  );
}

Widget namaPekerjaan() {
  return Padding(
    padding: EdgeInsets.only(left: 10),
    child: RichText(
      text: TextSpan(
        text: 'Bank BNI',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 15,
        ),
        children: <TextSpan>[
          TextSpan(
              text: "\nCustomer Service",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    ),
  );
}

Widget iconSimpan() {
  return Padding(
    padding: EdgeInsets.only(right: 15),
    child: Align(
      alignment: Alignment.centerRight,
      child: Icon(
        Icons.bookmark,
        color: Colors.blue,
        size: 30,
      ),
    ),
  );
}

Widget gajilokasi() {
  return Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.only(left: 15, top: 15),
      child: Row(
        children: <Widget>[
          RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              text: "Rp.1.730.000",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: "\nYogyakarta, Indonesia",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Widget syarat1() {
  return Align(
    alignment: Alignment.bottomLeft,
    child: Padding(
      padding: const EdgeInsets.only(left: 15, top: 15),
      child: Row(
        children: <Widget>[
          InkWell(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              width: 50,
              child: Text(
                "SMA",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget syarat2() {
  return Align(
    alignment: Alignment.bottomLeft,
    child: Padding(
      padding: const EdgeInsets.only(left: 15, top: 15),
      child: Row(
        children: <Widget>[
          InkWell(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              width: 100,
              child: Text(
                "FullTime",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget tanggal() {
  return Padding(
    padding: const EdgeInsets.only(right: 15),
    child: Align(
      alignment: Alignment.bottomRight,
      child: Text(
        "10 Des'21",
      ),
    ),
  );
}

