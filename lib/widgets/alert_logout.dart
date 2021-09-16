import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:jogja_karir/firebase/auth_services.dart';

class AlertLogout extends StatefulWidget {
  @override
  _AlertLogoutState createState() => _AlertLogoutState();
}

class _AlertLogoutState extends State<AlertLogout> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: AlertDialog(
        backgroundColor: Colors.white54,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
        title: Center(
          child: Text(
            "Yakin Ingin Keluar?",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.23,
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue)),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Text(
                      "Tidak",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.23,
              child: OutlinedButton(
                // borderSide: BorderSide(width: 2, color: Colors.blue),
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.all(Radius.circular(8)),
                // ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white)),
                onPressed: () async {
                  await AuthServices.signOut();
                  Navigator.of(context, rootNavigator: true).pop('dialog');
                },
                child: Text(
                  "Ya",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 11,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
