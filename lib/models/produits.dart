import 'dart:convert';
import 'package:flutter/material.dart';

List<Product> productsFromJson(dynamic str) =>
    List<Product>.from((str).map((x) => Product.fromJson(x)));

class Product {
  String? id;
  String? name;
  String? description;
  String? sousCategoryId;
  double? price;
  String? imgPath;
  bool? inpromo;
  double? promopercent;
  List<Color>? colors;
  List<String>? sizes;
  int? stars;
  String? get getId => this.id;

  set setId(String? id) => this.id = id;

  get getName => this.name;

  set setName(name) => this.name = name;

  get getDescription => this.description;

  set setDescription(description) => this.description = description;

  get getSousCategoryId => this.sousCategoryId;

  set setSousCategoryId(sousCategoryId) => this.sousCategoryId = sousCategoryId;

  get getPrice => this.price;

  set setPrice(price) => this.price = price;

  get getImgPath => this.imgPath;

  set setImgPath(imgPath) => this.imgPath = imgPath;

  get getInpromo => this.inpromo;

  set setInpromo(inpromo) => this.inpromo = inpromo;

  get getPromopercent => this.promopercent;

  set setPromopercent(promopercent) => this.promopercent = promopercent;

  get getColors => this.colors;

  set setColors(colors) => this.colors = colors;

  get getSizes => this.sizes;

  set setSizes(sizes) => this.sizes = sizes;

  get getStars => this.stars;

  set setStars(stars) => this.stars = stars;
  Product({
    this.id,
    this.sousCategoryId,
    this.name,
    this.imgPath,
    this.price,
    this.colors,
    this.description,
    this.stars = 0,
    this.promopercent = 0,
    this.inpromo = false,
    List<String>? sizesList,
  }) : sizes = sizesList ?? [];

  Map<dynamic, dynamic> toJson() {
    Map<dynamic, dynamic> data = {};
    data["id"] = id;
    data["name"] = name;
    data["price"] = price;
    data["promopercent"] = promopercent;
    data["inpromo"] = inpromo;
    data["description"] = description;
    return data;
  }

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sousCategoryId = json['sousCategoryId'];
    name = json['name'];
    imgPath = json['imgPath'];
    description = json['description'];
    sizes = json['sizesList'];
    stars = json['stars'];
    price = json['price'];
    promopercent = json['promoPercent'];
    inpromo = json['inpromo'];
    colors = json['colors'];
  }
}
