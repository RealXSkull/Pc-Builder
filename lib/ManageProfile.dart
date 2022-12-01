// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field

import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class Manageprofile extends StatefulWidget {
  const Manageprofile({super.key});

  @override
  State<Manageprofile> createState() => _ManageprofileState();
}

class _ManageprofileState extends State<Manageprofile> {
  final _namecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Update Profile'),
          backgroundColor: Colors.blueGrey,
        ),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: Form(
            // key: formkey,
            child: Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
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
                        buildname(),
                        SizedBox(
                          height: 15,
                        ),
                        // buildemail(),
                        const SizedBox(
                          height: 20,
                        ),
                        // buildphone(),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // buildpassword(),
                        SizedBox(
                          height: 20,
                        ),
                        //buildconfirmpassword(),
                        SizedBox(
                          height: 20,
                        ),
                        // Registerbtn(),
                        SizedBox(
                          height: 20,
                        ),
                        recoverpas()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
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
        label: Text('Upload Image'),
        onPressed: () {
          // if (_emailcontroller.text.isNotEmpty) {
          //   ResetPassword();
          // } else {
          //   Fluttertoast.showToast(
          //       msg: "Invalid Credentials",
          //       toastLength: Toast.LENGTH_SHORT,
          //       backgroundColor: Colors.grey);
          // }
        },
        icon: Icon(
          Icons.image,
          size: 24,
        ),
      ),
    );
  }

  Widget buildname() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Text(
          'Edit Your Full Name',
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
            controller: _namecontroller,
            keyboardType: TextInputType.text,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.person,
                  color: Color(0xff5ac18e),
                ),
                hintText: 'Full Name',
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        )
      ],
    );
  }
}
