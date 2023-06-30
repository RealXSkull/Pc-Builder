// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:fyp/user/Screens/Categoriesdetail.dart';
import 'package:fyp/user/classes/global.dart' as globals;

class categories extends StatefulWidget {
  const categories({super.key});

  @override
  State<categories> createState() => _categoriesState();
}

class _categoriesState extends State<categories> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Categories'),
          backgroundColor: const Color.fromARGB(255, 48, 10, 55),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder<List<String>>(
            future: globals.getcategory2(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                // Categories are available in snapshot.data
                List<String> categories = snapshot.data ??
                    []; // Default to an empty list if data is null

                return ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    String category = categories[index];
                    return ListTile(
                      title: Text(category),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => cat_detail(Category: category.toString()),
                            ));
                      },
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
