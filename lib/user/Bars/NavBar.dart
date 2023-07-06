// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, file_names, unused_import, use_build_context_synchronously

import 'package:fyp/user/Screens/AboutUs.dart';
import 'package:fyp/user/Screens/Changepassword.dart';
import 'package:fyp/user/Screens/WarrentyClaim.dart';
import 'package:fyp/user/Screens/orderhistory.dart';
import 'package:fyp/user/Screens/warranty.dart';
import '../Controllers/Authpage.dart';
import '../classes/global.dart' as globals;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fyp/user/Screens/LoginScreen.dart';
import 'package:fyp/user/Bars/bottomNavBar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fyp/user/Screens/ManageProfile.dart';
import 'package:fyp/user/Screens/Review.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    globals.name = user.displayName!;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user.displayName!),
            accountEmail: Text(user.email!),
            currentAccountPicture: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    //  Image.asset('assets/man.jpg')
                    image: NetworkImage(globals.url),
                  )),

              // child: Image.asset(
              //   'assets/man.jpg',
              //   width: 90,
              //   height: 90,
              //   fit: BoxFit.cover,
              // ),
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 151, 33, 171),
              image:
                  DecorationImage(image: NetworkImage(''), fit: BoxFit.cover),
            ),
          ),
          ListTile(
            leading: Icon(Icons.password),
            title: Text('Change Password'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => changepassword()));
            },
          ),
          ListTile(
            leading: Icon(Icons.support_agent_outlined),
            title: Text('Warranty Claim'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Warranty(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.feedback),
            title: Text('Feedback'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Review()));
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_bag_sharp),
            title: Text('Order History'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Orderhistory()));
            },
          ),
          ListTile(
            leading: Icon(Icons.contact_support),
            title: Text('About Us'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => aboutUs()));
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              logout(context);
              globals.url = "";
            },
          ),
        ],
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const Authpage(),
      ),
    );
  }
}
