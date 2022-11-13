// ignore_for_file: file_names, use_key_in_widget_constructors
// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp/LoginScreen.dart';

class ForgetPassword extends StatefulWidget {
  @override
  RecoverPassword createState() => RecoverPassword();
}

class RecoverPassword extends State<ForgetPassword> {
  Widget backbtn() {
    return Container(
      alignment: Alignment.topLeft,
      height: 40,
      width: 40,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ))),
          child: Text('<-'),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          }),
    );
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
          height: 40,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('RECOVER PASSWORD'),
          backgroundColor: Colors.blueGrey,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () => Navigator.pop(context, false),
          )),
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
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // buildname(),
                    SizedBox(
                      height: 20,
                    ),
                    buildemail(),
                    const SizedBox(
                      height: 20,
                    ),
                    // buildphone(),
                    const SizedBox(
                      height: 20,
                    ),
                    // buildpassword(),
                    SizedBox(
                      height: 20,
                    ),
                    // buildconfirmpassword(),
                    SizedBox(
                      height: 20,
                    ),
                    // Registerbtn(),
                    // AlreadyAccountbtn()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
