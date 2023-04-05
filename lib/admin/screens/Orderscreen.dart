// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, file_names, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp/admin/screens/Orders.dart';
import 'package:fyp/user/classes/orderdetails.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../user/classes/global.dart' as global;
import 'package:intl/intl.dart';

class Orderscreen extends StatefulWidget {
  Map<String, dynamic> receivedMap;
  Orderscreen({required this.receivedMap});

  @override
  State<Orderscreen> createState() => _OrderscreenState();
}

class _OrderscreenState extends State<Orderscreen> {
  bool status = true;

  getDataFromDatabase() async {
    var getValue = await FirebaseFirestore.instance.collection('Orders').get();
    return getValue;
  }

  final user = FirebaseAuth.instance.currentUser!;
  bool invochecker = false;

  late List<Map<String, dynamic>> orders;

  final Stream<QuerySnapshot> orderStream =
      FirebaseFirestore.instance.collection('Orders').snapshots();
  String formattedNumber = '';
  @override
  void initState() {
    super.initState();

    orders = [];
    getOrders().then((value) => setState(() {
          orders = value;
        }));

    getrows();
    formatnumber();
  }

  List<DataRow> rows = [];
  Future getrows() async {
    await FirebaseFirestore.instance
        .collection('Orders')
        .doc(widget.receivedMap['invoice'].toString())
        .get()
        .then(
      (value) {
        Map<String, dynamic> data = value.data()!;
        List<Map<String, dynamic>> orderList = [];
        String formattedNumber2;
        // List<Map<String, dynamic>>

        for (int i = 1; i <= data.length; i++) {
          if (data['Item $i'] != null && data['Quantity $i'] != null) {
            NumberFormat commaFormat = NumberFormat('#,###');
            formattedNumber2 = commaFormat.format(data['Price $i']);
            Map<String, dynamic> order = {
              'Item $i': '${data['Item $i']}',
              'Quantity $i': '${data['Quantity $i']}',
              'Price/Item': formattedNumber2
            };
            orderList.add(order);
          }
        }
        orders = orderList;
      },
    );

    // List<Map<String, dynamic>> orders = [
    //   {'Item 1': 'Shirt', 'Quantity 1': 2, 'Total': 200},
    //   {'Item 2': 'Pants', 'Quantity 2': 1, 'Total': 100},
    //   {'Item 3': 'Socks', 'Quantity 3': 5, 'Total': 50},
    // ];
    for (int i = 0; i < orders.length; i++) {
      Map<String, dynamic> order = orders[i];

      // Create a list of DataCells for this row
      List<DataCell> cells = [];
      order.forEach((key, value) {
        cells.add(DataCell(Text('$value')));
      });

      // Add the row to the list of rows
      rows.add(DataRow(cells: cells));
    }
  }

  formatnumber() {
    NumberFormat commaFormat = NumberFormat('#,###');
    formattedNumber = commaFormat.format(widget.receivedMap["Total"]);
  }

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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Order by: ${widget.receivedMap["Username"]}",
                                    style: const TextStyle(
                                        fontSize: 17, color: Colors.black87),
                                  ),
                                  Text(
                                    "Contact no: ${widget.receivedMap["contact"]}",
                                    style: const TextStyle(
                                        fontSize: 17, color: Colors.black87),
                                  ),
                                  Text(
                                    "Address: ${widget.receivedMap["Address"]}",
                                    style: const TextStyle(
                                        fontSize: 17, color: Colors.black87),
                                  ),
                                  Text(
                                    "Instructions: ${widget.receivedMap["message"]}",
                                    style: const TextStyle(
                                        fontSize: 17, color: Colors.black87),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                "Price: $formattedNumber/- Rs",
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
                        height: 30,
                      ),
                      datatable(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Visibility(
          visible: (widget.receivedMap['status'] == 'Requested')
              ? status = true
              : status = false,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 50.0,
                width: double.infinity,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.44,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        onPressed: () {
                          reject();
                        },
                        child: const Text('Reject Order'),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.44,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        onPressed: () {
                          accept();
                        },
                        child: const Text('Accept Order'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Future<List<Map<String, dynamic>>> getOrders() async {
    var orders = <Map<String, dynamic>>[];

    try {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('Orders')
          .where('invoice', isEqualTo: widget.receivedMap['invoice'])
          .get();

      for (var doc in querySnapshot.docs) {
        var data = doc.data();
        var order = <String, dynamic>{};

        for (var i = 0; i <= data.length - 3; i++) {
          order['Item $i'] = data['Item $i'];
          order['Quantity $i'] = data['Quantity $i'];
        }

        order['Total'] = data['Total'];
        order['Purchase Date'] = data['Purchase Date'];
        order['Username'] = data['Username'];
        order['Contact'] = data['contact'];
        order['Invoice'] = data['invoice'];

        orders.add(order);
      }

      return orders;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Widget datatable() {
    return SingleChildScrollView(
      child: DataTable(columns: const [
        DataColumn(label: Text('Item Name')),
        DataColumn(label: Text('Quantity')),
        DataColumn(label: Text('Price')),
        // DataColumn(label: Text('Purchase Date')),
        // DataColumn(label: Text('Total')),
      ], rows: rows),
    );
  }

  Future reject() async {
    try {
      final docuser = await FirebaseFirestore.instance
          .collection('Orders')
          .where('invoice', isEqualTo: widget.receivedMap['invoice'])
          .get();
      final docSnapshot = docuser.docs.first;
      final docid = docSnapshot.id;
      final docRef = FirebaseFirestore.instance.collection('Orders').doc(docid);

      await docRef.update({
        'status': 'Decline',
      });
      setState(() {
        status = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Succesfully Declined!')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future accept() async {
    try {
      final docuser = await FirebaseFirestore.instance
          .collection('Orders')
          .where('invoice', isEqualTo: widget.receivedMap['invoice'])
          .get();
      final docSnapshot = docuser.docs.first;
      final docid = docSnapshot.id;
      final docRef = FirebaseFirestore.instance.collection('Orders').doc(docid);

      await docRef.update({
        'status': 'Approved',
      });
      setState(() {
        status = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Succesfully Approved!')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
