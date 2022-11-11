// ignore_for_file: use_key_in_widget_constructors

import 'LoginScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PC Builder',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
