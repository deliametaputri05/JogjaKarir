import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:jogja_karir/pages/profile/lengkapi_profil.dart';
import 'package:jogja_karir/firebase/auth_services.dart';
import 'package:jogja_karir/widgets/loading.dart';
import 'login.dart';

class Register extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Register> {
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  TextEditingController confirmPasswordController =
      TextEditingController(text: "");
  bool _isHidePassword = true;
  bool _isHidePassword1 = true;
  bool loading = false;
  String error = '';
  final _formKey = GlobalKey<FormState>();

  void _togglePasswordVisibility() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  void _togglePasswordVisibility1() {
    setState(() {
      _isHidePassword1 = !_isHidePassword1;
    });
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
          "Register",
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
          "Buat Akun Baru",
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
            padding: EdgeInsets.only(top: 15.0),
          ),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            validator: MultiValidator([
              RequiredValidator(errorText: 'Isi Email-mu disini!'),
              EmailValidator(errorText: 'Format Email tidak valid!')
            ]),
            controller: emailController,
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
              hintText: "Email-mu",
              hintStyle: TextStyle(color: Color(0xffccd1ff)),
            ),
            style: TextStyle(color: Colors.black),
            autofocus: false,
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.0),
          ),
          TextFormField(
            validator: MultiValidator([
              RequiredValidator(errorText: 'Isi Password-Mu disini!'),
              MinLengthValidator(6,
                  errorText: 'Password-mu minimal 6 Karakter!')
            ]),
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
              hintText: "Password-mu",
              hintStyle: TextStyle(color: Color(0xffccd1ff)),
            ),
            style: TextStyle(color: Colors.black),
            obscureText: _isHidePassword,
            autofocus: false,
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.0),
          ),
          TextFormField(
            controller: confirmPasswordController,
            validator: (val) => MatchValidator(errorText: 'Password Tidak Sama')
                .validateMatch(passwordController.text, val!),
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
                  _togglePasswordVisibility1();
                },
                child: Icon(
                  _isHidePassword1 ? Icons.visibility_off : Icons.visibility,
                  color: _isHidePassword1 ? Colors.grey : Colors.blue,
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
              hintText: "Ulangi Password-mu",
              hintStyle: TextStyle(color: Color(0xffccd1ff)),
            ),
            style: TextStyle(color: Colors.black),
            obscureText: _isHidePassword1,
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
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            width: double.infinity,
            child: Text(
              'Buat Akun',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onTap: () async {
            if (_formKey.currentState!.validate()) {
              setState(() => loading = true);
              await AuthServices.signUp(
                  emailController.text, passwordController.text);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LengkapiProfil()));
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            error,
            style: TextStyle(
                color: Colors.red, fontSize: 12, fontWeight: FontWeight.w900),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 100),
        ),
        InkWell(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                  'Registrasi Dengan Google',
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
            await AuthServices.signUpWithGoogle();
            Navigator.push(context,
                MaterialPageRoute(builder: (builder) => LengkapiProfil()));
          },
        ),
        Padding(
          padding: EdgeInsets.only(top: 20.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 40),
            ),
            Text(
              "Sudah Punya Akun ? ",
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
            ),
            TextButton(
              child: Text(
                "Masuk",
                style: TextStyle(
                  color: Colors.blue[400],
                  fontSize: 13,
                ),
              ),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
            ),
          ],
        ),
      ],
    );
  }
}
