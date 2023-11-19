import 'dart:convert';

LoginResponseModel loginResponseModel(str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  String? id;
  String? username;
  String? email;
  String? message;
  bool? isAdmin;
  String? token;
  String? adress;

  LoginResponseModel(
      {this.id,
      this.username,
      this.email,
      this.isAdmin,
      this.token,
      this.message,
      this.adress});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    isAdmin = json['isAdmin'];
    token = json['token'];
    message = json["message"];
    adress = json["adress"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['isAdmin'] = this.isAdmin;
    data['token'] = this.token;
    data['message'] = message;
    data["adress"] = adress;
    return data;
  }
}
