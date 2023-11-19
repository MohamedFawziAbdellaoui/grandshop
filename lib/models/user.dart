import 'package:grandshop/models/produits.dart';
import 'package:http/http.dart' as http;

class User {
  String? userId;
  String? username;
  String? email;
  String? password;
  String? num;
  bool? isAdmin;
  List<Product>? fav = [];
  String? adress;
  User({
    this.userId,
    this.username,
    this.email,
    this.password,
    this.adress,
    this.isAdmin = false,
    this.fav,
    this.num,
  });
  User.fromJson(Map<String, dynamic> json) {
    userId = json['id'];
    username = json['username'];
    email = json['email'];
    isAdmin = json['isAdmin'];
    fav = json["fav"];
    num = json["num"];
  }
}
