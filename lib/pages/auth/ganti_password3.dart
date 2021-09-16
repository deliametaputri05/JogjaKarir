import 'package:flutter/material.dart';
import 'ganti_password4.dart';

class GantiPassword3 extends StatefulWidget {

  @override
  _GantiPassword3State createState() => _GantiPassword3State();
}

class _GantiPassword3State extends State<GantiPassword3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ganti Password'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(24),
        child: ListView(
          children: [
            Text(
              "Kata sandi yang baru harus berbeda dengan kata sandi sebelumnya.",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              textAlign: TextAlign.justify,
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Kata Sandi"
                  ),
                  Container(
                    height: 65,
                    margin: EdgeInsets.only(top: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Minimal 8 karakter",
                      ),
                    ),
                  ),
                  Text(
                    "Ulangi kata sandi",
                  ),
                  Container(
                    height: 65,
                    margin: EdgeInsets.only(top: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Pastikan kata sandi sama",
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top:30),),
                    InkWell(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        width: double.infinity,
                        child: Text(
                          "Setel ulang password",
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
                      onTap: () {
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => GantiPassword4()));
                      },
                    ),
      ],
    ),
  )
          ],
        ),
      )
    );
  }
}