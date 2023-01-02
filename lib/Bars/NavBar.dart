// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, file_names, unused_import

import '../classes/global.dart' as globals;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fyp/Screens/LoginScreen.dart';
import 'package:fyp/Bars/bottomNavBar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fyp/Screens/ManageProfile.dart';
import 'package:fyp/Screens/Review.dart';
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
              color: Colors.blue,
              image:
                  DecorationImage(image: NetworkImage(''), fit: BoxFit.cover),
            ),
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Update Profile'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Manageprofile()));
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favorites'),
            onTap: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.support_agent_outlined),
            title: Text('Warranty Claim'),
            onTap: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => LoginScreen()));
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
            leading: Icon(Icons.contact_support),
            title: Text('About Us'),
            onTap: () {
              // Navigator.push(context,
              // MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              FirebaseAuth.instance.signOut();
              globals.url = "";
            },
          ),
        ],
      ),
    );
  }
}
