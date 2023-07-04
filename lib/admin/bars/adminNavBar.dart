// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names, prefer_final_fields, unnecessary_new, use_key_in_widget_constructors, avoid_print, non_constant_identifier_names, sized_box_for_whitespace, must_call_super, unnecessary_import, depend_on_referenced_packages, dead_code

// import 'package:fyp/LoginScreen.dart';
// import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp/admin/screens/AdminHomeScreen.dart';
import 'package:fyp/user/Screens/Categories.dart';
import '../../user/Controllers/bottomNavController.dart';
import 'package:get/get.dart';

import '../../user/Screens/ManageProfile.dart';

class AdminMenu extends StatefulWidget {
  const AdminMenu({super.key});

  @override
  State<AdminMenu> createState() => _AdminMenuState();
}

class _AdminMenuState extends State<AdminMenu> {
  var controller = Get.put(HomeController());

  var navbody = [
    AdminHomeScreen(),
    categories(),
    Manageprofile(),
  ];
  var navbaritem = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.category_rounded), label: 'Categories'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Obx(() => Expanded(
                child: navbody.elementAt(controller.admincurrentIndex.value)))
          ],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            unselectedItemColor: Colors.white,
            currentIndex: controller.admincurrentIndex.value,
            selectedItemColor: Color.fromARGB(255, 151, 33, 171),
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
            type: BottomNavigationBarType.fixed,
            items: navbaritem,
            backgroundColor: Color.fromARGB(35, 60, 13, 68),
            onTap: ((value) {
              controller.admincurrentIndex.value = value;
            }),
          ),
        ),
      ),
    );
  }
}
