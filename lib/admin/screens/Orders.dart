// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp/admin/screens/Orderscreen.dart';
import 'package:intl/intl.dart';
// import 'package:fyp/user/Screens/itemdetail.dart';
// import 'package:intl/intl.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => OrdersState();
}

class OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Orders'),
          backgroundColor: const Color.fromARGB(255, 48, 10, 55),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () => Navigator.pop(context, false),
          ),
        ),
        body: Stack(
          children: <Widget>[
            SizedBox(
              // height: MediaQuery.of(context).size.height,
              // width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.85,
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('Orders')
                            .orderBy('Purchase Date', descending: true)
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(snapshot.error.toString()),
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
                                NumberFormat commaFormat =
                                    NumberFormat('#,###');
                                String formattedNumber =
                                    commaFormat.format(data['Total']);
                                // Timestamp timestamp =
                                //     data['Purchased Date'];
                                // DateTime dateTime = timestamp.toDate();
                                // String formattedDate =
                                //     DateFormat.yMMMMEEEEd()
                                //         .format(dateTime);
                                return Card(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              Orderscreen(receivedMap: data),
                                        ),
                                      );
                                    },
                                    child: ListTile(
                                      tileColor: (data['status'] == 'Requested')
                                          ? Colors.grey[350]
                                          : (data['status'] == 'Approved')
                                              ? Colors.green
                                              : Colors.red,
                                      title: Text(
                                          'Invoice No: ${data['invoice']}'),
                                      subtitle:
                                          Text('Order by: ${data['Username']}'),
                                      trailing: Text(
                                        'Amount: $formattedNumber',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                );
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
    );
  }
}
