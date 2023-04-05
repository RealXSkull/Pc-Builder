// ignore_for_file: must_be_immutable, camel_case_types, use_key_in_widget_constructors, use_build_context_synchronously, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp/user/Bars/cart.dart';
import 'package:fyp/user/Screens/Homescreen.dart';
// import 'package:fyp/user/classes/cartcalc.dart';
import '../classes/global.dart' as global;
import 'dart:math';
import 'dart:core';
import '../classes/global.dart';

int invoicenumber = 0;

class checkoutscreen extends StatefulWidget {
  Map<String, dynamic> receivedMap;
  double total;
  List items;
  checkoutscreen(
      {required this.receivedMap, required this.total, required this.items});

  @override
  State<checkoutscreen> createState() => _checkoutscreenState();
}

class _checkoutscreenState extends State<checkoutscreen> {
  final formkey = GlobalKey<FormState>();
  final _namecontroller = TextEditingController(text: global.name);
  final _phonecontroller = TextEditingController(text: '0${global.phone}');
  final _addcontroller = TextEditingController(text: global.address);
  final itemdesccontroller = TextEditingController();
  int maxLength = 11;
  var contactno = "";
  @override
  void dispose() {
    _phonecontroller.dispose();
    _namecontroller.dispose();
    _addcontroller.dispose();
    itemdesccontroller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    invoicenumber = generateRandomNumber();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Check-Out : invoice: $invoicenumber'),
            backgroundColor: const Color.fromARGB(255, 48, 10, 55),
          ),
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.dark,
            child: Form(
              key: formkey,
              child: Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Color(0xfff7f7f7),
                    ),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            buildname(),
                            const SizedBox(
                              height: 15,
                            ),
                            buildAddress(),
                            const SizedBox(
                              height: 20,
                            ),
                            buildphone(),
                            const SizedBox(
                              height: 20,
                            ),
                            builditemdesc(),
                            const SizedBox(
                              height: 15,
                            ),

                            datatable(),

                            // for (int i = 0; i < 3; i++)
                            const SizedBox(
                              height: 15,
                            ),
                            checkoutbtn(),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Widget checkoutbtn() {
    return SizedBox(
      height: 40,
      child: ElevatedButton.icon(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ))),
        label: const Text('Checkout'),
        onPressed: () {
          checkout2();
          checkout();
        },
        icon: const Icon(
          Icons.shopping_cart_checkout,
          size: 24,
        ),
      ),
    );
  }

  Future checkout2() async {
    items.forEach((element) async {
      final QuerySnapshot qs = await FirebaseFirestore.instance
          .collection('Inventory')
          .where('Item Name', isEqualTo: element['Item Name'])
          .get();

      final docRef = qs.docs.first.reference;
      await docRef
          .update({'Inventory': FieldValue.increment(-element['Count'])});
    });
  }

  Widget buildname() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Enter Your Full Name: ',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(),
          ),
          height: 40,
          child: TextField(
            controller: _namecontroller,
            keyboardType: TextInputType.text,
            style: const TextStyle(color: Colors.black87),
            decoration: const InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.person,
                  color: Color(0xff5ac18e),
                ),
                hintText: 'Full Name',
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        )
      ],
    );
  }

  Widget builditemdesc() {
    const maxLines = 3;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Any Special Instruction? ',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Stack(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                  child: Material(
                child: TextField(
                  controller: itemdesccontroller,
                  maxLines: maxLines,
                  decoration: const InputDecoration(
                    hintText: "Enter message",
                    hintStyle: TextStyle(color: Colors.black38),
                    filled: true,
                  ),
                ),
              )),
            )
          ],
        )
      ],
    );
  }

  Widget datatable() {
    return StreamBuilder<Object>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .collection('Cart')
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
                    DataColumn(
                      label: Text('Price/Item'),
                    ),
                    DataColumn(
                      label: Text('Quantity'),
                    ),
                    DataColumn(
                      label: Text('Total Price'),
                    ),
                  ],
                  rows: global.items
                      .map<DataRow>((element) => DataRow(cells: [
                            DataCell(SizedBox(
                                width: 150, child: Text(element['Item Name']))),
                            DataCell(Center(
                                child: Text(element['price'].toString()))),
                            DataCell(Center(
                                child: Text(element['Count'].toString()))),
                            DataCell(Center(
                                child: Text(
                                    (element['price'] * element['Count'])
                                        .toString())))
                          ]))
                      .toList()),
            ),
          );
        });
  }

  Widget buildphone() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Contact No.',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(),
          ),
          height: 40,
          child: TextField(
            controller: _phonecontroller,
            onChanged: (String newVal) {
              if (newVal.length <= maxLength) {
                contactno = newVal;
              } else {
                _phonecontroller.text = contactno;
              }
            },
            // maxLength: 11,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.black87),
            decoration: const InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.phone,
                  color: Color(0xff5ac18e),
                ),
                hintText: '03xx-xxxxxxx',
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        )
      ],
    );
  }

  Widget buildAddress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Enter Your Address',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all()),
          height: 40,
          child: TextField(
            controller: _addcontroller,
            keyboardType: TextInputType.text,
            style: const TextStyle(color: Colors.black87),
            decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
                  color: Color(0xff5ac18e),
                ),
                hintText: 'Address',
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        )
      ],
    );
  }

  Future checkout() async {
    Timestamp timestamp = Timestamp.fromDate(DateTime.now());

    var ref = FirebaseFirestore.instance
        .collection('Orders')
        .doc(invoicenumber.toString());

    int count = 1;
    // var dataa = {};
    try {
      items.forEach((element) async {
        var dataa = {
          'Item $count': element['Item Name'],
          'Quantity $count': element['Count'],
          'Price $count': element['price'],
          'invoice': invoicenumber.toString(),
          'Username': user.displayName,
          'message': itemdesccontroller.text,
          'contact': _phonecontroller.text,
          'Address': _addcontroller.text,
          'status': 'Requested'
        };
        count++;
        if (count == 2) {
          await ref.set(dataa);
        } else {
          await ref.update(dataa);
        }
      });

      var finalize = {'Total': total, 'Purchase Date': timestamp};
      await ref.update(finalize);
      items.clear();
      final docref = await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .collection('Cart')
          .get();
      for (var doc in docref.docs) {
        doc.reference.delete();
      }
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Order Placed Successfully'),
        duration: Duration(seconds: 2),
      ));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  int generateRandomNumber() {
    var random = Random();
    return random.nextInt(9000) + 1000;
  }
}
