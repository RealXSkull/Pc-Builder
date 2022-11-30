// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, file_names, unused_import

import 'package:flutter/material.dart';
import 'package:fyp/LoginScreen.dart';
import 'package:fyp/MainMenu.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Danish'),
            accountEmail: Text('Danish.shk09@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'assets/man.jpg',

                  //   Image.asset(
                  // 'C:\Users\HP\Documents\GitHub\fyp\asset\man.jpg',
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image:
                  DecorationImage(image: NetworkImage(''), fit: BoxFit.cover),
            ),
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
              //   Navigator.push(context,
              //       MaterialPageRoute(builder: (context) => LoginScreen()));
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
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (ctx) => LoginScreen()),
                  (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
