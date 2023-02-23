// ignore_for_file: file_names

class Products {
  String? name;
  String? size;
  int? quantity;
  Products({this.name, this.size, this.quantity});

  Products.addAll(moreProducts);
  List<Products> products = [
    Products(name: 'item 4', size: 'S', quantity: 1),
  ];

  List<Products> moreProducts = [
    Products(name: 'item 2', size: 'M', quantity: 5),
    Products(name: 'item 3', size: 'S', quantity: 3),
  ];

}
