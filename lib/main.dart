// ignore_for_file: use_key_in_widget_constructors, depend_on_referenced_packages

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp/MainMenu.dart';

import 'Authpage.dart';
import 'LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PC Builder',
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Something Went Wrong'),
            );
          } else if (snapshot.hasData) {
            return MainMenu();
          } else {
            return Authpage();
          }
        },
      ),
    );
  }
}
