// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, camel_case_types
import 'package:cloud_firestore/cloud_firestore.dart';

import '../classes/global.dart' as globals;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class itemdetail extends StatefulWidget {
  Map<String, dynamic> receivedMap;
  String url;
  itemdetail({required this.receivedMap, required this.url});

  @override
  State<itemdetail> createState() => _itemdetailState();
}

class _itemdetailState extends State<itemdetail> {
  bool isopen = false;
  // var zawat = FirebaseFirestore.instance.collection('Feedback').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Text(
        //     "Screen one sent me this : ${widget.receivedMap["Item Name"]} and ${widget.receivedMap["Price"]} and ${widget.receivedMap["Category"]}"),
        appBar: AppBar(
          title: const Text('Item Detail'),
          backgroundColor: const Color.fromARGB(255, 48, 10, 55),
        ),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomCenter,
                        colors: [
                      Color.fromARGB(255, 11, 4, 109),
                      Color.fromARGB(255, 109, 18, 18)
                    ])),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/all_icon.jpg'),
                            fit: BoxFit.fill,
                          ),
                          // shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        // color: Colors.grey,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Text(
                                "${widget.receivedMap["Item Name"]}",
                                style: const TextStyle(
                                    fontSize: 17, color: Colors.white),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Price: ${widget.receivedMap["Price"]}/- Rs",
                                style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          if ('CPU' == "${widget.receivedMap["Category"]}") {
                            return Text(
                                //change with cpu description
                                "◉ CPU Base Clock: ${widget.receivedMap["Fan RPM"]}\n◉ CPU Boost Clock: ${widget.receivedMap["Color"]}\n◉ Inventory: ${widget.receivedMap["Inventory"]}");
                          } else if ('Ram' ==
                              "${widget.receivedMap["Category"]}") {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  //change with cpu description
                                  "◉ Capacity: ${widget.receivedMap["Module"]}\n◉ Ram Speed: ${widget.receivedMap["Speed"]}\n◉ Ram Color: ${widget.receivedMap["Color"]}\n◉ Inventory: ${widget.receivedMap["Inventory"]}",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ExpansionPanelList(
                                  children: [
                                    ExpansionPanel(
                                        backgroundColor: Colors.grey,
                                        isExpanded: isopen,
                                        body:
                                            // Text('Open101'),
                                            SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.3,
                                          child: StreamBuilder(
                                            stream: FirebaseFirestore.instance
                                                .collection("Feedback")
                                                // .collection("Users")
                                                // .doc('Hardware')
                                                // .collection('Gpu')
                                                .where("Item Name",
                                                    isEqualTo:
                                                        "${widget.receivedMap["Item Name"]}")
                                                .snapshots(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<QuerySnapshot>
                                                    snapshot) {
                                              if (snapshot.hasError) {
                                                return const Center(
                                                  child: Text(
                                                      "Something Went Wrong"),
                                                );
                                              } else if (snapshot
                                                      .connectionState ==
                                                  ConnectionState.waiting) {
                                                return const Center(
                                                  heightFactor: 3,
                                                  widthFactor: 3,
                                                  child: SizedBox(
                                                    height: 100,
                                                    width: 100,
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                );
                                              } else {
                                                return ListView.builder(
                                                  itemCount: snapshot
                                                      .data!.docs.length,
                                                  itemBuilder:
                                                      ((context, index) {
                                                    var data2 = snapshot
                                                            .data!.docs[index]
                                                            .data()
                                                        as Map<String, dynamic>;
                                                    // return const Text('data');
                                                    return Card(
                                                      color: Colors.white,
                                                      child: ListTile(
                                                        // leading: SizedBox(
                                                        //     height: 60,
                                                        //     width: 60,
                                                        //     child: Image.asset(
                                                        //       'assets/all_icon.jpg',
                                                        //       fit: BoxFit.fill,
                                                        //     )),
                                                        title: Text(
                                                          data2['Username'],
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        subtitle: Text(
                                                            data2['Message']),
                                                        trailing: Text(
                                                            '${data2['Rating'].toString()} Stars'),
                                                      ),
                                                    );
                                                  }),
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                        headerBuilder: (BuildContext context,
                                            bool isExpanded) {
                                          return Container(
                                            alignment: Alignment.center,
                                            height: 0,
                                            child: const Text(
                                              'Reviews',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          );
                                        }),
                                  ],
                                  expansionCallback: (panelIndex, isExpanded) =>
                                      setState(() {
                                    isopen = !isopen;
                                  }),
                                ),
                              ],
                            );
                          } else {
                            return const Text("Default Page");
                          }
                        },
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: FloatingActionButton(
                          // style: ElevatedButton.styleFrom(
                          //     textStyle: const TextStyle(
                          //   fontSize: 20,
                          // )),
                          onPressed: () {},
                          child: const Icon(Icons.shopping_cart),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
