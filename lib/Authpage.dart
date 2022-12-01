import 'package:flutter/material.dart';
import 'package:fyp/LoginScreen.dart';
import 'package:fyp/Signup.dart';

class Authpage extends StatefulWidget {
  const Authpage({super.key});

  @override
  State<Authpage> createState() => _AuthpageState();
}

class _AuthpageState extends State<Authpage> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) => isLogin
      ? LoginScreen(onClickedSignup: toggle)
      : Signup(onClickedLogin: toggle);
  void toggle() => setState(() => isLogin = !isLogin);
}
