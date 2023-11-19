import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:grandshop/models/categories.dart';
import 'package:grandshop/models/loginrequest.dart';
import 'package:grandshop/models/sous_categories.dart';
import 'package:grandshop/service/shared_services.dart';
import 'package:http/http.dart' as http;
import '../config.dart';
import '../models/SignupResponseModel.dart';
import '../models/loginResponseModel.dart';
import '../models/produits.dart';
import '../models/signup_request.dart';

class ApiService {
  static var client = http.Client();

  static Future<LoginResponseModel> login(
      LoginRequestModel loginRequest) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(Config.apiUrl, Config.loginApi);
    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(loginRequest.toJson()));
    if (response.statusCode == 200) {
      await SharedServices.setLoginDetails(loginResponseModel(response.body));
      return loginResponseModel(response.body);
    } else {
      return loginResponseModel(response.statusCode);
    }
  }

  static Future<SignUpResponseModel> signUp(
      SignUpRequestModel signUpRequest) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(Config.apiUrl, Config.registerApi);
    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(signUpRequest.toJson()));
    if (response.statusCode == 200) {
      return signupResponseModel(response.body);
    } else {
      return signupResponseModel({'message': "Error"});
    }
  }

  static Future<List<Category>> getAllCategories() async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    List<Category> categoriesList = List.empty(growable: true);
    var url = Uri.http(Config.apiUrl, Config.categoryApi);
    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      List<dynamic> values = List.empty(growable: true);
      values = jsonDecode(response.body);
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            categoriesList.add(Category.fromJson(map));
          }
        }
      }
      return categoriesList;
    } else {
      throw Exception('Failed to load Category');
    }
  }

  static Future<List<SousCategories>> getAllSousCategories() async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    List<SousCategories> sousCategoriesList = List.empty(growable: true);
    var url = Uri.http(Config.apiUrl, Config.sousCategoryApi);
    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      List<dynamic> values = List.empty(growable: true);
      values = jsonDecode(response.body);
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            sousCategoriesList.add(SousCategories.fromJson(map));
          }
        }
      }
      return sousCategoriesList;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load Sous categories');
    }
  }

  static Future<List<Product>> getAllProducts() async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    List<Product> productsList = List.empty(growable: true);
    var url = Uri.http(Config.apiUrl, Config.productApi);
    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      List<dynamic> values = List.empty(growable: true);
      values = jsonDecode(response.body);
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            productsList.add(Product.fromJson(map));
          }
        }
      }
      return productsList;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load Product');
    }
  }

  static Future<Category> createCategory(
      String id, String name, String imgPath) async {
    var url = Uri.http(Config.apiUrl, Config.categoryApi);
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        "id": id,
        "name": name,
        "imgPath": imgPath,
      }),
    );
    if (response.statusCode == 200) {
      return Category.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("There is an error creatingSousCategory");
    }
  }

  static Future<SousCategories> createSousCategory(
      String id, String name, String imgPath, String categoryId) async {
    var url = Uri.http(Config.apiUrl, Config.sousCategoryApi);
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        "id": id,
        "categoryId": categoryId,
        "name": name,
        "imgPath": imgPath,
      }),
    );
    if (response.statusCode == 200) {
      return SousCategories.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("There is an error creatingSousCategory");
    }
  }

  static Future<Product> createProduct({
    required String id,
    required String name,
    required String imgPath,
    required String sousCategoryId,
    required String description,
    required double price,
    required bool inPromo,
    double promoPercent = 0,
    required int stars,
    required List<Color> colorsList,
    List<String> sizesList = const [],
  }) async {
    var url = Uri.http(Config.apiUrl, Config.productApi);
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        "id": id,
        "sousCategoryId": sousCategoryId,
        "name": name,
        "description": description,
        "imgPath": imgPath,
        "price": price,
        "colors": colorsList,
        "sizes": sizesList,
        "stars": stars,
        "inPromo": inPromo,
        "promoPercent": promoPercent,
      }),
    );
    if (response.statusCode == 200) {
      return Product.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("There is an error creatingSousCategory");
    }
  }

  static Future<Category> updateCategory(
      String id, String name, String imgPath) async {
    var url = Uri.http(Config.apiUrl, Config.categoryApi);
    final response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "id": id,
        "name": name,
        "imgPath": imgPath,
      }),
    );

    if (response.statusCode == 200) {
      return Category.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update album.');
    }
  }

  static Future<SousCategories> updateSousCategory(
      String id, String name, String imgPath, String categoryId) async {
    var url = Uri.http(Config.apiUrl, Config.categoryApi);
    final response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "id": id,
        "name": name,
        "imgPath": imgPath,
        "categoryId": categoryId,
      }),
    );

    if (response.statusCode == 200) {
      return SousCategories.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update album.');
    }
  }

  static Future<Product> updateProduct({
    required String id,
    required String name,
    required String imgPath,
    required String sousCategoryId,
    required String description,
    required double price,
    required bool inPromo,
    double promoPercent = 0,
    required int stars,
    required List<Color> colorsList,
    List<String> sizesList = const [],
  }) async {
    var url = Uri.http(Config.apiUrl, Config.categoryApi);
    final response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "id": id,
        "sousCategoryId": sousCategoryId,
        "name": name,
        "description": description,
        "imgPath": imgPath,
        "price": price,
        "colors": colorsList,
        "sizes": sizesList,
        "stars": stars,
        "inPromo": inPromo,
        "promoPercent": promoPercent,
      }),
    );

    if (response.statusCode == 200) {
      return Product.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update album.');
    }
  }

  static Future<Category> deleteCategory(String id) async {
    var url = Uri.http(Config.apiUrl, Config.categoryApi + "/$id");
    final http.Response response = await http.delete(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return Category.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to delete album.');
    }
  }

  static Future<SousCategories> deleteSousCategory(String id) async {
    var url = Uri.http(Config.apiUrl, Config.sousCategoryApi + "/$id");
    final http.Response response = await http.delete(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return SousCategories.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to delete album.');
    }
  }

  static Future<Product> deleteProduct(String id) async {
    var url = Uri.http(Config.apiUrl, Config.productApi + "/$id");
    final http.Response response = await http.delete(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return Product.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to delete album.');
    }
  }
}
