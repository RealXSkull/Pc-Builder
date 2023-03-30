// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, use_build_context_synchronously, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Complaintdetail extends StatefulWidget {
  Map<String, dynamic> receivedMap;
  String date;

  Complaintdetail({required this.receivedMap, required this.date});

  @override
  State<Complaintdetail> createState() => _ComplaintdetailState();
}

class _ComplaintdetailState extends State<Complaintdetail> {
  bool status = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Warranty Claims'),
        backgroundColor: const Color.fromARGB(255, 48, 10, 55),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context, false),
        ),
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
                                image: NetworkImage(widget.receivedMap['url']),
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      // color: Colors.grey,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              "${widget.receivedMap["Item Name"]}",
                              style: const TextStyle(
                                  fontSize: 17, color: Colors.black87),
                            ),
                          ),
                          const Spacer(),
                          Expanded(
                            flex: 4,
                            child: Text(
                              "Purchased Date: ${widget.date}",
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
                          children: [
                            Text(
                                //change with cpu description
                                "◉ Invoice: ${widget.receivedMap["invoice"]}\n◉ Complaint: ${widget.receivedMap["Message"]}\n◉ User: ${widget.receivedMap["Username"]}\n◉ Contact: ${widget.receivedMap["Contact"]}"),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: (widget.receivedMap['Status'] == 'Requested')
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
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () {
                        reject();
                      },
                      child: const Text('Reject'),
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
                      child: const Text('Claim'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future reject() async {
    try {
      final docuser = await FirebaseFirestore.instance
          .collection('Warranty')
          .where('Item Name', isEqualTo: widget.receivedMap['Item Name'])
          .get();
      final docSnapshot = docuser.docs.first;
      final docid = docSnapshot.id;
      final docRef =
          FirebaseFirestore.instance.collection('Warranty').doc(docid);

      await docRef.update({
        'Status': 'Decline',
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
          .collection('Warranty')
          .where('Item Name', isEqualTo: widget.receivedMap['Item Name'])
          .get();
      final docSnapshot = docuser.docs.first;
      final docid = docSnapshot.id;
      final docRef =
          FirebaseFirestore.instance.collection('Warranty').doc(docid);

      await docRef.update({
        'Status': 'Approved',
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
