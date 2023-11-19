import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grandshop/admin/add_product.dart';
import 'package:grandshop/models/produits.dart';
import 'package:grandshop/models/sous_categories.dart';
import 'package:grandshop/service/api_service.dart';

class EditSousCategory extends StatefulWidget {
  SousCategories sousCategory;
  List<Product> allProducts;
  EditSousCategory({
    Key? key,
    required this.sousCategory,
    required this.allProducts,
  }) : super(key: key);

  @override
  State<EditSousCategory> createState() => _EditSousCategoryState();
}

class _EditSousCategoryState extends State<EditSousCategory> {
  GlobalKey<AnimatedListState> productListKey = GlobalKey<AnimatedListState>();
  GlobalKey<FormState> productsFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_outlined),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text("edit sous category"),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AddProduct(
                      sousCategory: widget.sousCategory,
                      allProducts: widget.allProducts,
                    );
                  }));
                },
                icon: Icon(Icons.add),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.done),
              ),
            ],
          ),
          body: Form(
            key: productsFormKey,
            child: ListView(
              primary: false,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TextFormField(
                    initialValue: widget.sousCategory.name,
                    style: TextStyle(fontSize: 25, letterSpacing: 2),
                    decoration: InputDecoration(
                      labelText: "Sous Category name :",
                      labelStyle: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
                AnimatedList(
                  key: productListKey,
                  primary: false,
                  shrinkWrap: true,
                  initialItemCount: widget.allProducts
                      .where((element) =>
                          element.sousCategoryId == widget.sousCategory.id)
                      .length,
                  itemBuilder: ((context, index, animation) {
                    List<Product> filtredList = List.from(widget.allProducts
                        .where((element) =>
                            element.sousCategoryId == widget.sousCategory.id));
                    Product productItem = filtredList[index];
                    return ListTile(
                      leading: Stack(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.edit),
                          ),
                          Container(
                            child: productItem.imgPath!.startsWith("images")
                                ? Image.asset(productItem.imgPath!)
                                : Image.file(
                                    File(productItem.imgPath!),
                                  ),
                          ),
                        ],
                      ),
                      title: Column(
                        children: [
                          TextFormField(
                            initialValue: productItem.name,
                            decoration:
                                InputDecoration(labelText: "Category name"),
                          ),
                          TextFormField(
                            initialValue: productItem.price.toString(),
                            decoration: InputDecoration(labelText: "price"),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              Text("in promo : "),
                              Switch(
                                value: productItem.inpromo!,
                                onChanged: (value) {
                                  setState(() {
                                    productItem.setInpromo = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          TextFormField(
                            initialValue: productItem.promopercent.toString(),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          widget.allProducts.remove(productItem);
                          productListKey.currentState!.removeItem(
                              index, (context, animation) => Container());
                          ApiService.deleteProduct(productItem.id!);
                        },
                        icon: Icon(Icons.delete),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
