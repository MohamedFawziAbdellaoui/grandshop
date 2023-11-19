import 'package:grandshop/models/sous_categories.dart';

List<Category> productsFromJson(dynamic str) =>
    List<Category>.from((str).map((x) => Category.fromJson(x)));

class Category {
  String? id;
  String? name;
  String? imgPath;
  String? get getImgPath => this.imgPath;

  set setImgPath(String imgPath) => this.imgPath = imgPath;

  String? get getId => id;

  set setId(String id) => this.id = id;

  get getName => name;

  set setName(name) => this.name = name;

  Category({
    required this.id,
    required this.name,
    required this.imgPath,
  });

  Map<dynamic, dynamic> toJson() {
    Map<dynamic, dynamic> data = {};
    data["id"] = id;
    data["name"] = name;
    data["imgPath"] = imgPath;
    return data;
  }

  Category.fromJson(Map<dynamic, dynamic> jsonData) {
    id = jsonData["id"];
    name = jsonData["name"];
    imgPath = jsonData["imgPath"];
  }
}
