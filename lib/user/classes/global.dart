// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

// library globals;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Map<String, dynamic> data1 = [] as Map<String, dynamic>;
var role = "";
var url = "";
var itemurl = "";
var address = "";
var phone = "";
var name = "";
var inventory;
List items = [];
Image? img;

// List inventory = {'Item Name': '', 'Category': ''} as List;

Future<List> getinvo(String search) async {
  var invo = [];
  final datagetter =
      await FirebaseFirestore.instance.collection('Inventory').get();
  for (int i = 0; i < datagetter.docs.length; i++) {
    if (datagetter.docs[i]['Item Name']
        .toString()
        .toLowerCase()
        .contains(search.toLowerCase())) {
      invo.add(datagetter.docs[i]['Item Name']);
    }
  }
  return invo;
}

Future<List<String>> getcategory2(BuildContext context) async {
  final datagetter =
      await FirebaseFirestore.instance.collection('Inventory').get();
  inventory = [];
  for (int i = 0; i < datagetter.docs.length; i++) {
    if (!inventory.contains(datagetter.docs[i]['Category'].toString())) {
      inventory.add(datagetter.docs[i]['Category']);
    }
  }
  return inventory.cast<String>();
}

Future<List> getcategory(BuildContext context) async {
  final datagetter =
      await FirebaseFirestore.instance.collection('Inventory').get();
  for (int i = 0; i < datagetter.docs.length; i++) {
    if (!inventory.contains(datagetter.docs[i]['Category'].toString())) {
      inventory.add(datagetter.docs[i]['Category']);
    }
  }
  return inventory;
}

Future<void> readdata(User user) async {
  FirebaseFirestore.instance
      .collection('Users')
      .doc(user.uid)
      .get()
      .then((value) {
    name = value['Name'];
    address = value['Address'];
    phone = value['Phone'].toString();
    role = value['role'];
  });
}

// Map inventory = {'Item Name': '', 'Category': ''};

