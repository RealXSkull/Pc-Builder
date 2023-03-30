// ignore_for_file: file_names

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:get/get.dart';
// import '../classes/global.dart' as globals;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp/user/Screens/itemdetail.dart';

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
    // User user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
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
                        // .collection("Users")
                        // .doc('Hardware')
                        // .collection('Gpu')
                        .where("Inventory", isGreaterThan: 0)
                        // .where("Item Name", arrayContains: searchkey)
                        // .where("Item Name", isEqualTo: searchkey)
                        // .startAt("i")
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

                            // print(globals.data1);
                            // print(
                            //     "database data length${data['Item Name'].length}");
                            // print("local data length${globals.data1.length}");
                            if (searchkey.isEmpty) {
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
                                    tileColor: Colors.grey[350],
                                    title: Text(data['Item Name']),
                                    subtitle: Text(data['Category']),
                                    trailing: Text(data['Price'].toString()),
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
                                        child: Image.asset(
                                          'assets/all_icon.jpg',
                                          fit: BoxFit.fill,
                                        )),
                                    title: Text(data['Item Name']),
                                    subtitle: Text(data['Category']),
                                    trailing: Text(data['Price'].toString()),
                                    // leading: Image.network(src),
                                  ),
                                ),
                              );
                            }
                            return Container();
                          }),
                          // children: snapshot.data!.docs
                          //     .map((DocumentSnapshot document) {
                          //   Map<String, dynamic> data =
                          //       document.data() as Map<String, dynamic>;
                          //   return Card(
                          //     elevation: 5,
                          //     child: InkWell(
                          //       onTap: () {
                          //         // print(data);
                          //         Navigator.of(context).push(
                          //           MaterialPageRoute(
                          //             builder: (context) => itemdetail(
                          //               receivedMap: data,
                          //               url: globals.url,
                          //             ),
                          //           ),
                          //         );
                          //       },
                          //       child: ListTile(
                          //         leading: SizedBox(
                          //             height: 60,
                          //             width: 60,
                          //             child: Image.asset(
                          //               'assets/all_icon.jpg',
                          //               fit: BoxFit.fill,
                          //             )),
                          //         title: Text(data['Item Name']),
                          //         subtitle: Text(data['Category']),
                          //         trailing: Text(data['Price'].toString()),
                          //         // leading: Image.network(src),
                          //       ),
                          //       if(data['Item Name'].toString)
                          //     ),
                          //   );
                          // }).toList(),
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
