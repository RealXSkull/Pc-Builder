// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names, prefer_final_fields, unnecessary_new, use_key_in_widget_constructors, avoid_print, non_constant_identifier_names, sized_box_for_whitespace, must_call_super, unnecessary_import, depend_on_referenced_packages, dead_code

// import 'package:fyp/LoginScreen.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp/NavBar.dart';
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
  List<int> data = [10, 9, 8, 7, 6, 5, 4, 3, 2, 1];
  Widget builditemlist(BuildContext context, int index) {
    return SizedBox(
      width: 300,
      height: 250,
      child: Card(
        margin: EdgeInsets.all(12),
        elevation: 12,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Column(
            children: [
              Text('All'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('\$cos'),
                ],
              )
              // Image.asset(categories[iconpath])
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
  // @override
  // Widget _appBarTitle;
  // Color _appBarBackgroundColor;
  // MenuItem _selectedMenuItem;
  // List<MenuItem> _menuItems;
  // List<Widget> _menuOptionWidgets = [];

  // @override
  // initState() {
  //   super.initState();

  //   _menuItems = createMenuItems();
  //   _selectedMenuItem = _menuItems.first;
  //   _appBarTitle = new Text(_menuItems.first.title);
  //   _appBarBackgroundColor = _menuItems.first.color;
  // }
  int maxLength = 11;
  String contactno = "";
  bool obscureTextt = true;
  // Widget _categoryCards(BuildContext context, int index) {
  //   if (index == categories.length)
  //     return Center(
  //       child: CircularProgressIndicator(),
  //     );
  //   return Container(
  //     width: 150,
  //     child: Column(
  //       children: [
  //         Container(
  //           color: Colors.deepOrangeAccent,
  //           width: 150,
  //           child: Center(
  //             child: Text(
  //               '${categories[index]}',
  //               style: TextStyle(fontSize: 30.0),
  //             ),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Colors.blueGrey,
        // leading: IconButton(
        //   icon: Icon(Icons.more_horiz_outlined),
        //   alignment: Alignment.centerLeft,
        //   onPressed: () => Navigator.pop(context, false),
        // )
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
                      colors: [Color(0xff588F8F), Color(0x00000000)])),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
