import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grandshop/admin/store_screen.dart';
import 'package:grandshop/models/sous_categories.dart';
import 'package:grandshop/service/api_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../models/categories.dart';
import '../models/produits.dart';
import 'add_product.dart';

class AddCategory extends StatefulWidget {
  List<Category> allCategories;
  List<SousCategories> allSousCategories;
  List<Product> allProducts;
  AddCategory({
    Key? key,
    required this.allProducts,
    required this.allSousCategories,
    required this.allCategories,
  }) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  GlobalKey<FormState> addCategoryFormKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  XFile? pickedImage;
  String categoryImgPath = "";
  String categoryName = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_outlined),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text("edit sous category"),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.done),
              ),
            ],
          ),
          body: SingleChildScrollView(
              child: Form(
            key: addCategoryFormKey,
            child: Column(children: [
              Container(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * .35,
                      width: MediaQuery.of(context).size.width,
                      child: pickedImage == null
                          ? Container(color: Colors.grey[500])
                          : Image.file(
                              File(pickedImage!.path),
                              fit: BoxFit.cover,
                            ),
                    ),
                    pickedImage == null
                        ? IconButton(
                            onPressed: () async {
                              pickedImage = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              if (pickedImage != null) {
                                setState(
                                  () {
                                    print(pickedImage!.path);
                                    categoryImgPath = pickedImage!.path;
                                  },
                                );
                              }
                            },
                            icon: Icon(Icons.add_a_photo,
                                color: Colors.white, size: 45),
                          )
                        : Positioned(
                            bottom: 0,
                            left: 0,
                            child: IconButton(
                              onPressed: () async {
                                pickedImage = await _picker.pickImage(
                                    source: ImageSource.gallery);
                                if (pickedImage != null) {
                                  setState(
                                    () {
                                      print(pickedImage!.path);
                                      categoryImgPath = pickedImage!.path;
                                    },
                                  );
                                }
                              },
                              icon: Icon(Icons.add_a_photo,
                                  color: Colors.white, size: 45),
                            ),
                          ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 45, vertical: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Name",
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(60),
                      borderSide: BorderSide(color: Colors.grey.shade600),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(60),
                      borderSide: BorderSide(color: Colors.grey.shade600),
                    ),
                  ),
                  onSaved: (value) {
                    categoryName = value!;
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .01,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .01,
              ),
              ElevatedButton(
                onPressed: () {
                  var uuid = Uuid();
                  if (addCategoryFormKey.currentState!.validate()) {
                    addCategoryFormKey.currentState!.save();
                    Category newCategory = Category(
                      id: uuid.v4(),
                      name: categoryName,
                      imgPath: categoryImgPath,
                    );

                    ApiService.createCategory(
                      uuid.v4(),
                      categoryName,
                      categoryImgPath,
                    );

                    widget.allCategories.add(newCategory);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return StoreScreen(
                            productList: widget.allProducts,
                            sousCategoriesList: widget.allSousCategories,
                            allCategories: widget.allCategories,
                          );
                        },
                      ),
                    );
                  }
                },
                child: Text("add"),
              ),
            ]),
          )),
        ),
      ),
    );
  }
}
