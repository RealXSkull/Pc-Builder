// ignore_for_file: prefer_typing_uninitialized_variables

library globals;

import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Map<String, dynamic> data1 = [] as Map<String, dynamic>;
var role = "";
var url = "";
var address = "";
var name = "";

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

Future<List> getcategory(BuildContext context) async {
  var invo = [];
  final datagetter =
      await FirebaseFirestore.instance.collection('Inventory').get();
  for (int i = 0; i < datagetter.docs.length; i++) {
    if (!invo.contains(datagetter.docs[i]['Category'].toString())) {
      invo.add(datagetter.docs[i]['Category']);
    }
  }
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(invo.toString())));
  return invo;
}



Future<void> readdata(User user) async {
  FirebaseFirestore.instance
      .collection('Users')
      .doc(user.uid)
      .get()
      .then((value) {
    name = value['Name'];
    address = value['Address'];
    role = value['role'];
  });
}

// Map inventory = {'Item Name': '', 'Category': ''};

