// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names, prefer_final_fields, unnecessary_new, use_key_in_widget_constructors, avoid_print, non_constant_identifier_names, sized_box_for_whitespace, must_call_super, unnecessary_import, depend_on_referenced_packages, dead_code

// import 'package:fyp/LoginScreen.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp/NavBar.dart';
import 'CardItem.dart';
import 'dart:math';

import 'package:scroll_snap_list/scroll_snap_list.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class MenuItem {
  String title;
  String icon;
  Color color;
  Function func;
  MenuItem(this.title, this.icon, this.color, this.func);
}

class _MainMenuState extends State<MainMenu> {
  List<CardItem> item = [
    CardItem(
        image: 'assets/icons/all_icon.jpg', Title: 'ALL', Subtitle: '\$100'),
    CardItem(
        image: 'assets/icons/all_icon.jpg', Title: 'ALL', Subtitle: '\$100'),
    CardItem(
        image: 'assets/icons/all_icon.jpg', Title: 'ALL', Subtitle: '\$100'),
    CardItem(
        image: 'assets/icons/all_icon.jpg', Title: 'ALL', Subtitle: '\$100'),
    CardItem(
        image: 'assets/icons/all_icon.jpg', Title: 'ALL', Subtitle: '\$100'),
    CardItem(
        image: 'assets/icons/all_icon.jpg', Title: 'ALL', Subtitle: '\$100'),
  ];
  List<int> data = [10, 9, 8, 7, 6, 5, 4, 3, 2, 1];
  Widget Buildcards(CardItem item) => Container(
        width: 200,
        child: Column(
          children: [
            Expanded(
                child: AspectRatio(
              aspectRatio: 4 / 3,
              child: Image.asset(
                item.image,
                fit: BoxFit.cover,
              ),
            )),
            Text(
              item.Title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              item.Subtitle,
              style: TextStyle(
                fontSize: 12,
              ),
            )
          ],
        ),
      );

  List<Map> data1 = [
    {'name': 'All', 'iconpath': 'assets/icons/all_icons.jpg'},
    {'name': 'All', 'iconpath': 'assets/icons/all_icons.jpg'},
    {'name': 'All', 'iconpath': 'assets/icons/all_icons.jpg'},
    {'name': 'All', 'iconpath': 'assets/icons/all_icons.jpg'},
  ];

  Widget builditemlist(BuildContext context, int index) {
    return SizedBox(
      width: 300,
      height: 250,
      child: Card(
        margin: EdgeInsets.all(12),
        elevation: 8,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Column(
            children: [
              Text('All'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text('\$cos'),
                  Expanded(
                    child: Image.asset(
                      'assets/icons/all_icon.jpg',
                      width: 150,
                      height: 210,
                      fit: BoxFit.fill,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Map> categories = [
    {'Name': 'All', 'iconpath': 'assets/icons/all_icon.jpg'},
    {'Name': 'Ram', 'iconpath': 'assets/icons/all_icon.png'},
    // {'Name': 'PSU', 'iconpath': 'assets/icons/all_icon.png'},
    // {'Name': 'GPU', 'iconpath': 'assets/icons/all_icon.png'},
    // {'Name': 'Processor', 'iconpath': 'assets/icons/all_icon.png'},
    // {'Name': 'Storage', 'iconpath': 'assets/icons/all_icon.png'},
  ];

  int maxLength = 11;
  String contactno = "";
  bool obscureTextt = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Color.fromARGB(255, 48, 10, 55),
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
                    Color.fromARGB(255, 77, 14, 14)
                  ])),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Container(
                  // height: 140,
                  // child: ListView.separated(
                  //   scrollDirection: Axis.horizontal,
                  //   separatorBuilder: (context, _) => SizedBox(
                  //     width: 12,
                  //   ),
                  //   itemBuilder: (context, index) {
                  //     return Buildcards(index);
                  //   },

                  //   itemCount: 6,
                  // SizedBox(
                  //   height: 250,
                  //   child: ScrollSnapList(
                  //     itemBuilder: builditemlist,
                  //     itemSize: 300,
                  //     dynamicItemSize: true,
                  //     onReachEnd: () {
                  //       print('1st');
                  //     },
                  //     itemCount: data1.length,
                  //     onItemFocus: (index) {},
                  //     // reverse: true,
                  //   ),
                  // ),
                  child: SizedBox(
                    height: 250,
                    child: ScrollSnapList(
                      itemBuilder: builditemlist,
                      itemSize: 300,
                      dynamicItemSize: true,
                      onReachEnd: () {
                        print('Done');
                      },
                      itemCount: data.length,
                      onItemFocus: (index) {},
                    ),
                  ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // Buildcards(),
                  // SizedBox(
                  //   width: 20,
                  //   height: 20,
                  // ),
                  // Buildcards(),
                  // SizedBox(
                  //   width: 20,
                  //   height: 20,
                  // ),
                  // Buildcards(),
                  // SizedBox(
                  //   height: 250,
                  //   // child: Scrollable(

                  //   //   itemBuilder: builditemlist,
                  //   //   itemSize: 300,
                  //   //   dynamicItemSize: true,
                  //   //   onReachEnd: () {
                  //   //     print('index');
                  //   //   },
                  //   //   itemCount: data.length,
                  //   //   onItemFocus: (index) {},
                  //   // ),
                  // ),
                  // SizedBox(
                  //   height: 250,
                  //   child: ScrollSnapList(
                  //     itemBuilder: builditemlist,
                  //     itemSize: 300,
                  //     dynamicItemSize: true,
                  //     onReachEnd: () {
                  //       print('Done');
                  //     },
                  //     itemCount: data.length,
                  //     onItemFocus: (index) {},
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 250,
                  //   child: ScrollSnapList(
                  //     itemBuilder: builditemlist,
                  //     itemSize: 300,
                  //     dynamicItemSize: true,
                  //     onReachEnd: () {
                  //       // print('Done');
                  //     },
                  //     reverse: true,
                  //     itemCount: data.length,
                  //     onItemFocus: (index) {},
                  //   ),
                  // ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
