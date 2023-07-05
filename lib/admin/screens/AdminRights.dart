// ignore_for_file: file_names, prefer_const_declarations, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminRights extends StatefulWidget {
  const AdminRights({super.key});

  @override
  State<AdminRights> createState() => _AdminRightsState();
}

class _AdminRightsState extends State<AdminRights> {
  var searchController = TextEditingController();
  var searchkey = "";
  final _CurrentUser = FirebaseAuth.instance.currentUser!.uid;

  late List<String> _selectedUserRoles = [];

  final List<String> _dropdownValues = ['admin', 'user'];

  @override
  void initState() {
    super.initState();
    _fetchUserRoles();
  }

  Future<void> _fetchUserRoles() async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('userid', isNotEqualTo: _CurrentUser)
          .get();

      setState(() {
        _selectedUserRoles = snapshot.docs.map<String>((doc) {
          final role = (doc.data() as Map<String, dynamic>)['role'] as String?;

          return role ?? 'user'; // Provide a default role if it is null
        }).toList();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching user roles: $e'),
        ),
      );
    }
  }

  Future<void> _updateUserRole(String uid, String newRole, String name) async {
    // Update the user role in Firebase based on the index and new role
    final DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('Users').doc(uid).get();

    if (snapshot.exists) {
      final DocumentReference userRef = snapshot.reference;
      await userRef.update({'role': newRole});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$name\'s role Update'),
        ),
      );
    }
  }

  //  Future<void> _updateUserRole(int index, String newRole) async {
  //   // Update the user role in Firebase based on the index and new role
  //   final DocumentSnapshot snapshot = await FirebaseFirestore.instance
  //       .collection('Users')
  //       .doc('user_${index + 1}')
  //       .get();

  //   if (snapshot.exists) {
  //     final DocumentReference userRef = snapshot.reference;
  //     await userRef.update({'role': newRole});
  //     print('User ${index + 1} role updated successfully.');
  //   }
  // }

  // Future<void> _fetchuserRoles() async {
  //   final querySnapshot =
  //       await FirebaseFirestore.instance.collection('Users').get();

  // }

  // Future<void> _fetchUserRoles() async {
  //   // Fetch data from multiple collections and store the user roles in _selectedUserRoles
  //   try {
  //     QuerySnapshot snapshot = await FirebaseFirestore.instance
  //         .collectionGroup('Users')
  //         .get(); // Fetch all documents from all collections named 'Users'

  //     setState(() {
  //       _selectedUserRoles = snapshot.docs.map<String>((doc) {
  //         return (doc.data() as Map<String, dynamic>)['role'] ?? '';
  //       }).toList();
  //     });
  //   } catch (e) {
  //     // Error occurred while fetching data, handle error case if needed
  //     print('Error fetching user roles: $e');
  //   }
  // }

  // Future<String> getUserRole(String userId) async {
  //   final userDoc = FirebaseFirestore.instance.collection('Users').doc(userId);
  //   final snapshot = await userDoc.get();
  //   return snapshot.get('role');
  // }

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
                      .where('userid', isNotEqualTo: _CurrentUser)
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
                          final role = _selectedUserRoles[index];
                          // _selectedUserRoles[index] = data['role'];
                          // _fetchUserRole(data['userid']);
                          // _selectedUserRole = data['role'];
                          if (searchkey.isEmpty) {
                            return Card(
                              color: Colors.white,
                              child: ListTile(
                                  leading: SizedBox(
                                    height: 60,
                                    width: 60,
                                    child: Image.network(
                                      (data['url'] != null || data['url'] != "")
                                          ? data['url']
                                          : 'https://firebasestorage.googleapis.com/v0/b/pc-builder-2c0a4.appspot.com/o/DisplayPicture%2FcYh4IuvFudXE3prpbpZ6xyhMIyX2?alt=media&token=d74a5b95-eab4-4eaa-9802-13f204168422',
                                      height: 60,
                                      width: 60,
                                    ),
                                  ),
                                  tileColor: Colors.grey[350],
                                  title: Text(data['Name']),
                                  subtitle: Text('0${data['Phone']}'),
                                  trailing: DropdownButton<String>(
                                    value: role,
                                    items: _dropdownValues.map((value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedUserRoles[index] = value!;
                                        _updateUserRole(data['userid'], value,
                                            data['Name']);
                                        // _updateUserRole(index, value);
                                      });
                                    },
                                  )
                                  // trailing: DropdownButton<String>(
                                  //   value: _selectedUserRoles[index],
                                  //   items: _dropdownValues.map((value) {
                                  //     return DropdownMenuItem(
                                  //       value: value,
                                  //       child: Text(value),
                                  //     );
                                  //   }).toList(),
                                  //   onChanged: (value) {
                                  //     setState(() {
                                  //       _selectedUserRoles[index] = value!;
                                  //       // _selectedUserRole = value!;
                                  //     });
                                  //   },
                                  // ),
                                  ),
                            );
                          } else if (data['Name']
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
