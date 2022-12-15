// ignore_for_file: unused_local_variable, avoid_print, prefer_const_constructors, camel_case_types, sized_box_for_whitespace, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class inventory extends StatefulWidget {
  const inventory({super.key});

  @override
  State<inventory> createState() => _inventoryState();
}

class _inventoryState extends State<inventory> {
  String dropdownvalue = 'Monitor';
  var items = ['Monitor', 'Pc'];
  List<List<dynamic>> data = [];
  String? FilePath;

  // Widget uploadcpubtn() {
  //   return Container(
  //     height: 40,
  //     width: double.infinity,
  //     child: ElevatedButton.icon(
  //       style: ButtonStyle(
  //           backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
  //           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
  //               RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(10.0),
  //           ))),
  //       label: const Text('upload'),
  //       onPressed: () {
  //         final docuser = FirebaseFirestore.instance
  //             .collection('Inventory')
  //             .doc('Hardware')
  //             .collection('CPU');
  //         int num = data.length;
  //         for (int index = 1; index < data.length; index++) {
  //           final dataa = {
  //             'Item Name': data[index][0],
  //             'Price': data[index][1],
  //             'Cores': data[index][2],
  //             'Base Clock': data[index][3],
  //             'Boost Clock': data[index][4],
  //             'Power Usage': data[index][5],
  //             'Graphics Card': data[index][6],
  //             'Quantity': data[index][7],
  //           };
  //           docuser.add(dataa);
  //         }
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text(num.toString()),
  //           ),
  //         );
  //       },
  //       icon: Icon(
  //         Icons.upload_file,
  //         size: 24,
  //       ),
  //     ),
  //   );
  // }

  // Widget uploadmobobtn() {
  //   return Container(
  //     height: 40,
  //     width: double.infinity,
  //     child: ElevatedButton.icon(
  //       style: ButtonStyle(
  //           backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
  //           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
  //               RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(10.0),
  //           ))),
  //       label: const Text('upload'),
  //       onPressed: () {
  //         final docuser = FirebaseFirestore.instance
  //             .collection('Inventory')
  //             .doc('Hardware')
  //             .collection('Motherboard');
  //         int num = data.length;
  //         for (int index = 1; index < data.length; index++) {
  //           final dataa = {
  //             'Item Name': data[index][0],
  //             'Price': data[index][1],
  //             'Socket Type': data[index][2],
  //             'Form Factor': data[index][3],
  //             'Max Memory': data[index][4],
  //             'Memory Slots': data[index][5],
  //             'Mobo_slot': data[index][6],
  //           };
  //           docuser.add(dataa);
  //         }
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text(num.toString()),
  //           ),
  //         );
  //       },
  //       icon: Icon(
  //         Icons.upload_file,
  //         size: 24,
  //       ),
  //     ),
  //   );
  // }

  // Widget uploadstoragebtn() {
  //   return Container(
  //     height: 40,
  //     width: double.infinity,
  //     child: ElevatedButton.icon(
  //       style: ButtonStyle(
  //           backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
  //           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
  //               RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(10.0),
  //           ))),
  //       label: const Text('upload'),
  //       onPressed: () {
  //         final docuser = FirebaseFirestore.instance
  //             .collection('Inventory')
  //             .doc('Hardware')
  //             .collection('Storage');
  //         int num = data.length;
  //         for (int index = 1; index < data.length; index++) {
  //           final dataa = {
  //             'Item Name': data[index][0],
  //             'Price': data[index][1],
  //             'Storage Capacity': data[index][2],
  //             'Storage Type': data[index][3],
  //             'Form Factor': data[index][4],
  //             'Inventory': data[index][5],
  //           };
  //           docuser.add(dataa);
  //         }
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text(num.toString()),
  //           ),
  //         );
  //       },
  //       icon: Icon(
  //         Icons.upload_file,
  //         size: 24,
  //       ),
  //     ),
  //   );
  // }

  // Widget uploadmobobtn() {
  //   return Container(
  //     height: 40,
  //     width: double.infinity,
  //     child: ElevatedButton.icon(
  //       style: ButtonStyle(
  //           backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
  //           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
  //               RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(10.0),
  //           ))),
  //       label: const Text('upload'),
  //       onPressed: () {
  //         final docuser = FirebaseFirestore.instance
  //             .collection('Inventory')
  //             .doc('Hardware')
  //             .collection('Ram');
  //         int num = data.length;
  //         for (int index = 1; index < data.length; index++) {
  //           final dataa = {
  //             'Item Name': data[index][0],
  //             'Price': data[index][1],
  //             'Ram Speed': data[index][2],
  //             'Ram Modules': data[index][3],
  //             'Ram Color': data[index][4],
  //             'Inventory': data[index][5],
  //           };
  //           docuser.add(dataa);
  //         }
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text(num.toString()),
  //           ),
  //         );
  //       },
  //       icon: Icon(
  //         Icons.upload_file,
  //         size: 24,
  //       ),
  //     ),
  //   );
  // }

  // Widget uploadgpubtn() {
  //   return Container(
  //     height: 40,
  //     width: double.infinity,
  //     child: ElevatedButton.icon(
  //       style: ButtonStyle(
  //           backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
  //           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
  //               RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(10.0),
  //           ))),
  //       label: const Text('upload'),
  //       onPressed: () {
  //         final docuser = FirebaseFirestore.instance
  //             .collection('Inventory')
  //             .doc('Hardware')
  //             .collection('psu');
  //         int num = data.length;
  //         for (int index = 1; index < data.length; index++) {
  //           final dataa = {
  //             'Item Name': data[index][0],
  //             'Price': data[index][1],
  //             'Gpu Chipset': data[index][2],
  //             'Gpu memory': data[index][3],
  //             'Gpu Core': data[index][4],
  //             'Gpu boost clock': data[index][5],
  //             'Gpu color': data[index][6],
  //           };
  //           docuser.add(dataa);
  //         }
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text(num.toString()),
  //           ),
  //         );
  //       },
  //       icon: Icon(
  //         Icons.upload_file,
  //         size: 24,
  //       ),
  //     ),
  //   );
  // }

//  Widget uploadpsubtn() {
//     return Container(
//       height: 40,
//       width: double.infinity,
//       child: ElevatedButton.icon(
//         style: ButtonStyle(
//             backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
//             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                 RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10.0),
//             ))),
//         label: const Text('upload'),
//         onPressed: () {
//           final docuser = FirebaseFirestore.instance
//               .collection('Inventory')
//               .doc('Hardware')
//               .collection('psu');
//           int num = data.length;
//           for (int index = 1; index < data.length; index++) {
//             final dataa = {
//               'Item Name': data[index][0],
//               'Price': data[index][1],
//               'Efficiency Rating': data[index][2],
//               'Wattage': data[index][3],
//               'Inventory': data[index][4],
//             };
//             docuser.add(dataa);
//           }
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(num.toString()),
//             ),
//           );
//         },
//         icon: Icon(
//           Icons.upload_file,
//           size: 24,
//         ),
//       ),
//     );
//   }

  Widget uploadmonitorbtn() {
    return Container(
      height: 40,
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ))),
        label: const Text('upload'),
        onPressed: () {
          final docuser = FirebaseFirestore.instance.collection('Inventory');
          // .doc('Hardware')
          // .collection('CPU Cooler');
          int num = data.length;
          for (int index = 1; index < data.length; index++) {
            final dataa = {
              'Item Name': data[index][0],
              'Price': data[index][1],
              'socket type': data[index][2],
              'formfactor': data[index][3],
              'memorymax': data[index][4],
              'memory slots': data[index][5],
              'color': data[index][6],
              'aspect ratio': data[index][7],
              'Inventory': '1',
              // 'Inventory': data[index][8],
              'Category': 'mobo'
            };
            docuser.add(dataa);
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(num.toString()),
            ),
          );
        },
        icon: Icon(
          Icons.upload_file,
          size: 24,
        ),
      ),
    );
  }

  void _PickFile() async {
    // final dataset = await FilePicker.platform.pickFiles(allowMultiple: false);

    // if (dataset == null) return;

    // print(dataset.files.first.name);
    // FilePath = dataset.files.first.path;

    // final input = File(FilePath!).openRead();
    final myData = await rootBundle.loadString("assets/mobo.csv");
    List<List<dynamic>> csvtable = CsvToListConverter().convert(myData);

    print(csvtable);
    data = csvtable;
    setState(() {});
    // final fields = await input
    //     .transform(utf8.decoder)
    //     .transform(const CsvToListConverter())
    //     .toList();

    // print(fields);

    // setState(() {
    //   data = fields;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UPDATE INVENTORY'),
        backgroundColor: Color.fromARGB(255, 48, 10, 55),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context, false),
        ),
        actions: [
          IconButton(
              onPressed: () {
                _PickFile();
              },
              icon: Icon(Icons.add_outlined))
        ],
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Stack(
          children: <Widget>[
            // StreamBuilder<QuerySnapshot>(
            //   stream: FirebaseFirestore.instance
            //       .collection('Inventory')
            //       .doc('Hardware')
            //       .snapshots(),
            //   builder: ((context, snapshot) {
            //     if (!snapshot.hasData)
            //       return const Center(
            //         child: const CupertinoActivityIndicator(),
            //       );
            //   }),
            // ),
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xff588F8F), Color(0x00000000)])),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Category',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    DropdownButton(
                      value: dropdownvalue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(
                            items,
                            style: TextStyle(fontSize: 20),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                    uploadmonitorbtn(),
                    SizedBox(
                      height: 15,
                    ),
                    // ListView.builder(
                    //     itemCount: data.length,
                    //     scrollDirection: Axis.vertical,
                    //     shrinkWrap: true,
                    //     itemBuilder: (_, index) {
                    //       return Card(
                    //         margin: const EdgeInsets.all(3),
                    //         color: index == 0 ? Colors.amber : Colors.white,
                    //         child: ListTile(
                    //           leading: Text(
                    //             data[index][0].toString(),
                    //             textAlign: TextAlign.center,
                    //             style: TextStyle(
                    //                 fontSize: index == 0 ? 18 : 15,
                    //                 fontWeight: index == 0
                    //                     ? FontWeight.bold
                    //                     : FontWeight.normal,
                    //                 color:
                    //                     index == 0 ? Colors.red : Colors.black),
                    //           ),
                    //           title: Text(
                    //             data[index][1].toString(),
                    //             textAlign: TextAlign.center,
                    //             style: TextStyle(
                    //                 fontSize: index == 0 ? 18 : 15,
                    //                 fontWeight: index == 0
                    //                     ? FontWeight.bold
                    //                     : FontWeight.normal,
                    //                 color:
                    //                     index == 0 ? Colors.red : Colors.black),
                    //           ),
                    //           trailing: Text(
                    //             data[index][2].toString(),
                    //             textAlign: TextAlign.center,
                    //             style: TextStyle(
                    //                 fontSize: index == 0 ? 18 : 15,
                    //                 fontWeight: index == 0
                    //                     ? FontWeight.bold
                    //                     : FontWeight.normal,
                    //                 color:
                    //                     index == 0 ? Colors.red : Colors.black),
                    //           ),
                    //         ),
                    //       );
                    //     }),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
