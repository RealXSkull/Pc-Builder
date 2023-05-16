// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, file_names, unused_import, use_build_context_synchronously, non_constant_identifier_names, avoid_types_as_parameter_names, avoid_function_literals_in_foreach_calls, prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:fyp/user/Screens/WarrentyClaim.dart';
import 'package:fyp/user/Screens/checkout.dart';
import 'package:fyp/user/classes/cartcalc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../Controllers/Authpage.dart';
import '../classes/global.dart' as globals;
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fyp/user/Screens/LoginScreen.dart';
import 'package:fyp/user/Bars/bottomNavBar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fyp/user/Screens/ManageProfile.dart';
import 'package:fyp/user/Screens/Review.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

double totalPrice = 0;
double sum = 0;
double checker = 0;
double total = 0;
var dc = 0;
var cost = 0;
List itemprices = [];
var data;
final user = FirebaseAuth.instance.currentUser!;

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    globals.items.clear();
    super.initState();
    calculator();
  }

  Future calculator() async {
    sum = 0;
    total = 0;
    FirebaseFirestore.instance.collection('Users/${user.uid}/Cart').get().then(
      (querySnapshot) {
        querySnapshot.docs.forEach((result) {
          sum += result.data()['price'] * result.data()['Count'];
        });
        setState(() {
          checker = sum;
          total = checker + dc;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //    Future totalcounter() async{
    //   StreamBuilder(
    //     stream: FirebaseFirestore.instance.collection('Users').doc(user.uid).collection('Cart').snapshots(),
    //     builder: (context, snapshot) {
    //     },
    //   );
    // }

    Future inc(Map<String, dynamic> receivedMap, int index) async {
      try {
        final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .collection('Cart')
            .where('Item Name', isEqualTo: globals.items[index]['Item Name'])
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          final userRef = querySnapshot.docs.first.reference;

          await userRef.update({'Count': FieldValue.increment(1)});
          calculator();
        }
      } on FirebaseException catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }

    Future dec(Map<String, dynamic> receivedMap, int index) async {
      try {
        final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .collection('Cart')
            .where('Item Name', isEqualTo: globals.items[index]['Item Name'])
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          final docRef = querySnapshot.docs.last.reference;
          await docRef.update({'Count': FieldValue.increment(-1)});

          FirebaseFirestore.instance
              .collection('Users/${user.uid}/Cart')
              .get()
              .then(
            (querySnapshot) {
              querySnapshot.docs.forEach((result) async {
                if (result.data()['Count'] <= 0) {
                  await docRef.delete();
                }
              });
              setState(() {
                checker = sum;
                total = checker + dc;
              });
            },
          );
          calculator();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Cart Updated!')));
        }
      } on FirebaseException catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
      // if(querySnapshot.docs['Count'])
    }

    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              color: Colors.blue,
              height: MediaQuery.of(context).size.height * 0.05, //zawat
              child: Center(
                child: Text(
                  'My Cart',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.657, //zawat
              child: ListView(
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.657,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('Users')
                            .doc(user.uid)
                            .collection('Cart')
                            .snapshots(includeMetadataChanges: true),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return const Center(
                              child: Text("Something Went Wrong"),
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              heightFactor: 3,
                              widthFactor: 3,
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: CircularProgressIndicator(),
                              ),
                            );
                          } else if (snapshot.data!.docs.isEmpty) {
                            // return const Center(
                            return Center(
                              child: Text(
                                'Cart is Empty',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            );
                            // );
                          } else {
                            return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: ((context, index) {
                                data = snapshot.data!.docs[index].data()
                                    as Map<String, dynamic>;
                                if (globals.items.length > index) {
                                  globals.items.clear();
                                }
                                globals.items
                                    .add(snapshot.data!.docs[index].data());
                                // globals.items.add(data);
                                // total = data['price'];
                                return Card(
                                  color: Colors.white,
                                  child: ListTile(
                                    // leading: SizedBox(
                                    //   height: 50,
                                    //   width: 50,
                                    //   child: Image.asset(
                                    //     'assets/all_icon.jpg',
                                    //     fit: BoxFit.fill,
                                    //   ),
                                    // ),
                                    tileColor: Colors.grey[350],
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    title: Text(data['Item Name']),
                                    subtitle: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Price: ',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            NumberFormat.simpleCurrency(
                                              locale: 'ur_PK',
                                              decimalDigits: 0,
                                            ).format(data['price']),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ]),
                                    // trailing: Column(
                                    //   mainAxisSize: MainAxisSize.min,
                                    //   children: [
                                    // Text(data['price'].toString()),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            Icons.remove,
                                            size: 20,
                                          ),
                                          onPressed: () {
                                            // ScaffoldMessenger.of(context)
                                            //     .showSnackBar(SnackBar(
                                            //         content:
                                            //             Text(index.toString())));
                                            dec(data, index);
                                          },
                                        ),

                                        Container(
                                          width: 22,
                                          height: 25,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.white,
                                          ),
                                          child: Center(
                                            child: Text(
                                              data['Count'].toString(),
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.add),
                                          onPressed: () {
                                            inc(data, index);
                                          },
                                        ),
                                        //   ],
                                        // ),
                                      ],
                                    ),
                                    // trailing: Text(data['price'].toString()),
                                    // leading: Image.network(src),
                                  ),
                                );
                              }),
                            );
                          }
                        }),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.10, //zawat
                padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                width: MediaQuery.of(context).size.width,
                color: Color(0xfff4f4f4),
                child: Column(
                  children: [
                    Row(children: [
                      Text(
                        'Price:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                      Spacer(),
                      Text(
                        NumberFormat.simpleCurrency(
                          locale: 'ur_PK',
                          decimalDigits: 2,
                        ).format(checker),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ]),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          'Delivery Charges:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                        Spacer(),
                        Text(
                          dc.toString(),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 2,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 2,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          'Total:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                        Spacer(),
                        Text(
                          NumberFormat.simpleCurrency(
                            locale: 'ur_PK',
                            decimalDigits: 2,
                          ).format(total),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Expanded(flex: 2, child: clearcart()),
                        // Spacer(),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(flex: 2, child: checkoutbtn()),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget checkoutbtn() {
    return SizedBox(
      height: 40,
      width: MediaQuery.of(context).size.width * 0.4,
      child: ElevatedButton.icon(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ))),
        label: Text('Checkout'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => checkoutscreen(
                receivedMap: data,
                total: total,
                items: globals.items,
              ),
            ),
          );
        },
        icon: Icon(
          Icons.shopping_cart_checkout,
          size: 24,
        ),
      ),
    );
  }

  Widget clearcart() {
    return SizedBox(
      height: 40,
      width: MediaQuery.of(context).size.width * 0.4,
      child: ElevatedButton.icon(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ))),
        label: Text(
          'Clear Cart',
          style: TextStyle(color: Colors.lightBlue),
        ),
        onPressed: () {
          emptycart();
        },
        icon: Icon(
          Icons.remove_shopping_cart,
          size: 24,
          color: Colors.lightBlue,
        ),
      ),
    );
  }

  Future emptycart() async {
    try {
      FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .collection('Cart')
          .get()
          .then((snapshot) {
        for (DocumentSnapshot ds in snapshot.docs) {
          ds.reference.delete();
        }
      });
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future checkout() async {
    try {
      final res = FirebaseFirestore.instance.collection('Order').doc();
      final doc = {
        // 'Item Name': widget.receivedMap['Item Name'],
        // 'quantity': widget.receivedMap['Price'],
        'OrderId': 0001,
        'total': total
      };
      await res.set(doc);
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
