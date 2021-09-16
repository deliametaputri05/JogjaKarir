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
import 'package:jogja_karir/pages/profile/update_pendidikan.dart';
import 'package:jogja_karir/pages/profile/update_profile.dart';
import 'package:jogja_karir/widgets/item_pendidikan.dart';
import 'package:jogja_karir/widgets/loading.dart';
import 'package:path/path.dart' as PathFile;

class DetailProfil extends StatefulWidget {
  @override
  _DetailProfilState createState() => _DetailProfilState();
}

class _DetailProfilState extends State<DetailProfil> {
  FirebaseStorage storage = FirebaseStorage.instance;
  bool _visible = false;
  bool _visible1 = false;
  bool _visible2 = false;
  bool _visible3 = false;
  bool _visible4 = false;
  late File _imageFile;

  void showInformasi() {
    setState(() {
      _visible = !_visible;
    });
  }

  void hideInformasi() {
    setState(() {
      _visible = !_visible;
    });
  }

  void showedit1() {
    setState(() {
      _visible1 = !_visible1;
      _visible2 = false;
      _visible3 = false;
      _visible4 = false;
    });
  }

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
      body: GestureDetector(
        onTap: () {
          setState(() {
            _visible1 = false;
            _visible2 = false;
            _visible3 = false;
            _visible4 = false;
          });
        },
        child: StreamBuilder<DocumentSnapshot>(
            stream: DatabaseService(uid: user.uid).userDataStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<dynamic> list = snapshot.data!['pendidikan'];
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
                                height:
                                    MediaQuery.of(context).size.height * 0.40,
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
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          shape: BoxShape.rectangle,
                                        ),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.23,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.23,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: ClipRRect(
                                            // borderRadius: BorderRadius.circular(55),
                                            child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              imageUrl:
                                                  (snapshot.data!['imageUrl']),
                                              placeholder: (context, url) =>
                                                  Loading(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                          ),
                                          // image: DecorationImage(
                                          //   image: CachedNetworkImageProvider(snapshot.data!['imageUrl']),
                                          //     // image: AssetImage('images/jonas.png'),
                                          //     fit: BoxFit.cover)),
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
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 30, bottom: 20),
                            height: 30,
                            width: 120,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Text(
                                "Pencari Kerja",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 24),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ///NAMA
                                Container(
                                  margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(snapshot.data!['namaLengkap'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 18)),
                                      Row(
                                        children: [
                                          Visibility(
                                            visible: _visible4,
                                            child: SizedBox(
                                              height: 32,
                                              width: 60,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                      CupertinoPageRoute(
                                                          builder: (builder) =>
                                                              UpdateProfil()));
                                                },
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(
                                                                Colors.white)),
                                                child: Text(
                                                  "Edit",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                              icon: Icon(
                                                Icons.more_vert,
                                                color: Colors.grey,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _visible4 = !_visible4;
                                                  _visible1 = false;
                                                  _visible2 = false;
                                                  _visible3 = false;
                                                });
                                              }),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  child: Divider(
                                      thickness: 1.5, color: Colors.grey),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Pendidikan",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 18)),
                                      Row(
                                        children: [
                                          Visibility(
                                            visible: _visible1,
                                            child: SizedBox(
                                              height: 32,
                                              width: 60,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      CupertinoPageRoute(
                                                          builder: (builder) =>
                                                              UpdatePendidikan()));
                                                },
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(
                                                                Colors.white)),
                                                child: Text(
                                                  "Edit",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                              icon: Icon(Icons.more_vert,
                                                  color: Colors.grey),
                                              onPressed: () {
                                                showedit1();
                                              }),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(10, 0, 20, 5),
                                    width: double.infinity,
                                    height: list.length > 1
                                        ? MediaQuery.of(context).size.width / 2
                                        : MediaQuery.of(context).size.width / 5,
                                    child: Scrollbar(
                                      isAlwaysShown: false,
                                      child: ListView.separated(
                                          scrollDirection: Axis.vertical,
                                          separatorBuilder: (context, index) =>
                                              SizedBox(
                                                height: 20,
                                              ),
                                          itemCount: list.length,
                                          itemBuilder: (context, index) {
                                            return pendidikanRow(
                                                snapshot, index);
                                          }),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 20, right: 20, top: 10),
                                  child: Divider(
                                      thickness: 1.5, color: Colors.grey),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Keahlian",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 18)),
                                      Row(
                                        children: [
                                          Visibility(
                                            visible: _visible2,
                                            child: SizedBox(
                                              height: 32,
                                              width: 60,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      CupertinoPageRoute(
                                                          builder: (builder) =>
                                                              UpdateProfil()));
                                                },
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(
                                                                Colors.white)),
                                                child: Text(
                                                  "Edit",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                              icon: Icon(Icons.more_vert,
                                                  color: Colors.grey),
                                              onPressed: () {
                                                setState(() {
                                                  _visible1 = false;

                                                  _visible3 = false;
                                                  _visible4 = false;
                                                  _visible2 = !_visible2;
                                                });
                                              }),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text("Utama",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                                fontSize: 15)),
                                      ),
                                      Expanded(
                                        flex: 8,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(snapshot.data!['skill'],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 20, right: 20, top: 10),
                                  child: Divider(
                                      thickness: 1.5, color: Colors.grey),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Tentang Saya",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 18)),
                                      Row(
                                        children: [
                                          Visibility(
                                            visible: _visible3,
                                            child: SizedBox(
                                              height: 32,
                                              width: 60,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      CupertinoPageRoute(
                                                          builder: (builder) =>
                                                              UpdateProfil()));
                                                },
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(
                                                                Colors.white)),
                                                child: Text(
                                                  "Edit",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                              icon: Icon(Icons.more_vert,
                                                  color: Colors.grey),
                                              onPressed: () {
                                                setState(() {
                                                  _visible1 = false;

                                                  _visible2 = false;
                                                  _visible4 = false;
                                                  _visible3 = !_visible3;
                                                });
                                              }),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(20, 0, 10, 5),
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text("Alamat",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                                fontSize: 15)),
                                      ),
                                      Expanded(
                                        flex: 8,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                "${snapshot.data!['alamat']}, ${snapshot.data!['domisili']}",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(20, 0, 10, 5),
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text("Email",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                                fontSize: 15)),
                                      ),
                                      Expanded(
                                        flex: 8,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(snapshot.data!['email'],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Loading();
              } else {
                return Text(
                  'Error Occured',
                  style: TextStyle(color: Colors.red.shade900),
                );
              }
            }),
      ),
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

Widget pendidikanRow(
    AsyncSnapshot<DocumentSnapshot<Object?>> snapshot, int index) {
  return Row(
    // mainAxisAlignment: MainAxisAlignment.spaceAround,
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        snapshot.data!['pendidikan'][index]['tahun'],
        style: TextStyle(
            color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 15),
      ),
      SizedBox(
        width: 30,
      ),
      Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            snapshot.data!['pendidikan'][index]['univ'],
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
          SizedBox(
            height: 5,
          ),
          ItemPendidikan(
              padding: 22,
              dataKey: "Tingkat",
              value: snapshot.data!['pendidikan'][index]['tingkat']),
          ItemPendidikan(
              padding: 20,
              dataKey: "Jurusan",
              value: snapshot.data!['pendidikan'][index]['jurusan']),
          ItemPendidikan(
              padding: 13,
              dataKey: "Nilai Akhir",
              value: snapshot.data!['pendidikan'][index]['nilaiAkhir']),
        ],
      )
    ],
  );
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
