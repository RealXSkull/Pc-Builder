// ignore_for_file: file_names, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/Screens/Signup.dart';
import 'package:fyp/classes/global.dart' as globals;
import 'package:flutter/services.dart';
import 'package:flutter_launcher_icons/custom_exceptions.dart';
import 'package:textfield_search/textfield_search.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Review extends StatefulWidget {
  const Review({super.key});

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  TextEditingController myController = TextEditingController();
  double rating = 0;
  final itemname = TextEditingController();
  final itemdesccontroller = TextEditingController();
  final ref = FirebaseDatabase.instance.ref('Inventory');
  final user = FirebaseAuth.instance.currentUser!;

  @override
  void dispose() {
    myController.dispose();
    itemdesccontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('FeedBack'),
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
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromARGB(255, 17, 7, 150),
                          Color.fromARGB(255, 106, 5, 5)
                        ]),
                  ),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        builditemname(),
                        const SizedBox(
                          height: 20,
                        ),
                        // fetchData(),
                        searchtext(),
                        const SizedBox(
                          height: 39,
                        ),
                        builditemdesc(),
                        const SizedBox(
                          height: 30,
                        ),
                        buildratings(),
                        const SizedBox(
                          height: 20,
                        ),
                        submitbtn(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget buildratings() {
    return Column(children: <Widget>[
      const Text(
        'Rate Your Product',
        style: TextStyle(color: Colors.white, fontSize: 15),
      ),
      RatingBar.builder(
        minRating: 1,
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        updateOnDrag: true,
        onRatingUpdate: (rating) {
          setState(() {
            this.rating = rating;
          });
        },
      ),
      Text(
        'Rating $rating',
        style: const TextStyle(color: Colors.white),
      )
    ]);
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
          child: const Text('Submit Feedback'),
          onPressed: () {
            print(rating);
            addfeedback();
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
            color: Colors.white,
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
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.white,
                        blurRadius: 6,
                        offset: Offset(0, 2))
                  ]),
              height: 40,
              child: TextFieldSearch(
                controller: itemname,
                future: () {
                  fetchData2();
                },
                textStyle: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Product Name',
                    contentPadding: EdgeInsets.fromLTRB(10, -10, 0, 0),
                    hintStyle: TextStyle(color: Colors.black38)),
                label: 'Item Name',
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
          'Product Description',
          style: TextStyle(
            color: Colors.white,
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
                elevation: 10.0,
                shadowColor: Colors.white,
                child: TextField(
                  controller: itemdesccontroller,
                  maxLines: maxLines,
                  decoration: const InputDecoration(
                    hintText: "Enter message",
                    hintStyle: TextStyle(color: Colors.black38),
                    filled: true,
                  ),
                ),
              )),
            )
          ],
        )
      ],
    );
  }

  Future<List> fetchData() async {
    await Future.delayed(const Duration(milliseconds: 500));
    List list = [];
    List used = [];
    String inputText = myController.text;

    // list.add('value');
    print(globals.data1['Item Name'].length);
    for (int count = 0; count < globals.data1.length; count++) {
      if (globals.data1['Item Name'].toString().startsWith(myController.text)) {
        used = globals.data1['Item Name'];
        for (int i = 0; i < used.length; i++) {
          if (used.contains(globals.data1['Item Name'].toString())) {
          } else {
            list.add(globals.data1['Item Name'].toString());
          }
        }
      }
    }
    // list.add('list+asd+ ');
    // list.add('list+ $inputText');

    return list;
  }

  Future addfeedback() async {
    String message;
    try {
      final docuser = FirebaseFirestore.instance.collection('Feedback');
      final data = {
        'Item Name': 'ADATA Falcon 1 TB',
        'Message': itemdesccontroller.text,
        'Rating': rating,
        'Username': user.displayName,
      };
      await docuser.add(data);
      // await docuser.doc().set({
      //   'Item Name': 'G.Skill Aegis 16 GB (2 x 8 GB) DDR4-2133 CL15',
      //   'Message': itemdesccontroller.text,
      // });
      message = 'Feedback Sent Succesfully';
    } catch (e) {
      message = 'Error On Feedback';
    }
    Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_SHORT);
    // ScaffoldMessenger.of(context)
    //     .showSnackBar(SnackBar(content: Text(message)));
    // Navigator.pop(context);
  }

  Future<List> fetchData2() async {
    // await Future.delayed(const Duration(milliseconds: 500));
    List list = [];
    String inputText = itemname.text;
    list.add('list+ $inputText');

    return list;
  }

  Widget searchtext() {
    return TextFieldSearch(
        label: 'Product Name',
        textStyle: const TextStyle(color: Colors.white),
        controller: myController,
        future: () {
          return fetchData();
        });
  }
}
