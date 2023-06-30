// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field, file_names, unnecessary_string_interpolations, sort_child_properties_last, use_build_context_synchronously, prefer_typing_uninitialized_variables, unnecessary_null_comparison

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_database/firebase_database.dart';
import '../classes/global.dart' as global;
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
// import '../Bars/NavBar.dart';

class Manageprofile extends StatefulWidget {
  const Manageprofile({super.key});

  @override
  State<Manageprofile> createState() => _ManageprofileState();
}

class _ManageprofileState extends State<Manageprofile> {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  PlatformFile? pickedFile;
  var dataa;
  final user = FirebaseAuth.instance.currentUser!;
  final _phonecontroller = TextEditingController(text: '0${global.phone}');
  int maxLength = 11;
  var contactno = "";
  final _namecontroller = TextEditingController(text: global.name);
  FirebaseStorage storage = FirebaseStorage.instance;
  final _addcontroller = TextEditingController(text: global.address);
  final formkey = GlobalKey<FormState>();

  var image;

  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _phonecontroller.dispose();
    _namecontroller.dispose();
    _addcontroller.dispose();
    super.dispose();
  }

  Future<void> readdata() async {
    _namecontroller.text = dataa['name'];
    _addcontroller.text = dataa['address'];
    _phonecontroller.text = dataa['contactno'];
  }

  Future imagepicker() async {
    final pick = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pick != null) {
        image = File(pick.path);
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // drawer: NavBar(),
        appBar: AppBar(
          title: Text('Manage Account'),
          backgroundColor: Color.fromARGB(255, 48, 10, 55),
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
                    color: Color.fromRGBO(247, 247, 247, 1),
                  ),
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              (image != null)
                                  ? Expanded(
                                      flex: 1,
                                      child: Visibility(
                                        visible: true,
                                        child: ClipRRect(
                                          child: Image.file(
                                            image,
                                            fit: BoxFit.fill,
                                            height: 54,
                                            width: 54,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(27),
                                        ),
                                      ),
                                    )
                                  : Expanded(
                                      flex: 1,
                                      child: Visibility(
                                        visible: true,
                                        child: ClipRRect(
                                          child: Image.network(
                                            global.url,
                                            fit: BoxFit.fill,
                                            height: 54,
                                            width: 54,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(27),
                                        ),
                                      ),
                                    ),
                              Spacer(),
                              Expanded(
                                flex: 5,
                                child: buildname(),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        buildAddress(),
                        SizedBox(
                          height: 20,
                        ),
                        buildphone(),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        selectimage(),
                        SizedBox(
                          height: 20,
                        ),
                        updateprof()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget selectimage() {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ))),
        label: Text('Select Image'),
        onPressed: () {
          imagepicker();
        },
        icon: Icon(
          Icons.camera_alt_outlined,
          size: 24,
        ),
      ),
    );
  }

  Widget buildphone() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Contact No.',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(),
          ),
          height: 40,
          child: TextField(
            controller: _phonecontroller,
            onChanged: (String newVal) {
              if (newVal.length <= maxLength) {
                contactno = newVal;
              } else {
                _phonecontroller.text = contactno;
              }
            },
            // maxLength: 11,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.black87),
            decoration: const InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.phone,
                  color: Color(0xff5ac18e),
                ),
                hintText: '03xx-xxxxxxx',
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        )
      ],
    );
  }

  Widget updateprof() {
    return SizedBox(
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
          'Enter Your Full Name',
          style: TextStyle(
            color: Colors.black87,
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
            border: Border.all(),
          ),
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

  Widget buildAddress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Text(
          'Enter Your Address',
          style: TextStyle(
            color: Colors.black87,
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
          height: 40,
          child: TextField(
            controller: _addcontroller,
            keyboardType: TextInputType.text,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
                  color: Color(0xff5ac18e),
                ),
                hintText: 'Address',
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        )
      ],
    );
  }

  Future update() async {
    Reference reff =
        FirebaseStorage.instance.ref().child('DisplayPicture').child(user.uid);
    String name = _namecontroller.text;
    String address = _addcontroller.text;

    final isValid = formkey.currentState!.validate();
    if (!isValid) return;

    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()),
      );
      if (name != null) {
        await user.updateDisplayName(name);
        final docuser =
            FirebaseFirestore.instance.collection('Users').doc(user.uid);
        final data = {
          'Name': name,
          'Address': address,
          // 'role': global.role,
          'contactno': _phonecontroller.text
        };
        await docuser.update(data);
      }
      if (image != null) await reff.putFile(image);
      final ref = FirebaseStorage.instance
          .ref()
          .child("DisplayPicture")
          .child(user.uid);
      global.url = await ref.getDownloadURL();
      // Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profile Updated!'),
        ),
      );
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!, gravity: ToastGravity.BOTTOM);
    }
    Navigator.pop(context);
  }
}
