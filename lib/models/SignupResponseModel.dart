import 'dart:convert';

SignUpResponseModel signupResponseModel(str) =>
    SignUpResponseModel.fromJson(json.decode(str));

class SignUpResponseModel {
  String? username;
  String? email;
  String? password;
  String? adresse;
  bool? isAdmin;
  String? sId;
  String? message;
  int? iV;

  SignUpResponseModel({
    required this.username,
    required this.email,
    required this.password,
    required this.adresse,
    required this.isAdmin,
    required this.sId,
    required this.iV,
    required this.message,
  });

  SignUpResponseModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    password = json['password'];
    adresse = json['adresse'];
    isAdmin = json['isAdmin'];
    sId = json['_id'];
    iV = json['__v'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;
    data['adresse'] = this.adresse;
    data['isAdmin'] = this.isAdmin;
    data['_id'] = this.sId;
    data['__v'] = this.iV;
    data['message'] = message;
    return data;
  }
}
