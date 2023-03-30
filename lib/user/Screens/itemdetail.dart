// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, camel_case_types, unnecessary_null_comparison, use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:fyp/user/classes/global.dart';

class itemdetail extends StatefulWidget {
  Map<String, dynamic> receivedMap;

  itemdetail({required this.receivedMap});

  @override
  State<itemdetail> createState() => _itemdetailState();
}

class _itemdetailState extends State<itemdetail> {
  final user = FirebaseAuth.instance.currentUser!;
  bool invochecker = false;

  bool _visible = true;
  // bool isopen = false;
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
                color: Color.fromRGBO(247, 247, 247, 1),
              ),
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
                            flex: 5,
                            child: Text(
                              "${widget.receivedMap["Item Name"]}",
                              style: const TextStyle(
                                  fontSize: 17, color: Colors.black87),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Price: ${widget.receivedMap["Price"]}/- Rs",
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
                            Visibility(
                                visible: (widget.receivedMap['Inventory'] < 10)
                                    ? true
                                    : false,
                                child: Text(
                                  'Only ${widget.receivedMap["Inventory"]} Left in Stock, Hurry UP!',
                                  style: const TextStyle(color: Colors.red),
                                )),
                            Text(
                                //change with cpu description
                                "◉ ${widget.receivedMap["desc1"]}\n◉ ${widget.receivedMap["desc2"]}\n◉ ${widget.receivedMap["desc3"]}"),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    GestureDetector(
                      onTap: () => _togglereview(),
                      child: RichText(
                        text: const TextSpan(
                          // recognizer: TapGestureRecognizer()
                          //   ..onTap = _togglereview(),
                          text: 'Reviews: ',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.black87),
                        ),
                      ),
                    ),
                    Container(
                        child: _visible
                            ? Visibility(
                                visible: _visible,
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('Feedback')
                                        .where('Item Name',
                                            isEqualTo:
                                                "${widget.receivedMap["Item Name"]}")
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                      } else if (snapshot == null) {
                                        return const Text('No Reviews Yet');
                                      } else {
                                        return ListView.builder(
                                          itemCount: snapshot.data!.docs.length,
                                          itemBuilder: ((context, index) {
                                            var data2 = snapshot
                                                .data!.docs[index]
                                                .data() as Map<String, dynamic>;
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
                                                          FontWeight.bold),
                                                ),
                                                subtitle:
                                                    Text(data2['Message']),
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
                              )
                            : const SizedBox(
                                height: 164.5,
                              )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addtocart();
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }

  Future addtocart() async {
    final res = FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .collection('Cart')
        .doc();
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .collection('Cart')
        .where('Item Name', isEqualTo: widget.receivedMap['Item Name'])
        .get();
    try {
      if (querySnapshot.docs.isNotEmpty) {
        final userRef = querySnapshot.docs.first.reference;
        await userRef.update({'Count': FieldValue.increment(1)});
      } else {
        final doc = {
          'Item Name': widget.receivedMap['Item Name'],
          'price': widget.receivedMap['Price'],
          'Image': widget.receivedMap['url'],
          'Count': 1
        };
        await res.set(doc);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Succesfully Added to Cart'),
        ),
      );
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void _togglereview() {
    setState(() {
      _visible = !_visible;
    });
  }
}
