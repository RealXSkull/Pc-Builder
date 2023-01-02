// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import '../classes/global.dart' as globals;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp/Screens/itemdetail.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Stream<QuerySnapshot<Object?>> zawat =
      FirebaseFirestore.instance.collection("Inventory").snapshots();
  // final dbcollector = FirebaseDatabase.instance.ref('Inventory');

  var searchkey = "";
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomCenter,
                  colors: [
                Color.fromARGB(255, 17, 7, 150),
                Color.fromARGB(255, 106, 5, 5)
              ])),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextFormField(
                  controller: searchController,
                  decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Search Anything..',
                      hintStyle: TextStyle(color: Colors.grey)),
                  textInputAction: TextInputAction.search,
                  onChanged: (value) {
                    setState(() {
                      // data = zawat.where((event) => false);
                      searchkey = value;
                      print(searchkey);
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: StreamBuilder(
                    stream: zawat,
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
                      } else {
                        return ListView(
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data() as Map<String, dynamic>;
                            return Card(
                              elevation: 5,
                              child: InkWell(
                                onTap: () {
                                  // print(data);
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => itemdetail(
                                      receivedMap: data,
                                      url: globals.url,
                                    ),
                                  ));
                                  Transition.downToUp;
                                },
                                child: ListTile(
                                  title: Text(data['Item Name']),
                                  leading: SizedBox(
                                      height: 60,
                                      width: 60,
                                      child: Image.asset(
                                        'assets/all_icon.jpg',
                                        fit: BoxFit.fill,
                                      )),
                                  subtitle: Text(data['Category']),
                                  trailing: Text(data['Price'].toString()),
                                  // leading: Image.network(src),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      }
                    },
                  ),
                  //  child: ListView.builder(
                  //   itemCount: zawat.length,
                  //   itemBuilder: (context, index) {
                  //  }),
                  //  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void searchkeyword(String query) {
  //   final suggestions = zawat.where((i) {
  //     final bookTitle = i.title;
  //   });
  // }

}
