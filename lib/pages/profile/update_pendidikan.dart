import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:jogja_karir/firebase/database.dart';
import 'package:jogja_karir/widgets/loading.dart';
import 'package:jogja_karir/widgets/title_theme.dart';

class UpdatePendidikan extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Platform.isAndroid
              ? InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back))
              : InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back_ios)),
          elevation: 0.0,
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: Text(
            "Edit Pendidikan",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Container(
          child: ListView(
            children: <Widget>[
              Center(
                child: Column(
                  children: <Widget>[
                    _textField(context),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget _textField(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return StreamBuilder<DocumentSnapshot>(
        stream: DatabaseService(uid: user.uid).userDataStream,
        builder: (context, snapshot) {
          TextEditingController univController = TextEditingController(
              text: snapshot.data?['pendidikan'][0]['univ']);
          TextEditingController tingkatController = TextEditingController(
              text: snapshot.data?['pendidikan'][0]['tingkat']);
          TextEditingController jurusanController = TextEditingController(
              text: snapshot.data?['pendidikan'][0]['jurusan']);
          TextEditingController nilaiController = TextEditingController(
              text: snapshot.data?['pendidikan'][0]['nilaiAkhir']);
          TextEditingController tahunController = TextEditingController(
              text: snapshot.data?['pendidikan'][0]['tahun']);

          if (snapshot.hasData) {
            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: TitleTheme(title: "Tentang Saya", fontSize: 20),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.all(12),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      validator:
                          RequiredValidator(errorText: "Isi Nama Instansi mu."),
                      controller: univController,
                      decoration: const InputDecoration(
                        icon: CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 18,
                          child: Icon(
                            Icons.school_outlined,
                            color: Colors.white,
                          ),
                        ),
                        border: UnderlineInputBorder(),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 3,
                            color: Colors.blue,
                          ),
                        ),
                        hintText: "Instansi Pendidikan",
                      ),
                      style: TextStyle(color: Colors.black),
                      autofocus: false,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      validator:
                          RequiredValidator(errorText: "Isi Jurusan mu."),
                      controller: jurusanController,
                      decoration: const InputDecoration(
                        icon: CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 18,
                          child: Icon(
                            Icons.school_outlined,
                            color: Colors.white,
                          ),
                        ),
                        border: UnderlineInputBorder(),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 3,
                            color: Colors.blue,
                          ),
                        ),
                        hintText: "Jurusan",
                      ),
                      style: TextStyle(color: Colors.black),
                      autofocus: false,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      validator:
                          RequiredValidator(errorText: "Jenjang Pendidikan"),
                      controller: tingkatController,
                      decoration: const InputDecoration(
                        icon: CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 18,
                          child: Icon(
                            Icons.school_outlined,
                            color: Colors.white,
                          ),
                        ),
                        border: UnderlineInputBorder(),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 3,
                            color: Colors.blue,
                          ),
                        ),
                        hintText: "Jenjang Pendidikan",
                      ),
                      style: TextStyle(color: Colors.black),
                      autofocus: false,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      validator: RequiredValidator(errorText: "Tahun Angkatan"),
                      controller: tahunController,
                      decoration: const InputDecoration(
                        icon: CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 18,
                          child: Icon(
                            Icons.school_outlined,
                            color: Colors.white,
                          ),
                        ),
                        border: UnderlineInputBorder(),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 3,
                            color: Colors.blue,
                          ),
                        ),
                        hintText: "Tahun Angkatan",
                      ),
                      style: TextStyle(color: Colors.black),
                      autofocus: false,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      validator: RequiredValidator(errorText: "Nilai Akhir"),
                      controller: nilaiController,
                      decoration: const InputDecoration(
                        icon: CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 18,
                          child: Icon(
                            Icons.school_outlined,
                            color: Colors.white,
                          ),
                        ),
                        border: UnderlineInputBorder(),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 3,
                            color: Colors.blue,
                          ),
                        ),
                        hintText: "Nilai Akhir",
                      ),
                      style: TextStyle(color: Colors.black),
                      autofocus: false,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                  ),
                  _button(context, univController, tingkatController,
                      jurusanController, nilaiController, tahunController)
                ],
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          } else {
            return Text('error');
          }
        });
  }

  Widget _button(BuildContext context, TextEditingController jurusanController,
      univController, tingkatController, nilaiController, tahunController) {
    final user = FirebaseAuth.instance.currentUser!;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 30, right: 20),
            child: InkWell(
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  await DatabaseService(uid: user.uid).updatePendidikanData(
                    univController.text,
                    tingkatController.text,
                    jurusanController.text,
                    nilaiController.text,
                    tahunController.text,
                  );

                  Navigator.pop(context);
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                width: 100,
                child: Text(
                  "Simpan",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
