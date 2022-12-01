// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fyp/Signup.dart';
import 'package:image_picker/image_picker.dart';

class Manageprofile extends StatefulWidget {
  const Manageprofile({super.key});

  @override
  State<Manageprofile> createState() => _ManageprofileState();
}

class _ManageprofileState extends State<Manageprofile> {
  final _namecontroller = TextEditingController();
  FirebaseStorage storage = FirebaseStorage.instance;
  final _addcontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();
  final user = FirebaseAuth.instance.currentUser!;

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
            key: formkey,
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
                        //buildAddress(),
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
        label: Text('Update Profile'),
        onPressed: () {
          update();
        },
        icon: Icon(
          Icons.update_rounded,
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

  // Widget buildAddress() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       SizedBox(
  //         height: 10,
  //       ),
  //       Text(
  //         'Enter Your Address',
  //         style: TextStyle(
  //           color: Colors.white,
  //           fontSize: 16,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //       SizedBox(height: 10),
  //       Container(
  //         alignment: Alignment.centerLeft,
  //         decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.circular(10),
  //             boxShadow: [
  //               BoxShadow(
  //                   color: Colors.white, blurRadius: 6, offset: Offset(0, 2))
  //             ]),
  //         height: 40,
  //         child: TextField(
  //           controller: _addcontroller,
  //           keyboardType: TextInputType.text,
  //           style: TextStyle(color: Colors.black87),
  //           decoration: InputDecoration(
  //               border: InputBorder.none,
  //               prefixIcon: Icon(
  //                 Icons.person,
  //                 color: Color(0xff5ac18e),
  //               ),
  //               hintText: 'Address',
  //               hintStyle: TextStyle(color: Colors.black38)),
  //         ),
  //       )
  //     ],
  //   );
  // }

  Future update() async {
    String name = _namecontroller.text;
    String address = _addcontroller.text;
    final isValid = formkey.currentState!.validate();
    if (!isValid) return;
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
      await user.updateDisplayName(name);
      // await user.updateAddress(address);
      //     User user = result.user;
      //  user.updateProfile(displayName: name);
      // return _user(user);
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!, gravity: ToastGravity.BOTTOM);
    }
    Navigator.pop(context);
  }
}
