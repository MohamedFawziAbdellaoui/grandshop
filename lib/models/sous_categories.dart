import 'package:flutter/material.dart';
import 'package:grandshop/models/produits.dart';

class SousCategories {
  String? id;
  String? name;
  String? imgPath;
  String? get getImgPath => this.imgPath;
  String? categoryId;
  set setImgPath(String imgPath) => this.imgPath = imgPath;

  String? get getId => id;

  set setId(String id) => this.id = id;

  get getName => name;

  set setName(name) => this.name = name;

  SousCategories({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.imgPath,
  });

  Map<dynamic, dynamic> toJson() {
    Map<dynamic, dynamic> data = {};
    data["id"] = id;
    data["name"] = name;
    data["categoryId"] = categoryId;
    data["imgPayh"] = imgPath;
    return data;
  }

  SousCategories.fromJson(Map<dynamic, dynamic> jsonData) {
    id = jsonData["id"];
    name = jsonData["name"];
    categoryId = jsonData["categoryId"];
    imgPath = jsonData["imgPath"];
  }
}
