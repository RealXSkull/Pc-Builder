// ignore_for_file: file_names, use_key_in_widget_constructors, sized_box_for_whitespace, unnecessary_new, prefer_final_fields, non_constant_identifier_names, use_build_context_synchronously
// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgetPassword extends StatefulWidget {
  @override
  RecoverPassword createState() => RecoverPassword();
}

class RecoverPassword extends State<ForgetPassword> {
  TextEditingController _emailcontroller = new TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailcontroller.dispose();
    super.dispose();
  }

  Widget EmailText() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        'Recieve an Email to \n Reset your Password',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontSize: 30, fontFamily: 'S'),
      ),
    );
  }

  Widget buildemail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all()),
          height: 50,
          child: TextFormField(
            controller: _emailcontroller,
            keyboardType: TextInputType.emailAddress,
            validator: (val) {
              bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(val!);
              if (val == "") {
                return 'Email Cannot be Empty';
              } else if (!emailValid) {
                return 'Invalid Email Address';
              } else {
                return null;
              }
            },
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                errorStyle: TextStyle(height: 0.1),
                border: InputBorder.none,
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

  Widget recoverpas() {
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
        label: Text('Recover Password'),
        onPressed: () {
          ResetPassword();
        },
        icon: Icon(
          Icons.mail,
          size: 24,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text('FORGOT PASSWORD?'),
            backgroundColor: const Color.fromARGB(255, 48, 10, 55),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () => Navigator.pop(context, false),
            )),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: Form(
            key: formkey,
            child: Stack(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  height: double.infinity,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xfff7f7f7),
                  ),
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        EmailText(),
                        buildemail(),
                        const SizedBox(
                          height: 20,
                        ),
                        recoverpas(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future ResetPassword() async {
    final isvalid = formkey.currentState!.validate();
    if (!isvalid) return;
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
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailcontroller.text.trim(),
      );
      Fluttertoast.showToast(
          msg: 'Password Reset Email was Sent', gravity: ToastGravity.BOTTOM);
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!, gravity: ToastGravity.BOTTOM);
    }
    Navigator.pop(context);
  }
}
