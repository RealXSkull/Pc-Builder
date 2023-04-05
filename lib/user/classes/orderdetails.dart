import 'package:cloud_firestore/cloud_firestore.dart';

class Orderdetails {
  final String item;
  final int quantity;
  final double price;
  final double total;
  final String contact;
  final String invoice;
  final String username;
 

  Orderdetails({
    required this.item,
    required this.quantity,
    required this.price,
    required this.total,
    required this.contact,
    required this.invoice,
    required this.username,

  });
  factory Orderdetails.fromMap(Map<String, dynamic> data) {
    return Orderdetails(
      item: data['Item '],
      quantity: data['quantity'],
      price: data['price'],
      total: data['total'],
      contact: data['contact'],
      invoice: data['invoice'],
      username: data['username'],
    
    );
  }
}
