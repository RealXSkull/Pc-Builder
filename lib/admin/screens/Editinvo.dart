// ignore_for_file: file_names, camel_case_types
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:get/get.dart';
// import '../classes/global.dart' as globals;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp/user/Screens/itemdetail.dart';
import 'package:intl/intl.dart';

import 'edit_invo_detail.dart';

class Edit_invo extends StatefulWidget {
  const Edit_invo({super.key});

  @override
  State<Edit_invo> createState() => _Edit_invoState();
}

class _Edit_invoState extends State<Edit_invo> {
  @override
  void initState() {
    super.initState();
  }

  var searchkey = "";
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // User user = FirebaseAuth.instance.currentUser!;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Select Item to Edit'),
          backgroundColor: const Color.fromARGB(255, 48, 10, 55),
        ),
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(247, 247, 247, 1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(5)),
                    child: TextFormField(
                      controller: searchController,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: Icon(Icons.search),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Search Anything..',
                          hintStyle: TextStyle(color: Colors.grey)),
                      textInputAction: TextInputAction.search,
                      onChanged: (value) {
                        setState(() {
                          searchkey = value;
                          // print(searchkey);
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Inventory")
                          .where("Inventory", isGreaterThan: 0)
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
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: ((context, index) {
                              var data = snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>;
                              NumberFormat commaFormat = NumberFormat('#,###');
                              String formattedNumber =
                                  commaFormat.format(data['Price']);

                              if (searchkey.isEmpty) {
                                return Card(
                                  color: Colors.white,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              Edit_invo_detail(
                                                  receivedMap: data),
                                        ),
                                      );
                                    },
                                    child: ListTile(
                                      leading: SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: (data['url'] == null ||
                                                data['url'] == "")
                                            ? Image.asset(
                                                'assets/all_icon.jpg',
                                                fit: BoxFit.fill,
                                              )
                                            : Image.network(
                                                data['url'],
                                                height: 60,
                                                width: 60,
                                              ),
                                      ),
                                      title: Text(data['Item Name']),
                                      subtitle: Text(data['Category']),
                                      enableFeedback: true,

                                      trailing: Text(formattedNumber),

                                      // leading: Image.network(src),
                                    ),
                                  ),
                                );
                              }
                              if (data['Item Name']
                                  .toString()
                                  .toLowerCase()
                                  .contains(searchkey.toLowerCase())) {
                                return Card(
                                  color: Colors.white,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              itemdetail(receivedMap: data),
                                        ),
                                      );
                                    },
                                    child: ListTile(
                                      leading: SizedBox(
                                        height: 60,
                                        width: 60,
                                        child: (data['url'] == null)
                                            ? Image.asset(
                                                'assets/all_icon.jpg',
                                                fit: BoxFit.fill,
                                              )
                                            : Image.network(
                                                data['url'],
                                                height: 60,
                                                width: 60,
                                              ),
                                      ),
                                      title: Text(data['Item Name']),
                                      subtitle: Text(data['Category']),
                                      enableFeedback: true,
                                      trailing: Text(formattedNumber),
                                    ),
                                  ),
                                );
                              }
                              return Container();
                            }),
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
      ),
    );
  }
}
