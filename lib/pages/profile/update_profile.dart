import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:jogja_karir/firebase/database.dart';
import 'package:jogja_karir/widgets/loading.dart';
import 'package:jogja_karir/widgets/title_theme.dart';

class UpdateProfil extends StatelessWidget {
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
            "Edit Profil",
            style: TextStyle(
              fontSize: 25,
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
          TextEditingController namaController =
              TextEditingController(text: snapshot.data?['namaLengkap']);
          TextEditingController alamatController =
              TextEditingController(text: snapshot.data?['alamat']);
          TextEditingController domisiliController =
              TextEditingController(text: snapshot.data?['domisili']);
          TextEditingController skillController =
              TextEditingController(text: snapshot.data?['skill']);
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
                      validator: RequiredValidator(
                          errorText: "Isi Nama Lengkap mu disini."),
                      controller: namaController,
                      decoration: const InputDecoration(
                        icon: CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 18,
                          child: Icon(
                            Icons.person,
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
                        hintText: "Nama Lengkap Kamu",
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
                          RequiredValidator(errorText: "Isi Alamat mu disini."),
                      controller: alamatController,
                      decoration: const InputDecoration(
                        icon: CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 18,
                          child: Icon(
                            Icons.place_outlined,
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
                        hintText: "Alamat Kamu",
                      ),
                      style: TextStyle(color: Colors.black),
                      autofocus: false,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 70, right: 20),
                    child: TextFormField(
                      validator:
                          RequiredValidator(errorText: "Isi Domisili disini."),
                      controller: domisiliController,
                      decoration: const InputDecoration(
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
                        hintText: "Domisili",
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
                          RequiredValidator(errorText: "Isi Skill-mu disini."),
                      controller: skillController,
                      decoration: const InputDecoration(
                        icon: CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 18,
                          child: Icon(
                            Icons.architecture_sharp,
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
                        hintText: "Skill",
                      ),
                      style: TextStyle(color: Colors.black),
                      autofocus: false,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                  ),
                  _button(context, namaController, domisiliController,
                      alamatController, skillController)
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

  Widget _button(BuildContext context, TextEditingController namaController,
      domisiliController, alamatController, skillController) {
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
                  await DatabaseService(uid: user.uid).updateUserData(
                      namaController.text,
                      domisiliController.text,
                      alamatController.text,
                      skillController.text);

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
