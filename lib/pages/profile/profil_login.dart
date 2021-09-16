import 'dart:io';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jogja_karir/firebase/database.dart';
import 'package:jogja_karir/pages/auth/ganti_password1.dart';
import 'package:jogja_karir/pages/profile/detail_profil.dart';
import 'package:jogja_karir/widgets/alert_logout.dart';
import 'package:jogja_karir/widgets/loading.dart';
import 'package:path/path.dart' as PathFile;

class ProfilLogin extends StatefulWidget {
  @override
  _ProfilLoginState createState() => _ProfilLoginState();
}

class _ProfilLoginState extends State<ProfilLogin> {
  FirebaseStorage storage = FirebaseStorage.instance;
  late File _imageFile;

  Future _getImage(ImageSource source, BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser!;
    try {
      final image = await ImagePicker().pickImage(source: source);

      setState(() {
        _imageFile = File(image!.path);
        print(PathFile.basename(_imageFile.toString()));
      });
      TaskSnapshot taskSnapshot =
          await storage.ref('usersProfile').child(user.uid).putFile(_imageFile);
      final String url = await taskSnapshot.ref.getDownloadURL();
      await DatabaseService(uid: user.uid).updatePhotoProfile(url);
    } on PlatformException catch (err) {
      print(err);
      debugPrint(err.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    var orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<DocumentSnapshot>(
          stream: DatabaseService(uid: user.uid).userDataStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.40,
                    width: double.infinity,
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: ClipPath(
                            clipper: MyClipper(),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.40,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: orientation == Orientation.portrait
                              ? MediaQuery.of(context).size.height * 0.03
                              : 20,
                          child: Text(
                            "Profil Kamu",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Positioned(
                          bottom: 0.1,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Material(
                                elevation: 15,
                                borderRadius: BorderRadius.circular(8),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.23,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.23,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: ClipRRect(
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl:
                                              (snapshot.data!['imageUrl']),
                                          placeholder: (context, url) =>
                                              Loading(),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: -5,
                                right: -5,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Align(
                                        child: IconButton(
                                      iconSize: 20,
                                      color: Colors.blue,
                                      icon: Icon(Icons.camera_alt_rounded,
                                          color: Colors.white),
                                      onPressed: () {
                                        _settingModalBottomSheet(context);
                                      },
                                    )),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Halaman Body
                  Container(
                    child: Column(children: [
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        height: 30,
                        width: 120,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Text(
                            "Pencari Kerja",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.fromLTRB(20, 20, 40, 20),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: TextButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (context) =>
                                                  DetailProfil()));
                                    },
                                    icon: CircleAvatar(
                                      backgroundColor: Colors.blue,
                                      radius: 18,
                                      child: Icon(
                                        Icons.person_outline,
                                        color: Colors.white,
                                      ),
                                    ),
                                    label: Text(
                                      "       Informasi Profil",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  )),
                              Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: TextButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  GantiPassword1()));
                                    },
                                    icon: CircleAvatar(
                                      backgroundColor: Colors.blue,
                                      radius: 18,
                                      child: Icon(
                                        Icons.lock_outline,
                                        color: Colors.white,
                                      ),
                                    ),
                                    label: Text(
                                      "       Ganti Password",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  )),
                              Container(
                                margin: EdgeInsets.only(bottom: 20),
                                child: TextButton.icon(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertLogout();
                                        });
                                  },
                                  icon: CircleAvatar(
                                    backgroundColor: Colors.red,
                                    radius: 18,
                                    child: Icon(
                                      Icons.power_settings_new,
                                      color: Colors.white,
                                    ),
                                  ),
                                  label: Text(
                                    "       Keluar",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                            ]),
                      )
                    ]),
                  ),
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Loading(),
              );
            } else {
              return Text(
                'Error Occurred, Check Your Connection',
                style: TextStyle(color: Colors.red.shade900),
              );
            }
          }),
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          margin: EdgeInsets.all(20),
          height: 140,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Foto Profil',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Padding(padding: EdgeInsets.only(bottom: 20)),
              Row(
                children: [
                  InkWell(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            child: Container(
                              height: 60.0,
                              width: 60.0,
                              color: Colors.blue,
                              child: Icon(
                                Icons.restore_from_trash_outlined,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 10)),
                          Text(
                            'Hapus Foto',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                  Padding(padding: EdgeInsets.only(right: 30)),
                  InkWell(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            child: Container(
                              height: 60.0,
                              width: 60.0,
                              color: Colors.blue,
                              child: Icon(
                                Icons.insert_photo_outlined,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 10)),
                          Text(
                            'Galery',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    onTap: () async {
                      await _getImage(ImageSource.gallery, context);
                    },
                  ),
                  Padding(padding: EdgeInsets.only(right: 30)),
                  InkWell(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            child: Container(
                              height: 60.0,
                              width: 60.0,
                              color: Colors.blue,
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 10)),
                          Text(
                            'Camera',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    onTap: () async {
                      await _getImage(ImageSource.camera, context);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 100);

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
