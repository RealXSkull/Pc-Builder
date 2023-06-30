// ignore_for_file: camel_case_types, file_names, non_constant_identifier_names, must_be_immutable, use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'itemdetail.dart';

class cat_detail extends StatefulWidget {
  String Category;

  cat_detail({required this.Category});
  @override
  State<cat_detail> createState() => _cat_detailState();
}

class _cat_detailState extends State<cat_detail> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.Category),
          backgroundColor: const Color.fromARGB(255, 48, 10, 55),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Inventory')
                .where('Category', isEqualTo: widget.Category)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Something Went Wrong"),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
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
                    String formattedNumber = commaFormat.format(data['Price']);
                    // number = formattedNumber(data['Price'].toString());
                    // print(globals.data1);
                    // print(
                    //     "database data length${data['Item Name'].length}");
                    // print("local data length${globals.data1.length}");

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
                          trailing: Text(formattedNumber),
                          // leading: Image.network(src),
                        ),
                      ),
                    );
                  }),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
