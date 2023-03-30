import 'package:flutter/material.dart';
import 'package:fyp/user/Screens/WarrantyList.dart';
import 'package:fyp/user/Screens/WarrentyClaim.dart';

class Warranty extends StatefulWidget {
  const Warranty({super.key});

  @override
  State<Warranty> createState() => _WarrantyState();
}

class _WarrantyState extends State<Warranty> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              bottom: const TabBar(
                tabs: [
                  Tab(
                    text: 'Warranty Claim',
                  ),
                  Tab(
                    text: 'Warranty Checker',
                  ),
                ],
              ),
              backgroundColor: const Color.fromARGB(255, 48, 10, 55),
              title: const Text('Warranty Section'),
            ),
            body: const TabBarView(
              children: [
                WarrentyClaim(),
                WarrantyList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
