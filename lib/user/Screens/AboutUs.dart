// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';

class aboutUs extends StatefulWidget {
  const aboutUs({super.key});

  @override
  State<aboutUs> createState() => _aboutUsState();
}

class _aboutUsState extends State<aboutUs> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('About Us'),
          backgroundColor: const Color.fromARGB(255, 48, 10, 55),
        ),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Pc Builder:',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'The PC-Builder app is a software application, E-Commerce platform, and a recommendation system designed to assist users in building customized personal computers. The app allows users to select components such as the processor, graphics card, motherboard, memory, storage, and power supply. To provide a platform where users can build a PC according to their needs, requirements, and budget. With the help of this idea, users will not need to rush into the market looking for something which can almost fulfill the requirements in the desired budget. ',
                style: TextStyle(),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Contact Us:',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Member 1:',
                style: TextStyle(
                  // decoration: TextDecoration.underline,
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Name: Zawat Masta.\nEmail: Cs1912330@szabist.pk.'),
              SizedBox(
                height: 5,
              ),
              Text(
                'Member 2:',
                style: TextStyle(
                  // decoration: TextDecoration.underline,
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Name: Danish Aslam Sheikh.\nEmail: Cs1912300@szabist.pk.'),
            ],
          ),
        ),
      ),
    );
  }
}
