// ignore_for_file: use_key_in_widget_constructors, depend_on_referenced_packages, prefer_const_constructors, duplicate_ignore, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fyp/Screens/Homescreen.dart';
import 'firebase_options.dart';
import 'package:fyp/Screens/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'PC Builder',
      debugShowCheckedModeBanner: false,
      home: Splashscreen());
}
