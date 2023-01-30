// import 'dart:html';

// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/Bars/adminNavBar.dart';
import 'package:fyp/Screens/Signup.dart';
import 'package:fyp/classes/global.dart' as globals;
import 'package:fyp/Bars/NavBar.dart';
import 'package:fyp/Screens/Homescreen.dart';
import 'package:video_player/video_player.dart';

import '../Bars/bottomNavBar.dart';
import '../Controllers/Authpage.dart';

var rolechecker;
var snapshot1;

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  // var rolechecker;
  var counter = 0;
  // Fetchinvo() {
  //   // globals.Invo = 'Masta' as Map;
  //   globals.Invo =
  //       FirebaseFirestore.instance.collection("Inventory").snapshots() as Map;
  //   print('${globals.Invo} ansdj');
  // }
  late VideoPlayerController videocontroller;
  @override
  void initState() {
    super.initState();
    navigatetohome();

    videocontroller = VideoPlayerController.asset("assets/pc_builder.mp4")
      ..initialize().then((_) {
        setState(() {
          videocontroller.play();
        });
      });
  }

  @override
  void dispose() {
    videocontroller.dispose();
    super.dispose();
  }

  Widget video() {
    return SizedBox(
      width: 300,
      height: 300,
      child: VideoPlayer(videocontroller),
    );
  }

  navigatetohome() async {
    await Future.delayed(const Duration(milliseconds: 2000), (() {}));
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('Users')
        .doc(user?.uid)
        .get()
        .then((DocumentSnapshot documentsnapshot) {
      if (documentsnapshot.exists) {
        if (documentsnapshot.get('role') == 'admin') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const AdminMenu(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MainMenu(),
            ),
          );
        }
        // isAdmin().then((value) => rolechecker = value);
        // if (rolechecker == 'true') {
        //   Fluttertoast.showToast(msg: '$rolechecker Admin1');
        //   return const AdminMenu();
        // } else {
        //   Fluttertoast.showToast(msg: '$rolechecker user1');
        //   // Fluttertoast.showToast(msg: '$rolechecker pt2');
        //   return const MainMenu();
        // }
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Authpage(),
          ),
        );
      }
    });
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => StreamBuilder<User?>(
    //       //streambuilder
    //       stream: FirebaseAuth.instance.authStateChanges(),
    //       builder: (context, AsyncSnapshot snapshot) {
    //         if (snapshot.connectionState == ConnectionState.waiting) {
    //           return const Center(
    //             child: CircularProgressIndicator(),
    //           );
    //         } else if (!snapshot.hasData) {
    //           return const Center(
    //             child: CircularProgressIndicator(),
    //           );
    //         } else if (snapshot.hasData) {
    //           if (snapshot.get)
    //             // snapshot1 = snapshot;

    //             var rolechecker = isAdmin();
    //           // isAdmin().then((value) => rolechecker = value);
    //           if (rolechecker == 'admin') {
    //             return const AdminMenu();
    //           } else {
    //             return const MainMenu();
    //           }

    //           // isAdmin().then((value) => rolechecker = value);
    //           // if (rolechecker == 'true') {
    //           //   Fluttertoast.showToast(msg: '$rolechecker Admin1');
    //           //   return const AdminMenu();
    //           // } else {
    //           //   Fluttertoast.showToast(msg: '$rolechecker user1');
    //           //   // Fluttertoast.showToast(msg: '$rolechecker pt2');
    //           //   return const MainMenu();
    //           // }
    //         } else {
    //           return const Authpage();
    //         }
    //       },
    //     ),
    //   ),
    // );
  }

  Future<String> isAdmin() async {
    final user = FirebaseAuth.instance.currentUser!;

    final adminRef = await FirebaseFirestore.instance
        .collection("Users")
        .doc(user.uid)
        .get();
    // Fluttertoast.showToast(msg: 'waqar');
    Map<String, dynamic>? data = adminRef.data();
    Fluttertoast.showToast(msg: 'waqar');
    var role = data?['role'];
    // Fluttertoast.showToast(msg: 'waqar');
    if (role == 'admin') {
      // Fluttertoast.showToast(msg: '$role');
      counter = 1;
      return Future.value('admin');
      // return Future.value('true');
    } else {
      counter = 0;
      // Fluttertoast.showToast(msg: '${adminRef.data()}');
      // return Future.value('false');
      return Future.value('user');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              color: const Color.fromARGB(255, 32, 45, 61),
              height: MediaQuery.of(context).size.height * 0.25,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              color: const Color(0xff202c3c),
              child: video(),
            ),
            Container(
              color: const Color.fromARGB(255, 32, 45, 61),
              height: MediaQuery.of(context).size.height * 0.25,
            ),
          ],
        ),
      ),
    );
  }
}
