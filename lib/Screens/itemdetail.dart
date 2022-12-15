// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, camel_case_types
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
                        color: Colors.grey,
                        child: Text(
                          "${widget.receivedMap["Item Name"]}",
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white),
                        ),
                      ),
                      Text(
                        "${widget.receivedMap["Price"]}/- Rs",
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          if ('CPU' == "${widget.receivedMap["Category"]}") {
                            return Text(
                                "◉ CPU Base Clock: ${widget.receivedMap["Fan RPM"]}\n◉ CPU Boost Clock: ${widget.receivedMap["Color"]}\n◉ Inventory: ${widget.receivedMap["Inventory"]}");
                          } else {
                            return const Text("Y is less than 10");
                          }
                        },
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(
                            fontSize: 20,
                          )),
                          onPressed: () {},
                          child: const Text("Add To Cart"),
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
