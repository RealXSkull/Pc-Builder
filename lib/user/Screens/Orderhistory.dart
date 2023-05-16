// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp/user/Screens/DisplayOrder.dart';
import 'package:intl/intl.dart';

class Orderhistory extends StatefulWidget {
  const Orderhistory({super.key});

  @override
  State<Orderhistory> createState() => OrderhistoryListState();
}

class OrderhistoryListState extends State<Orderhistory> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Order History'),
          backgroundColor: const Color.fromARGB(255, 48, 10, 55),
        ),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: Stack(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('Orders')
                              .where('uid', isEqualTo: user.uid)
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                itemBuilder: (BuildContext context, int index) {
                                  var data = snapshot.data!.docs[index].data()
                                      as Map<String, dynamic>;
                                  Timestamp timestamp = data['Purchase Date'];
                                  DateTime dateTime = timestamp.toDate();
                                  String formattedDate =
                                      DateFormat.yMMMMEEEEd().format(dateTime);
                                  return Card(
                                      child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DisplayOrder(receivedMap: data),
                                        ),
                                      );
                                    },
                                    child: ListTile(
                                      tileColor: (data['status'] == 'Requested')
                                          ? Colors.grey[350]
                                          : (data['status'] == 'Approved')
                                              ? Colors.green
                                              : Colors.red,
                                      title: Text(data['invoice']),
                                      subtitle: Text(
                                        formattedDate,
                                        style: TextStyle(
                                            color: (data['status'] == 'Decline')
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                      trailing: Text(
                                        data['status'],
                                        style: TextStyle(
                                            color: (data['status'] == 'Decline')
                                                ? Colors.white
                                                : Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ));
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
