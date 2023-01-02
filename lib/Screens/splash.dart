import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/classes/global.dart' as globals;
import 'package:fyp/Bars/NavBar.dart';
import 'package:fyp/Screens/Homescreen.dart';

import '../Bars/bottomNavBar.dart';
import '../Controllers/Authpage.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  // Fetchinvo() {
  //   // globals.Invo = 'Masta' as Map;
  //   globals.Invo =
  //       FirebaseFirestore.instance.collection("Inventory").snapshots() as Map;
  //   print('${globals.Invo} ansdj');
  // }

  @override
  void initState() {
    super.initState();
    navigatetohome();
    // Fetchinvo();
  }

  navigatetohome() async {
    await Future.delayed(const Duration(milliseconds: 2000), (() {}));
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Something Went Wrong'),
                );
              } else if (snapshot.hasData) {
                return const MainMenu();
              } else {
                return const Authpage();
              }
            },
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: const Color(0xff202c3c),
          child: const Image(
            image: AssetImage('assets/Pc_builder.jpg'),
          ),
        ),
      ),
    );
  }
}
