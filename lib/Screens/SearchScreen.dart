// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
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
                Color.fromARGB(255, 11, 4, 109),
                Color.fromARGB(255, 109, 18, 18)
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
                    stream: FirebaseFirestore.instance
                        .collection("Inventory")
                        // .collection("Users")
                        // .doc('Hardware')
                        // .collection('Gpu')
                        .where("Category", isEqualTo: searchkey)
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
                                },
                                child: ListTile(
                                  title: Text(data['Item Name']),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
