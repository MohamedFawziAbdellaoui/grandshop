import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grandshop/models/loginResponseModel.dart';
import 'package:grandshop/models/loginrequest.dart';
import 'package:grandshop/models/user.dart';
import 'package:grandshop/service/api_service.dart';
import 'package:grandshop/ui/sign_up.dart';
import 'package:grandshop/ui/widgets/custom_page_view.dart';
import '../models/categories.dart';
import '../models/commande.dart';
import '../models/produits.dart';
import '../models/sous_categories.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
  static String id = "sign_in";
}

class _SignInState extends State<SignIn> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String userEmail, password;
  late LoginResponseModel loginResponse;
  late User user;
  late var categoriesList;
  late var productsList;
  late var sousCategoriesList;
  Future<List<Category>> getCategories() {
    List<Category> myCategories = List.empty(growable: true);
    return ApiService.getAllCategories().then(
      (values) {
        for (var i = 0; i < values.length; i++) {
          myCategories.add(values[i]);
        }
        return myCategories;
      },
    );
  }

  Future<List<SousCategories>> getSousCategories() {
    List<SousCategories> mySousCategories = List.empty(growable: true);
    return ApiService.getAllSousCategories().then(
      (values) {
        for (var i = 0; i < values.length; i++) {
          mySousCategories.add(values[i]);
        }
        return mySousCategories;
      },
    );
  }

  Future<List<Product>> getProducts() {
    List<Product> myproducts = List.empty(growable: true);
    return ApiService.getAllProducts().then(
      (values) {
        for (var i = 0; i < values.length; i++) {
          myproducts.add(values[i]);
        }
        return myproducts;
      },
    );
  }

  bool isApiCallProcess = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/a.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              height: 400,
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.account_circle,
                            color: Colors.white,
                            size: 50,
                          ),
                          Text(
                            ' sign In ',
                            style: TextStyle(
                              fontSize: (45),
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                              shadows: [
                                Shadow(color: Colors.redAccent, blurRadius: 1),
                              ],
                            ),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: TextFormField(
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.perm_identity),
                              hintText: ('email'),
                              hintStyle: TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "can't be empty";
                              } else if (value.length < 3) {
                                return "must have more than 3 chacarters";
                              }
                            },
                            onSaved: (value) {
                              userEmail = value!;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: TextFormField(
                            obscureText: true,
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              hintText: ('password'),
                              hintStyle: TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "can't be empty";
                              } else if (value.length < 3) {
                                return "must have more than 3 chacarters";
                              }
                            },
                            onSaved: (value) {
                              password = value!;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                print("saved Form");
                                setState(() {
                                  isApiCallProcess = true;
                                });
                                LoginRequestModel request = LoginRequestModel(
                                    email: userEmail, password: password);
                                print(request.toString());
                                ApiService.login(request).then(
                                  (response) => {
                                    print("email :  " + response.email!),
                                    if (response.id != null)
                                      {
                                        print(response.username!),
                                        user = User.fromJson({
                                          "id": response.id,
                                          "username": response.username,
                                          "email": "fawzi@gmail.com",
                                          "isAdmin": false,
                                          "adress": response.adress
                                        }),
                                        print(User),
                                        setState(() {
                                          categoriesList =
                                              getCategories() as List;
                                          sousCategoriesList =
                                              getSousCategories as List;
                                          productsList = getProducts as List;
                                        }),
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return CustomPageView(
                                                allCategories: categoriesList,
                                                allProducts: productsList,
                                                sousCategoriesList:
                                                    sousCategoriesList,
                                                selectedIndex: 0,
                                                pannier: Order(
                                                    userId: user.userId!,
                                                    products: []),
                                                user: user,
                                              );
                                            },
                                          ),
                                        )
                                      }
                                    else if (response.message ==
                                        "incorrect email or password")
                                      {print(response.message)}
                                  },
                                );
                              }
                            },
                            child: Text(
                              'LogIn',
                              style: TextStyle(color: Colors.red),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.grey[300],
                              padding: EdgeInsets.symmetric(
                                  horizontal: 135, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 50, right: 50),
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Forgot Password ?',
                            style: TextStyle(color: Colors.red),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, SignUp.id);
                            },
                            child: Text(
                              'Click Here',
                              style: TextStyle(
                                color: Colors.red,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
