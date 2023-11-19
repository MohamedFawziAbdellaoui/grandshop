import 'package:grandshop/models/produits.dart';

import '../enum/status.dart';

class Order {
  String userId;
  List<Map<String, dynamic>> products;
  double price;
  Status status;
  String get getUserId => this.userId;

  set setUserId(String userId) => this.userId = userId;

  get getProducts => this.products;

  set setProducts(products) => this.products = products;

  get getPrice => this.price;

  set setPrice(price) => this.price = price;

  get getStatus => this.status;

  set setStatus(status) => this.status = status;
  Order({
    required this.userId,
    this.price = 0,
    required this.products,
    this.status = Status.notConfirmed,
  });

  double calculatePrice() {
    double p = 0;
    if (products != []) {
      for (int i = 0; i < products.length; i++) {
        double q = products[i]["product"].price * products[i]["quantity"];
        p += q;
      }
    }
    return p;
  }

  Map<String, dynamic> searchProduct(Product pr) {
    Map<String, dynamic> item = {};
    for (var map in products) {
      if (map.containsValue(pr)) {
        item = map;
        break;
      }
    }
    return item;
  }
}
