// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp/user/Screens/splash.dart';
import '../../user/classes/global.dart' as global;

class Orderscreen extends StatefulWidget {
  Map<String, dynamic> receivedMap;

  Orderscreen({required this.receivedMap});

  @override
  State<Orderscreen> createState() => _OrderscreenState();
}

class _OrderscreenState extends State<Orderscreen> {
  final user = FirebaseAuth.instance.currentUser!;
  bool invochecker = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 48, 10, 55),
          title: Text('Order no: ${widget.receivedMap['invoice']}'),
        ),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(247, 247, 247, 1),
                ),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: (widget.receivedMap['url'] == null)
                              ? const DecorationImage(
                                  image: AssetImage('assets/all_icon.jpg'),
                                  fit: BoxFit.fill,
                                )
                              : DecorationImage(
                                  image:
                                      NetworkImage(widget.receivedMap['url']),
                                  fit: BoxFit.fill,
                                ),
                          // shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        // color: Colors.grey,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 7,
                              child: Text(
                                "${widget.receivedMap["Username"]}",
                                style: const TextStyle(
                                    fontSize: 17, color: Colors.black87),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                "Price: ${widget.receivedMap["Total"]}/- Rs",
                                style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          return Column(
                            children: const [],
                          );
                        },
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                      datatable(),
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

  // Widget InvoiceTable() {
  //   return StreamBuilder<QuerySnapshot>(
  //       stream: FirebaseFirestore.instance
  //           .collection('Orders')
  //           .where('orderid', isEqualTo: widget.receivedMap['invoice'])
  //           .snapshots(),
  //       builder: (context, snapshot) {
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           return const Center(
  //             child: CircularProgressIndicator(),
  //           );
  //         } else {
  //           return DataTable(columns: const [
  //             DataColumn(
  //               label: Text('Name'),
  //             ),
  //             DataColumn(
  //               label: Text('Quantity'),
  //             ),
  //             // DataColumn(
  //             //   label: Text('Name'),
  //             // ),
  //           ], rows:;
  //         }
  //       });
  // }

  Widget datatable() {
    return StreamBuilder<Object>(
      stream: FirebaseFirestore.instance
          .collection('Orders')
          .doc(widget.receivedMap['invoice'])
          .snapshots(),
      builder: (context, snapshot) {
        //var list = snapshot.data;
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(
                  label: Text('Item Name'),
                ),
                // DataColumn(
                //   label: Text('Price/Item'),
                // ),
                // DataColumn(
                //   label: Text('Quantity'),
                // ),
                // DataColumn(
                //   label: Text('Total Price'),
                // ),
              ],
              rows: global.items
                  .map<DataRow>(
                    (element) => DataRow(
                      cells: [
                        DataCell(SizedBox(
                            width: 150,
                            child: Text('asd 1${element['price']}'))),
                        // DataCell(
                        //   Center(
                        //     child: Text(
                        //       element['price'].toString(),
                        //     ),
                        //   ),
                        // ),
                        // DataCell(
                        //   Center(
                        //     child: Text(
                        //       element['Quantity 1'].toString(),
                        //     ),
                        //   ),
                        // ),
                        // DataCell(
                        //   Center(
                        //     child: Text(
                        //       (element['Total']).toString(),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
