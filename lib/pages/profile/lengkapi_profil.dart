import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:jogja_karir/firebase/database.dart';
import 'package:jogja_karir/widgets/title_theme.dart';

class LengkapiProfil extends StatelessWidget {
  TextEditingController namaController = TextEditingController(text: "");
  TextEditingController alamatController = TextEditingController(text: "");
  TextEditingController domisiliController = TextEditingController(text: "");
  TextEditingController skillController = TextEditingController(text: "");
  TextEditingController jurusanController = TextEditingController(text: "");
  TextEditingController tingkatController = TextEditingController(text: "");
  TextEditingController nilaiController = TextEditingController(text: "/4.0");
  TextEditingController tahunController = TextEditingController(text: "");
  TextEditingController univController = TextEditingController(text: "");

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Platform.isAndroid
              ? InkWell(
                  onTap: () {
                    Navigator.popUntil(
                        context, ModalRoute.withName('/beranda'));
                  },
                  child: Icon(Icons.arrow_back))
              : InkWell(
                  onTap: () {
                    Navigator.popUntil(
                        context, ModalRoute.withName('/beranda'));
                  },
                  child: Icon(Icons.arrow_back_ios)),
          elevation: 0.0,
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: Text(
            "Profil Kamu",
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
                    _button(context),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget _textField(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: TitleTheme(title: "Tentang Saya", fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextFormField(
              validator:
                  RequiredValidator(errorText: "Isi Nama Lengkap mu disini."),
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
              validator: RequiredValidator(errorText: "Isi Alamat mu disini."),
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
              validator: RequiredValidator(errorText: "Isi Domisili disini."),
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
              validator: RequiredValidator(errorText: "Isi Skill-mu disini."),
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
            child: TitleTheme(title: "Pendidikan Saya", fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextFormField(
              validator:
                  RequiredValidator(errorText: "Isi Universitas-mu disini."),
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
                hintText: "Universitas",
              ),
              style: TextStyle(color: Colors.black),
              autofocus: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 70, right: 20),
            child: TextFormField(
              validator: RequiredValidator(errorText: "Isi Jurusan-mu disini."),
              controller: jurusanController,
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
                hintText: "Jurusan",
              ),
              style: TextStyle(color: Colors.black),
              autofocus: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 70, right: 20),
            child: TextFormField(
              validator: RequiredValidator(errorText: "Isi Tingkat-mu disini."),
              controller: tingkatController,
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
                hintText: "Tingkat",
              ),
              style: TextStyle(color: Colors.black),
              autofocus: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 70, right: 20),
            child: TextFormField(
              validator: RequiredValidator(errorText: "Isi Nilai-mu disini."),
              controller: nilaiController,
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
                hintText: "Nilai Akhir",
              ),
              style: TextStyle(color: Colors.black),
              autofocus: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 70, right: 20),
            child: TextFormField(
              validator:
                  RequiredValidator(errorText: "Isi Tahun Ajaran-mu disini."),
              controller: tahunController,
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
                hintText: "Tahun Ajaran",
              ),
              style: TextStyle(color: Colors.black),
              autofocus: false,
            ),
          ),
        ],
      ),
    );
  }

  Widget _button(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: InkWell(
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  await DatabaseService(uid: user.uid).addUserFields(
                      namaController.text,
                      domisiliController.text,
                      alamatController.text,
                      skillController.text,
                      tahunController.text,
                      univController.text,
                      tingkatController.text,
                      jurusanController.text,
                      nilaiController.text);
                  Navigator.popUntil(context, ModalRoute.withName('/beranda'));
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
