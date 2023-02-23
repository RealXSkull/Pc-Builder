// ignore_for_file: file_names, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/user/Screens/Signup.dart';
import 'package:fyp/user/classes/global.dart' as globals;
import 'package:flutter/services.dart';
import 'package:flutter_launcher_icons/custom_exceptions.dart';
import 'package:textfield_search/textfield_search.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'itemdetail.dart';

class WarrentyClaim extends StatefulWidget {
  const WarrentyClaim({super.key});

  @override
  State<WarrentyClaim> createState() => _WarrentyClaimState();
}

class _WarrentyClaimState extends State<WarrentyClaim> {
  var data;
  final itemname = TextEditingController();
  final formkey = GlobalKey<FormState>();

  final invoiceno = TextEditingController();
  final itemdesccontroller = TextEditingController();
  final phonenumber = TextEditingController();
  String searchingtry = "";
  final user = FirebaseAuth.instance.currentUser!;
  DateTime date = DateTime.now();

  @override
  void dispose() {
    itemdesccontroller.dispose();
    itemname.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Warranty Claim'),
          backgroundColor: const Color.fromARGB(255, 48, 10, 55),
        ),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: Form(
            child: Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(247, 247, 247, 1),
                  ),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 30),
                    child: Form(
                      key: formkey,
                      child: Stack(children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            builditemname(),
                            const SizedBox(
                              height: 10,
                            ),
                            // searchtry(),
                            // const SizedBox(
                            //   height: 10,
                            // ),

                            const SizedBox(
                              height: 20,
                            ),
                            buildphonenumber(),
                            const SizedBox(
                              height: 20,
                            ),
                            buildinvoiceno(),
                            const SizedBox(
                              height: 20,
                            ),
                            datepicker(),
                            // fetchData(),
                            // searchtext(),
                            const SizedBox(
                              height: 39,
                            ),
                            builditemdesc(),
                            const SizedBox(
                              height: 30,
                            ),

                            const SizedBox(
                              height: 20,
                            ),
                            submitbtn(),
                          ],
                        ),
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget datepicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Purchased Date: ',
          style: TextStyle(
              color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 140,
          child: CupertinoDatePicker(
            minimumYear: 2015,
            maximumYear: DateTime.now().year,
            mode: CupertinoDatePickerMode.date,
            initialDateTime: DateTime.now(),
            onDateTimeChanged: (date) {
              setState(() {
                this.date = date;
              });
              // Do something
            },
          ),
        ),
      ],
    );
  }

  Widget submitbtn() {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.lightBlue),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ))),
          child: const Text('Submit Request'),
          onPressed: () {
            warranty();
            // addfeedback();
          }),
    );
  }

  Widget builditemname() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Product Name',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Stack(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all()),
              height: 40,
              child: TextFieldSearch(
                controller: itemname,
                // autovalidateMode: AutovalidateMode.onUserInteraction,
                // validator: (value) {
                //   if (value == "" || value == null) {
                //     return 'Value cannot be Empty';
                //   } else {
                //     return null;
                //   }
                // },
                minStringLength: 1,
                future: () {
                  return globals.getinvo(itemname.text);
                },
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Product Name',
                    contentPadding: EdgeInsets.fromLTRB(10, -10, 0, 0),
                    hintStyle: TextStyle(color: Colors.black38)),
                label: 'search',
              ),
            )
          ],
        )
      ],
    );
  }

  Widget builditemdesc() {
    const maxLines = 5;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Describe The Issue: ',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Stack(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                  child: Material(
                child: Container(
                  decoration: BoxDecoration(border: Border.all()),
                  child: TextFormField(
                    controller: itemdesccontroller,
                    maxLines: maxLines,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == "" || value == null) {
                        return 'Value cannot be Empty';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter message",
                      hintStyle: TextStyle(color: Colors.black38),
                      filled: true,
                    ),
                  ),
                ),
              )),
            )
          ],
        )
      ],
    );
  }

  Widget buildphonenumber() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Enter Your Contact Number',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Stack(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all()),
              height: 40,
              child: TextFormField(
                controller: phonenumber,
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null) {
                    return 'Value cannot be Empty';
                  } else if (value.length < 11) {
                    return 'Length should be 11';
                  } else {
                    return null;
                  }
                },
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '03xx-xxxxxxx',
                    contentPadding: EdgeInsets.fromLTRB(10, -10, 0, 0),
                    hintStyle: TextStyle(color: Colors.black38)),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget buildinvoiceno() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Enter Invoice Number',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Stack(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all()),
              height: 40,
              child: TextFormField(
                controller: invoiceno,
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == "" || value == null) {
                    return 'Value cannot be Empty';
                  } else {
                    return null;
                  }
                },
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '1234',
                    contentPadding: EdgeInsets.fromLTRB(10, -10, 0, 0),
                    hintStyle: TextStyle(color: Colors.black38)),
              ),
            )
          ],
        )
      ],
    );
  }

  Future warranty() async {
    String message;
    final isValid = formkey.currentState!.validate();
    if (!isValid) return;
    try {
      final docuser = FirebaseFirestore.instance.collection('Warranty');
      final data = {
        'Item Name': itemname.text,
        'Message': itemdesccontroller.text,
        'Purchased Date': date,
        'Contact': phonenumber.text,
        'invoice': invoiceno.text,
        'Username': user.displayName,
      };
      await docuser.add(data);
      // await docuser.doc().set({
      //   'Item Name': 'G.Skill Aegis 16 GB (2 x 8 GB) DDR4-2133 CL15',
      //   'Message': itemdesccontroller.text,
      // });
      message = 'Your Request has been Sent Succesfully';
    } catch (e) {
      message = 'Error On your Request';
    }
    Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_SHORT);
  }
}
