import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp/admin/screens/complaintDetails.dart';
import 'package:intl/intl.dart';

class Complaints extends StatefulWidget {
  const Complaints({super.key});

  @override
  State<Complaints> createState() => ComplaintsState();
}

class ComplaintsState extends State<Complaints> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Warranty Claims'),
          backgroundColor: const Color.fromARGB(255, 48, 10, 55),
        ),
        body: Stack(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(10),
                // const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('Warranty')
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
                          } else if (snapshot.data!.docs.isEmpty) {
                            return const Center(
                              child: Text("No Complaints Found"),
                            );
                          } else {
                            return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                var data = snapshot.data!.docs[index].data()
                                    as Map<String, dynamic>;
                                Timestamp timestamp = data['Purchased Date'];
                                DateTime dateTime = timestamp.toDate();
                                String formattedDate =
                                    DateFormat.yMMMMEEEEd().format(dateTime);
                                return Card(
                                  child: InkWell(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Complaintdetail(
                                            data: data, date: formattedDate),
                                      ),
                                    ),
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
