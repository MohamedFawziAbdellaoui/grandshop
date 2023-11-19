import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grandshop/admin/store_screen.dart';
import 'package:grandshop/models/categories.dart';
import 'package:grandshop/models/produits.dart';
import 'package:grandshop/models/sous_categories.dart';
import 'package:grandshop/service/api_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class AddSousCategory extends StatefulWidget {
  List<Category> allCategories;
  List<SousCategories> allSousCategories;
  List<Product> allProducts;
  Category category;
  AddSousCategory({
    Key? key,
    required this.category,
    required this.allCategories,
    required this.allSousCategories,
    required this.allProducts,
  }) : super(key: key);

  @override
  State<AddSousCategory> createState() => _AddSousCategoryState();
}

class _AddSousCategoryState extends State<AddSousCategory> {
  GlobalKey<FormState> addSousCategoryFormKey = GlobalKey<FormState>();
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
          body: SingleChildScrollView(
            child: Form(
              key: addSousCategoryFormKey,
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
                      Uuid uuid = Uuid();
                      var id = uuid.v4();
                      if (addSousCategoryFormKey.currentState!.validate()) {
                        addSousCategoryFormKey.currentState!.save();
                        SousCategories newSousCategory = SousCategories(
                          id: id,
                          categoryId: widget.category.id!,
                          name: categoryName,
                          imgPath: categoryImgPath,
                        );
                        ApiService.createSousCategory(id, categoryName,
                            categoryImgPath, widget.category.id!);
                        widget.allSousCategories.add(newSousCategory);
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
                    child: Text("add")),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
