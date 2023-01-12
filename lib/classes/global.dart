library globals;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

Map<String, dynamic> data1 = [] as Map<String, dynamic>;

var url = "";
var name = "";
Map<dynamic, dynamic> Invo = "" as Map;

// List inventory = {'Item Name': '', 'Category': ''} as List;

Map inventory = {'Item Name': '', 'Category': ''};
method() async {
  final documents = await FirebaseFirestore.instance
      .collection('Users')
      .where("Name", isEqualTo: "zawat masta")
      .snapshots();
  final userObject = documents.first;
  print(userObject);
}

final topUserPostsRef = FirebaseFirestore.instance.collection("Users");

method2() async {
  DatabaseReference postListRef = await FirebaseDatabase.instance.ref("posts");
  DatabaseReference newPostRef = await postListRef.push();
  print(newPostRef);
}

Map<String, int> map1 = {};
Stream<QuerySnapshot<Map<String, dynamic>>> fetchinvo =
    FirebaseFirestore.instance.collection("Inventory").snapshots();
