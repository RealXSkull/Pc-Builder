// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names, prefer_final_fields, unnecessary_new, use_key_in_widget_constructors, avoid_print, non_constant_identifier_names, sized_box_for_whitespace, must_call_super, unnecessary_import, depend_on_referenced_packages, dead_code

// import 'package:fyp/LoginScreen.dart';
// import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp/user/Screens/Homescreen.dart';
import 'package:fyp/user/Screens/ManageProfile.dart';
import '../Controllers/bottomNavController.dart';
import 'package:get/get.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  var controller = Get.put(HomeController());

  var navbody = [
    HomeScreen(),
    Container(
      color: Colors.amber,
    ),
    Container(
      color: Colors.purple,
    ),
    Manageprofile()
  ];
  var navbaritem = [
    BottomNavigationBarItem(
        icon: Image.asset(
          'assets/home.png',
          width: 26,
        ),
        label: 'Home'),
    BottomNavigationBarItem(
        icon: Image.asset(
          'assets/menu.png',
          width: 26,
        ),
        label: 'Categories'),
    BottomNavigationBarItem(
        icon: Image.asset(
          'assets/shopping-cart.png',
          width: 26,
        ),
        label: 'Cart'),
    BottomNavigationBarItem(
        icon: Image.asset(
          'assets/user.png',
          width: 26,
        ),
        label: 'Account'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Obx(() => Expanded(
              child: navbody.elementAt(controller.currentNavIndex.value)))
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentNavIndex.value,
          selectedItemColor: Colors.red,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
          type: BottomNavigationBarType.fixed,
          items: navbaritem,
          backgroundColor: Color.fromARGB(35, 0, 0, 0),
          onTap: ((value) {
            controller.currentNavIndex.value = value;
          }),
        ),
      ),
    );
  }
}