// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, file_names, unused_import, use_build_context_synchronously

import 'package:fyp/user/Screens/WarrentyClaim.dart';
import '../Controllers/Authpage.dart';
import '../classes/global.dart' as globals;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fyp/user/Screens/LoginScreen.dart';
import 'package:fyp/Bars/bottomNavBar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fyp/user/Screens/ManageProfile.dart';
import 'package:fyp/user/Screens/Review.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Drawer(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
                color: Colors.blue,
                child: Center(
                  child: Text(
                    'CART',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                )),
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
                          .snapshots(),
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
                                  title: Text(data['Item Name']),
                                  // subtitle: Text(data['Category']),
                                  trailing: Text(data['price'].toString()),
                                  // leading: Image.network(src),
                                ),
                              );

                              return Container();
                            }),
                          );
                        }
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
