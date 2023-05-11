// ignore_for_file: file_names, prefer_const_declarations

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminRights extends StatefulWidget {
  const AdminRights({super.key});

  @override
  State<AdminRights> createState() => _AdminRightsState();
}

class _AdminRightsState extends State<AdminRights> {
  var searchController = TextEditingController();
  String _selectedUserRole = 'admin';
  final List<String> _dropdownValues = ['admin', 'user'];
  var searchkey = "";

  @override
  void initState() {
    super.initState();
    // _fetchUsersList();
  }

  Future<void> _fetchUserRole(String uid) async {
    final String userId = uid; // Replace with the actual user ID
    final String role = await getUserRole(userId);
    setState(() {
      _selectedUserRole = role;
    });
  }

  Future<String> getUserRole(String userId) async {
    final userDoc = FirebaseFirestore.instance.collection('Users').doc(userId);
    final snapshot = await userDoc.get();
    return snapshot.get('role');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Admin Rights'),
          backgroundColor: const Color.fromARGB(255, 48, 10, 55),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
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
                height: 10,
              ),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Users")
                      // .collection("Users")
                      // .doc('Hardware')
                      // .collection('Gpu')
                      // .where("role", isEqualTo: 'user')
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
                          _fetchUserRole(data['userid']);
                          // print(globals.data1);
                          // print(
                          //     "database data length${data['Item Name'].length}");
                          // print("local data length${globals.data1.length}");
                          if (searchkey.isEmpty) {
                            return Card(
                              color: Colors.white,
                              child: InkWell(
                                onTap: () {
                                  // Navigator.of(context).push(
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         itemdetail(receivedMap: data),
                                  //   ),
                                  // );
                                },
                                child: ListTile(
                                  leading: SizedBox(
                                    height: 60,
                                    width: 60,
                                    child: Image.network(
                                      'https://firebasestorage.googleapis.com/v0/b/pc-builder-2c0a4.appspot.com/o/DisplayPicture%2FcYh4IuvFudXE3prpbpZ6xyhMIyX2?alt=media&token=d74a5b95-eab4-4eaa-9802-13f204168422',
                                      height: 60,
                                      width: 60,
                                    ),
                                  ),
                                  tileColor: Colors.grey[350],
                                  title: Text(data['Name']),
                                  subtitle: Text(data['Phone'].toString()),
                                  trailing: DropdownButton<String>(
                                    value: _selectedUserRole,
                                    items: _dropdownValues.map((value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedUserRole = value!;
                                      });
                                    },
                                  ),

                                  //Text(data['role']),
                                  // leading: Image.network(src),
                                ),
                              ),
                            );
                          }
                          if (data['Name']
                              .toString()
                              .toLowerCase()
                              .contains(searchkey.toLowerCase())) {
                            return Card(
                              color: Colors.white,
                              child: InkWell(
                                onTap: () {},
                                child: ListTile(
                                  leading: SizedBox(
                                    height: 60,
                                    width: 60,
                                    child: Image.network(
                                      'https://firebasestorage.googleapis.com/v0/b/pc-builder-2c0a4.appspot.com/o/DisplayPicture%2FcYh4IuvFudXE3prpbpZ6xyhMIyX2?alt=media&token=d74a5b95-eab4-4eaa-9802-13f204168422',
                                      height: 60,
                                      width: 60,
                                    ),
                                  ),
                                  title: Text(data['Name']),
                                  subtitle: Text(data['Phone'].toString()),
                                  trailing: Text(data['role']),
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
    );
  }
}
