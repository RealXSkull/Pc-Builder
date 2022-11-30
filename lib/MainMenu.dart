// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names, prefer_final_fields, unnecessary_new, use_key_in_widget_constructors, avoid_print, non_constant_identifier_names, sized_box_for_whitespace, must_call_super, unnecessary_import, depend_on_referenced_packages

// import 'package:fyp/LoginScreen.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp/NavBar.dart';

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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
