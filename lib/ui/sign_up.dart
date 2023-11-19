import 'package:flutter/material.dart';
import 'package:grandshop/models/categories.dart';
import 'package:grandshop/models/loginrequest.dart';
import 'package:grandshop/models/sous_categories.dart';
import 'package:grandshop/ui/widgets/custom_page_view.dart';
import 'package:uuid/uuid.dart';

import '../models/commande.dart';
import '../models/produits.dart';
import '../models/signup_request.dart';
import '../models/user.dart';
import '../service/api_service.dart';

class SignUp extends StatefulWidget {
  SignUp({
    Key? key,
  }) : super(key: key);
  @override
  _SignUpState createState() => _SignUpState();
  static String id = "sign_up";
}

class _SignUpState extends State<SignUp> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late var allCategories;
  late var allSousCategories;
  late var allProducts;
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

  @override
  Widget build(BuildContext context) {
    late User user;
    late LoginRequestModel loginRequest;

    late String email, name, password, confirmPassword, adress, numTel;
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: 500,
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 40),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.account_circle,
                            color: Colors.white,
                            size: 50,
                          ),
                          Text(
                            ' sign Up',
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
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: TextFormField(
                      onSaved: (val) {
                        name = val!;
                      },
                      validator: (val) {
                        if (val!.length < 2) {
                          return "userName is too short";
                        }
                      },
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.perm_identity),
                        hintText: ('username'),
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.white, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.white, width: 2),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Form(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: TextFormField(
                            controller: emailController,
                            onSaved: (val) {
                              email = val!;
                            },
                            validator: (val) {
                              if (val!.length > 3) {
                                return "email is too short";
                              }
                            },
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
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
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: TextFormField(
                            controller: passwordController,
                            onSaved: (val) {
                              password = val!;
                            },
                            validator: (val) {
                              if (val!.length < 4) {
                                return "le mot de passe doit étre plus long que 4 lettres";
                              }
                            },
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
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: TextFormField(
                            onSaved: (val) {
                              numTel = val!;
                            },
                            validator: (val) {
                              if (val!.length < 4) {
                                return "numero doit étre plus long que 4 lettres";
                              }
                            },
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.location_city),
                              hintText: ('adress'),
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
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: TextFormField(
                            onSaved: (val) {
                              adress = val!;
                            },
                            validator: (val) {
                              if (val!.length != 8) {
                                return "num doit étre plus long que 4 lettres";
                              }
                            },
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              hintText: ('num'),
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
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                print("saved Form");

                                SignUpRequestModel signUpRequest =
                                    SignUpRequestModel(
                                  email: email,
                                  password: password,
                                  adress: adress,
                                  num: numTel,
                                  username: name,
                                );
                                print(signUpRequest.toString());
                                Uuid uuid = Uuid();
                                ApiService.signUp(signUpRequest)
                                    .then((signUpResponse) => {
                                          if (signUpResponse.message != "Error")
                                            {
                                              user = User(
                                                userId: uuid.v4(),
                                                email: email,
                                                adress: adress,
                                                password: password,
                                                num: numTel,
                                                username: name,
                                                fav: [],
                                              ),
                                              loginRequest = LoginRequestModel(
                                                email: user.email,
                                                password: user.password,
                                              )
                                            }
                                        });
                                ApiService.login(loginRequest).then(
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
                                          allCategories =
                                              getCategories() as List;
                                          allSousCategories =
                                              getSousCategories() as List;
                                          allProducts = getProducts() as List;
                                        }),
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return CustomPageView(
                                                allCategories:
                                                    allCategories,
                                                sousCategoriesList:
                                                    allSousCategories,
                                                allProducts: allProducts,
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
                              'Sign Up',
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
