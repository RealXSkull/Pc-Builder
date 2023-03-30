// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class WarrantyList extends StatefulWidget {
  const WarrantyList({super.key});

  @override
  State<WarrantyList> createState() => _WarrantyListState();
}

class _WarrantyListState extends State<WarrantyList> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              .collection('Warranty')
                              .where('userid', isEqualTo: user.uid)
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
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var data = snapshot.data!.docs[index].data()
                                        as Map<String, dynamic>;
                                    Timestamp timestamp =
                                        data['Purchased Date'];
                                    DateTime dateTime = timestamp.toDate();
                                    String formattedDate =
                                        DateFormat.yMMMMEEEEd()
                                            .format(dateTime);
                                    return Card(
                                        child: ListTile(
                                      tileColor: (data['Status'] == 'Requested')
                                          ? Colors.grey[350]
                                          : (data['Status'] == 'Approved')
                                              ? Colors.green
                                              : Colors.red,
                                      title: Text(data['Item Name']),
                                      subtitle: Text(
                                        formattedDate,
                                        style: TextStyle(
                                            color: (data['Status'] == 'Decline')
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                      trailing: Text(
                                        data['Status'],
                                        style: TextStyle(
                                            color: (data['Status'] == 'Decline')
                                                ? Colors.white
                                                : Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ));
                                  });
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
