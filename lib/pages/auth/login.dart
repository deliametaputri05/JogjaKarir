import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jogja_karir/firebase/auth_services.dart';
import 'package:jogja_karir/widgets/loading.dart';
import 'ganti_password1.dart';
import 'register.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  bool _isHidePassword = true;
  bool loading = false;
  String error = '';
  final _formKey = GlobalKey<FormState>();

  void _togglePasswordVisibility() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  @override
  void initState() {
    AuthServices.signOut();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: Container(
              color: Colors.white,
              padding: EdgeInsets.all(20.0),
              child: ListView(
                children: <Widget>[
                  Center(
                    child: Column(
                      children: <Widget>[
                        _titleDescription(),
                        _textField(),
                        _buildButton(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Widget _titleDescription() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 20.0),
        ),
        Text(
          "Log In",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 22.0,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20.0),
        ),
        Text(
          "Selamat Datang",
          style: TextStyle(
            fontSize: 25.0,
            color: Colors.blue,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _textField() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20.0),
          ),
          TextFormField(
            validator: (value) => value!.isEmpty ? 'Isi Email-mu disini' : null,
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xff8b97ff),
                  width: 1.5,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 3.0,
                ),
              ),
              icon: CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 18,
                child: Icon(
                  Icons.alternate_email_rounded,
                  color: Colors.white,
                ),
              ),
              hintText: "emailkamu@gmail.com",
              hintStyle: TextStyle(color: Color(0xffccd1ff)),
            ),
            style: TextStyle(color: Colors.black),
            autofocus: false,
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.0),
          ),
          TextFormField(
            validator: (value) =>
                value!.isEmpty ? 'Isi Password-mu disini' : null,
            controller: passwordController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xff8b97ff),
                  width: 1.5,
                ),
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  _togglePasswordVisibility();
                },
                child: Icon(
                  _isHidePassword ? Icons.visibility_off : Icons.visibility,
                  color: _isHidePassword ? Colors.grey : Colors.blue,
                ),
              ),
              isDense: true,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 3.0,
                ),
              ),
              icon: CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 18,
                child: Icon(
                  Icons.lock_outline,
                  color: Colors.white,
                ),
              ),
              hintText: "password kamu",
              hintStyle: TextStyle(color: Color(0xffccd1ff)),
            ),
            style: TextStyle(color: Colors.black),
            obscureText: _isHidePassword,
            autofocus: false,
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 16.0),
        ),
        InkWell(
          onTap: () async {
            if (_formKey.currentState!.validate()) {
              setState(() => loading = true);
              dynamic result = await AuthServices.signIn(
                  emailController.text, passwordController.text);
              if (result == null) {
                setState(() {
                  loading = false;
                  error = 'Email atau Password tidak valid';
                });
              } else {
                Navigator.of(context).pop('/beranda');
              }
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            width: double.infinity,
            child: Text(
              'Masuk',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            error,
            style: TextStyle(
                color: Colors.red, fontSize: 12, fontWeight: FontWeight.w900),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 30),
            ),
            Text(
              "Lupa Password ? ",
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
            ),
            TextButton(
              child: Text(
                "Reset Password",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GantiPassword1()));
              },
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 90),
        ),
        InkWell(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    FontAwesomeIcons.google,
                    color: Colors.white,
                    size: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Masuk Dengan Google',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onTap: () async {
              setState(() => loading = true);
              await AuthServices.signInWithGoogle(context);
            }),
        Padding(
          padding: EdgeInsets.only(top: 10.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 40),
            ),
            Text(
              "Belum Memiliki Akun ? ",
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
            ),
            TextButton(
              child: Text(
                "Daftar Sekarang",
                style: TextStyle(
                  color: Colors.blue[400],
                  fontSize: 13,
                ),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Register()));
              },
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 16.0),
        ),
      ],
    );
  }

  Widget? errorMessage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        error,
        style: TextStyle(
            color: Colors.red, fontSize: 14.0, fontWeight: FontWeight.w700),
      ),
    );
  }
}
