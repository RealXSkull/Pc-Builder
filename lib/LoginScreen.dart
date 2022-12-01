// ignore_for_file: prefer_const_constructors, avoid_print, sized_box_for_whitespace, non_constant_identifier_names, file_names, library_private_types_in_public_api, use_key_in_widget_constructors, must_call_super
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:fyp/ForgetPassword.dart';
import 'package:fyp/MainMenu.dart';
import 'package:fyp/Signup.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp/main.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onClickedSignup;

  const LoginScreen({
    Key? key,
    required this.onClickedSignup,
  }) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool? Rememberme = false;
  bool _passwordVisible = false;
  final emailcontroller = TextEditingController();
  final passcontroller = TextEditingController();

  @override
  void dispose() {
    emailcontroller.dispose();
    passcontroller.dispose();

    super.dispose();
  }

  @override
  void initState() {
    _passwordVisible = false;
  }

  Widget buildemail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.white, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: TextField(
            controller: emailcontroller,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.email,
                  color: Color(0xff5ac18e),
                ),
                hintText: 'Email',
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        )
      ],
    );
  }

  Widget buildpassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 15),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.white, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: TextField(
            controller: passcontroller,
            textInputAction: TextInputAction.done,
            obscureText: !_passwordVisible,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Color(0xff5ac18e),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        )
      ],
    );
  }

  Widget buildRemembermecb() {
    return Container(
      height: 35,
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ForgetPassword()));
            },
            child: Text(
              'Forgot Password?',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 80,
          ),
          // Theme(
          //   data: ThemeData(unselectedWidgetColor: Colors.black),
          //   // child: Checkbox(
          //   //   //title: Text("Remember ME"),

          //   //   value: Rememberme,
          //   //   checkColor: Colors.green,
          //   //   activeColor: Colors.black,
          //   //   onChanged: (value) {
          //   //     setState(() {
          //   //       Rememberme = value;
          //   //     });
          //   //   },
          //   // ),
          // ),
          // const Text(
          //   'Remember Me',
          //   style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          // )
        ],
      ),
    );
  }

  Widget Singupbtn() {
    return Container(
        padding: EdgeInsets.only(left: 60.0),
        width: double.infinity,
        child: Row(
          children: <Widget>[
            Text(
              "Don't have an account?",
              style: TextStyle(color: Colors.black),
            ),
            RichText(
              text: TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = widget.onClickedSignup,
                text: 'Sign UP',
                style: TextStyle(
                    decoration: TextDecoration.underline, color: Colors.black),
              ),
            )
          ],
        ));
  }

  Widget buildloginbtn() {
    return Container(
      height: 40,
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ))),
        label: Text('Login'),
        onPressed: () {
          if (emailcontroller.text.isNotEmpty &&
              passcontroller.text.isNotEmpty) {
            signin();
          } else {
            Fluttertoast.showToast(
                msg: "Invalid Credentials",
                toastLength: Toast.LENGTH_SHORT,
                backgroundColor: Colors.grey);
          }
        },
        icon: Icon(
          Icons.lock,
          size: 24,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xff588F8F), Color(0x00000000)])),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontFamily: 'Times New Roman',
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    buildemail(),
                    const SizedBox(
                      height: 20,
                    ),

                    buildpassword(),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    buildRemembermecb(),
                    buildloginbtn(),
                    Singupbtn()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future signin() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: Image.asset(
                'assets/Eater_loading.gif',
                width: 100,
                height: 100,
              ),
            ));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailcontroller.text.trim(),
          password: passcontroller.text.trim());
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
          msg: "Logged in",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.grey);
    }
    Navigator.pop(context);
    Fluttertoast.showToast(
        msg: "Logged in",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.grey);
  }
}
