import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:grandshop/admin/edit_sous_category.dart';

import 'package:grandshop/models/produits.dart';
import 'package:grandshop/models/sous_categories.dart';
import 'package:grandshop/service/api_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class AddProduct extends StatefulWidget {
  SousCategories sousCategory;
  List<Product> allProducts;
  AddProduct({Key? key, required this.sousCategory, required this.allProducts})
      : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  GlobalKey<FormState> addProductFormKey =
      GlobalKey<FormState>(debugLabel: "add meal");
  final ImagePicker _picker = ImagePicker();
  String productName = "";
  String productImgPath = "";
  String description = "";
  double productPrice = 0;
  XFile? pickedImage;
  double productPromoPercent = 0;
  List<Color> colorsList = [Colors.white, Colors.white, Colors.white];
  List<String> sizesList = [];

  bool inPromo = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: Text("Add new product"),
            actions: [
              IconButton(
                icon: Icon(Icons.done),
                onPressed: () {
                  Uuid uuid = Uuid();
                  var id = uuid.v4();
                  if (addProductFormKey.currentState!.validate()) {
                    addProductFormKey.currentState!.save();
                    Product newProduct = Product(
                      id: id,
                      description: description,
                      colors: colorsList,
                      imgPath: productImgPath,
                      name: productName,
                      inpromo: inPromo,
                      promopercent: productPromoPercent,
                      price: productPrice,
                      sousCategoryId: widget.sousCategory.id,
                      stars: 0,
                      sizesList: sizesList,
                    );
                    ApiService.createProduct(
                      id: id,
                      description: description,
                      colorsList: colorsList,
                      imgPath: productImgPath,
                      name: productName,
                      inPromo: inPromo,
                      promoPercent: productPromoPercent,
                      price: productPrice,
                      sousCategoryId: widget.sousCategory.id!,
                      stars: 0,
                      sizesList: sizesList,
                    );
                    widget.allProducts.add(newProduct);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return EditSousCategory(
                        allProducts: widget.allProducts,
                        sousCategory: widget.sousCategory,
                      );
                    }));
                  }
                },
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Form(
              key: addProductFormKey,
              child: Column(
                children: [
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
                                        productImgPath = pickedImage!.path;
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
                                          productImgPath = pickedImage!.path;
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 45, vertical: 10),
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
                        productName = value!;
                      },
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .01,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 45, vertical: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: "description",
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
                        description = value!;
                      },
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .01,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 45,
                      vertical: 10,
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: "price",
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
                        productPrice = double.parse(value!);
                      },
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .01,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 30),
                        child: Text("available colors :"),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 13),
                        height: 40.0,
                        width: MediaQuery.of(context).size.width * .7,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: colorsList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop();
                                          },
                                          child: Text("save"),
                                        ),
                                      ],
                                      content: ColorPicker(
                                          pickerColor: colorsList[index],
                                          onColorChanged: (color) {
                                            setState(() {
                                              colorsList[index] = color;
                                            });
                                          }),
                                    );
                                  },
                                );
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    width: 44,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    width: 44,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: colorsList[index],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "In promo : ",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Switch(
                        activeColor: Colors.black,
                        value: inPromo,
                        onChanged: (v) {
                          setState(
                            () {
                              inPromo = v;
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 45, vertical: 10),
                    child: TextFormField(
                      enabled: inPromo,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        labelText: "promo Percent",
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
                        inPromo
                            ? productPromoPercent = double.parse(value!)
                            : productPromoPercent = 0;
                      },
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .01,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red)),
                      onPressed: () {
                        if (addProductFormKey.currentState!.validate()) {
                          addProductFormKey.currentState!.save();
                          Product newProduct = Product(
                            id: "uzghieghie",
                            sousCategoryId: widget.sousCategory.id,
                            name: productName,
                            imgPath: productImgPath,
                            price: productPrice,
                            inpromo: inPromo,
                            description: description,
                            promopercent: productPromoPercent,
                            colors: colorsList,
                          );
                          widget.allProducts.add(newProduct);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return EditSousCategory(
                                  sousCategory: widget.sousCategory,
                                  allProducts: widget.allProducts,
                                );
                              },
                            ),
                          );
                        }
                      },
                      child: Text("add")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
