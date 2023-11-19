class SignUpRequestModel {
  String? username;
  String? email;
  String? password;
  String? num;
  String? adress;

  SignUpRequestModel(
      {this.username, this.email, this.password, this.num, this.adress});

  SignUpRequestModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    password = json['password'];
    num = json['num'];
    adress = json['adress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;
    data['num'] = this.num;
    data['adress'] = this.adress;
    return data;
  }
}
