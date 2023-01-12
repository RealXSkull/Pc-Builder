// import 'dart:html';

// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/classes/global.dart' as globals;
import 'package:fyp/Bars/NavBar.dart';
import 'package:fyp/Screens/Homescreen.dart';
import 'package:video_player/video_player.dart';

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
        ),
        );
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
