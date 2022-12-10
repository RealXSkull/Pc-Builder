// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names, prefer_final_fields, unnecessary_new, use_key_in_widget_constructors, avoid_print, non_constant_identifier_names, sized_box_for_whitespace, must_call_super, dead_code

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Review extends StatefulWidget {
  const Review({super.key});

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('FeedBack'),
          backgroundColor: Colors.blueGrey,
        ),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: Form(
            // key: formkey,
            child: Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xff588F8F), Color(0x00000000)])),
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // buildname(),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // buildemail(),
                        const SizedBox(
                          height: 20,
                        ),
                        // buildphone(),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // buildpassword(),
                        SizedBox(
                          height: 20,
                        ),
                        //buildconfirmpassword(),
                        SizedBox(
                          height: 20,
                        ),
                        // Registerbtn(),
                        SizedBox(
                          height: 20,
                        ),
                        //AlreadyAccountbtn()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
