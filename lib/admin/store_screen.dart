import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grandshop/admin/add_new_category.dart';
import 'package:grandshop/admin/add_sous_category.dart';
import 'package:grandshop/admin/edit_sous_category.dart';
import 'package:grandshop/models/sous_categories.dart';
import 'package:image_picker/image_picker.dart';

import '../models/categories.dart';
import '../models/produits.dart';

class StoreScreen extends StatefulWidget {
  List<Category> allCategories;
  List<SousCategories> sousCategoriesList;
  List<Product> productList;
  StoreScreen({
    Key? key,
    required this.productList,
    required this.sousCategoriesList,
    required this.allCategories,
  }) : super(key: key);

  @override
  State<StoreScreen> createState() => _StoreScreenState();
  static String id = "StoreScreen";
}

class _StoreScreenState extends State<StoreScreen> {
  GlobalKey<FormState> categoriesFormKey = GlobalKey<FormState>();
  GlobalKey<AnimatedListState> categoriesListKey =
      GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    List<ImagePicker> categoriesImagePicker =
        List.generate(widget.allCategories.length, (index) => ImagePicker());
    List<ImagePicker> sousCategoriesImagePicker = List.generate(
        widget.sousCategoriesList.length, (index) => ImagePicker());
    List<XFile?> categoriesPickedImages =
        List.generate(widget.allCategories.length, (index) => XFile(""));
    List<XFile?> sousCategoriesPickedImages = List.generate(
      widget.sousCategoriesList.length,
      (index) => XFile(""),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("edit your categories"),
            backgroundColor: Colors.red,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AddCategory(
                      allProducts: widget.productList,
                      allSousCategories: widget.sousCategoriesList,
                      allCategories: widget.allCategories,
                    );
                  }));
                },
                icon: Icon(Icons.add),
              ),
              IconButton(
                onPressed: () {
                  if (categoriesFormKey.currentState!.validate()) {
                    categoriesFormKey.currentState!.save();
                  }
                },
                icon: Icon(Icons.done),
              ),
            ],
          ),
          body: Form(
            key: categoriesFormKey,
            child: AnimatedList(
              primary: false,
              key: categoriesListKey,
              initialItemCount: widget.allCategories.length,
              itemBuilder: ((context, index, animation) {
                Category categoryItem = widget.allCategories[index];
                return Column(
                  children: [
                    ListTile(
                      leading: Stack(
                        children: [
                          Container(
                            child: categoryItem.imgPath!.startsWith("images")
                                ? Image.asset(categoryItem.imgPath!)
                                : Image.file(
                                    File(categoryItem.imgPath!),
                                  ),
                          ),
                          IconButton(
                            onPressed: () async {
                              categoriesPickedImages[index] =
                                  await categoriesImagePicker[index]
                                      .pickImage(source: ImageSource.gallery);
                              if (categoriesPickedImages[index] != XFile("")) {
                                setState(
                                  () {
                                    print(categoriesPickedImages[index]!.path);
                                    categoryItem.setImgPath =
                                        categoriesPickedImages[index]!.path;
                                  },
                                );
                              }
                            },
                            icon: Icon(Icons.edit),
                          ),
                        ],
                      ),
                      title: TextFormField(
                        initialValue: categoryItem.name,
                        decoration: InputDecoration(labelText: "Category name"),
                      ),
                      subtitle: FittedBox(
                        child: TextButton(
                          child: Text(
                            " Sous Category ''" + categoryItem.name! + "''",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return AddSousCategory(
                                  category: categoryItem,
                                  allCategories: widget.allCategories,
                                  allSousCategories: widget.sousCategoriesList,
                                  allProducts: widget.productList);
                            }));
                          },
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            widget.allCategories.removeAt(index);
                            categoriesListKey.currentState!.removeItem(
                              index,
                              (context, animation) => SizedBox(),
                            );
                          });
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    AnimatedList(
                      primary: false,
                      shrinkWrap: true,
                      initialItemCount: widget.sousCategoriesList
                          .where((element) =>
                              element.categoryId == categoryItem.id)
                          .length,
                      itemBuilder: (((context, j, animation) {
                        List<SousCategories> newSousCategoriesList = List.from(
                            widget.sousCategoriesList.where((element) =>
                                element.categoryId == categoryItem.id));
                        SousCategories sousCategoryItem =
                            newSousCategoriesList[j];
                        return ListTile(
                          leading: Stack(
                            children: [
                              Container(
                                child: sousCategoryItem.imgPath!
                                        .startsWith("images")
                                    ? Image.asset(sousCategoryItem.imgPath!)
                                    : Image.file(
                                        File(sousCategoryItem.imgPath!),
                                      ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  sousCategoriesPickedImages[j] =
                                      await sousCategoriesImagePicker[j]
                                          .pickImage(
                                              source: ImageSource.gallery);
                                  if (sousCategoriesPickedImages[j] !=
                                      XFile("")) {
                                    setState(
                                      () {
                                        print(categoriesPickedImages[index]!
                                            .path);
                                        sousCategoryItem.setImgPath =
                                            sousCategoriesPickedImages[index]!
                                                .path;
                                      },
                                    );
                                  }
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          title: TextFormField(
                            initialValue: sousCategoryItem.name,
                            decoration: InputDecoration(
                                labelText: "Sous category name"),
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return EditSousCategory(
                                      sousCategory: sousCategoryItem,
                                      allProducts: widget.productList,
                                    );
                                  }),
                                );
                              },
                              icon: Icon(Icons.edit)),
                        );
                      })),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
