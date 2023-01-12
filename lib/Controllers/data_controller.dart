// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../classes/global.dart' as globals;

class data_controller extends GetxController {
  @override
  void onReady() {
    super.onReady();
    getInvo();
  }

  Future<void> getInvo() async {
    try {
      var response = await FirebaseFirestore.instance
          .collection('Inventory')
          .where('Inventory', isGreaterThan: 0)
          .where('Category', isEqualTo: "Ram")
          .get();
// response.docs.length
      if (response.docs.length > 0) {
        for (int count = 0; count < 5; count++) {
          globals.inventory['Item Name'] = response.docs[count]['Item Name'];
          globals.inventory['Category'] = response.docs[count]['Category'];
        }
      }
      print(globals.inventory);
    } on FirebaseException catch (e) {
      print(e);
    } catch (error) {
      print(error);
    }
  }
}
