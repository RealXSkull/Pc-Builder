// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, file_names, unused_import, use_build_context_synchronously

import 'package:fyp/user/Screens/WarrentyClaim.dart';
import '../Controllers/Authpage.dart';
import '../classes/global.dart' as globals;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fyp/user/Screens/LoginScreen.dart';
import 'package:fyp/user/Bars/bottomNavBar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fyp/user/Screens/ManageProfile.dart';
import 'package:fyp/user/Screens/Review.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initstate() {
    // totalcounter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var total = 0;
    var dc = 0;
    var cost = 0;
    final user = FirebaseAuth.instance.currentUser!;

    //    Future totalcounter() async{
    //   StreamBuilder(
    //     stream: FirebaseFirestore.instance.collection('Users').doc(user.uid).collection('Cart').snapshots(),
    //     builder: (context, snapshot) {
    //     },
    //   );
    // }

    Future inc(Map<String, dynamic> receivedMap) async {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .collection('Cart')
          .where('Item Name', isEqualTo: receivedMap['Item Name'])
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final userRef = querySnapshot.docs.first.reference;
        final count = querySnapshot.docs.first.data();
        await userRef.update({'Count': FieldValue.increment(1)});
      }
    }

    Future dec(Map<String, dynamic> receivedMap) async {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .collection('Cart')
          .where('Item Name', isEqualTo: receivedMap['Item Name'])
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final userRef = querySnapshot.docs.first.reference;
        final count = querySnapshot.docs.first.data();
        await userRef.update({'Count': FieldValue.increment(-1)});
      }
    }

    return Drawer(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.blue,
              child: Center(
                child: Text(
                  'My Cart',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: ListView(
              shrinkWrap: true,
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
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
                          return const Center(
                            child: Text(
                              'Cart is Empty',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          );
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: ((context, index) {
                              var data = snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>;

                              // total = data['price'];
                              return Card(
                                color: Colors.white,
                                child: ListTile(
                                  // leading: SizedBox(
                                  //     height: 60,
                                  //     width: 60,
                                  //     child: Image.asset(
                                  //       'assets/all_icon.jpg',
                                  //       fit: BoxFit.fill,
                                  //     )),
                                  tileColor: Colors.grey[350],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  title: Text(data['Item Name']),
                                  subtitle: Text(
                                    'Price: ${data['price'].toString()}/- ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
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
                                          dec(data);
                                        },
                                      ),
                                      Text(data['Count'].toString()),
                                      IconButton(
                                        icon: Icon(Icons.add),
                                        onPressed: () {
                                          inc(data);
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
            // flex: 1,
            child: Container(
              padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
              width: MediaQuery.of(context).size.width,
              color: Colors.blue,
              child: Text(
                'Total is: $total',
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
