// import 'dart:html';

// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/admin/bars/adminNavBar.dart';
import 'package:fyp/user/Screens/Signup.dart';
import 'package:fyp/user/classes/global.dart' as globals;
import 'package:fyp/user/Bars/NavBar.dart';
import 'package:fyp/user/Screens/Homescreen.dart';
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
          globals.role = 'admin';
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const AdminMenu(),
            ),
          );
        } else {
          globals.role = 'user';
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MainMenu(),
            ),
          );
        }
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Authpage(),
          ),
        );
      }
    });
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
