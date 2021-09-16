import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jogja_karir/pages/auth/login.dart';
import 'package:jogja_karir/pages/bookmark/bookmark.dart';
import 'package:jogja_karir/pages/home/home.dart';
import 'package:jogja_karir/pages/profile/profil.dart';
import 'package:jogja_karir/widgets/divider_line.dart';
import '../kebijakan.dart';
import '../search.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  late String _title;
  int _bottomNavCurrentIndex = 0;
  List<Widget> _container = [new Home(), new Bookmark(), new Profil()];

  @override
  initState(){
    super.initState();
    _title = 'Home';
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _bottomNavCurrentIndex != 2 ? AppBar(
        title: Text(_title),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => Search()));
            },
          ),
        ],
      ) : null,
      drawer: ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(35), bottomRight: Radius.circular(35)),
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                height: 100,
                child: DrawerHeader(
                  child: Text(
                    'Menu',
                    style: TextStyle(fontSize: 40),
                  ),
                ),
              ),
              ListTile(
                title: Text('Login Disini'),
                onTap: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => Login()));
                },
              ),
              DividerLine(height: 0.5, padding: 0.0, color: Colors.grey,),
              ListTile(
                title: Text('Kebijakan'),
                onTap: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => Kebijakan()));
                },
              ),
              DividerLine(height: 0.5, padding: 0.0, color: Colors.grey,),
              ListTile(
                title: Text('Pengaturan'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              DividerLine(height: 0.5, padding: 0.0, color: Colors.grey,),
              ListTile(
                title: Text('Update Aplikasi'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              DividerLine(height: 0.5, padding: 0.0, color: Colors.grey,),
            ],
          ),
        ),
      ),
      body: _container[_bottomNavCurrentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.blue,
        backgroundColor: Colors.white,
        buttonBackgroundColor: Colors.blue.shade400,
        animationCurve: Curves.bounceInOut,
        animationDuration: Duration(
            milliseconds: 200
        ),
        height: 55,
        onTap: (index) {
          setState(() {
            _bottomNavCurrentIndex = index;
            switch(index) {
              case 0: { _title = 'Home'; }
              break;
              case 1: { _title = 'Bookmark'; }
            }
          });
        },
        index: _bottomNavCurrentIndex,
        items: <Widget>[
          Icon(
            Icons.home_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.bookmark_outline,
            color: Colors.white,
          ),
          Icon(
            Icons.person_outline,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}