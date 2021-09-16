import 'package:flutter/material.dart';

class Search extends StatefulWidget {

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            width: 30,
            height: MediaQuery.of(context).size.height * 0.1,
            child: Text(
              "Cari Pekerjaan",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            height: 60,
            margin: EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Posisi Pekerjaan",
                border: OutlineInputBorder(),
                prefixIcon: new Icon(Icons.search),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 16, bottom: 8),
            child: Text(
              "Pilih Lokasi",
            ),
          ),
          Container(
            height: 60,
            margin: EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Lokasi",
                border: OutlineInputBorder(),
                prefixIcon: new Icon(Icons.location_on_outlined),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 16, bottom: 8),
            child: Text(
              "Pilih Pendidikan",
            ),
          ),
          Container(
            height: 60,
            margin: EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Pendidikan",
                border: OutlineInputBorder(),
                prefixIcon: new Icon(Icons.school_outlined),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 16, bottom: 8),
            child: Text(
              "Pilih tipe pekerjaan",
            ),
          ),
          Container(
            height: 60,
            margin: EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Tipe pekerjaan",
                border: OutlineInputBorder(),
                prefixIcon: new Icon(Icons.access_time_outlined),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          InkWell(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            width: double.infinity,
            child: Text(
              "Cari Pekerjaan",
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        ],
      )
    );
  }
}