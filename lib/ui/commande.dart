import 'package:flutter/material.dart';
import 'package:grandshop/enum/status.dart';
import 'package:grandshop/models/sous_categories.dart';
import 'package:grandshop/ui/profile.dart';
import 'package:grandshop/ui/widgets/custom_page_view.dart';
import 'package:grandshop/ui/widgets/productItem.dart';

import '../models/categories.dart';
import '../models/commande.dart';
import '../models/produits.dart';
import '../models/user.dart';

class CheckOrder extends StatefulWidget {
  List<SousCategories> sousCategoriesList;
  List<Product> allProducts;
  List<Category> allCategories;
  Order commande;
  User user;
  CheckOrder({
    Key? key,
    required this.commande,
    required this.user,
    required this.allProducts,
    required this.allCategories,
    required this.sousCategoriesList,
  }) : super(key: key);

  @override
  State<CheckOrder> createState() => CheckOrderState();
}

class CheckOrderState extends State<CheckOrder> {
  GlobalKey<AnimatedListState> commandeListKey = GlobalKey<AnimatedListState>();
  List<bool> enabled = List.generate(4, (index) => false);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .6,
                  width: MediaQuery.of(context).size.width,
                  child: AnimatedList(
                      key: commandeListKey,
                      shrinkWrap: true,
                      initialItemCount: widget.commande.products.length,
                      itemBuilder: (context, i, animation) {
                        Product item = widget.commande.products[i]['product'];
                        return ProductItem(
                          increment: () {
                            setState(() {
                              widget.commande.products[widget.commande.products
                                      .indexOf(widget.commande.searchProduct(item))]
                                  ["quantity"] = widget.commande.products[
                                          widget.commande.products.indexOf(
                                              widget.commande.searchProduct(item))]
                                      ["quantity"] +
                                  1;
                              double newPrice =
                                  widget.commande.calculatePrice();
                              widget.commande.setPrice = newPrice;
                            });
                          },
                          deleteFunction: () {
                            int index = widget.commande.products
                                .indexOf(widget.commande.searchProduct(item));
                            widget.commande.products.removeAt(index);
                            commandeListKey.currentState!.removeItem(
                                index, (context, animation) => Container());

                            setState(() {
                              widget.commande.setPrice =
                                  widget.commande.calculatePrice();
                            });
                          },
                          decrement: () {
                            if (widget.commande.products[widget
                                    .commande.products
                                    .indexOf(widget.commande
                                        .searchProduct(item))]["quantity"] >
                                1) {
                              setState(() {
                                widget.commande.products[widget
                                        .commande.products
                                        .indexOf(widget.commande.searchProduct(item))]
                                    ["quantity"] = widget.commande.products[
                                            widget.commande.products.indexOf(
                                                widget.commande.searchProduct(item))]
                                        ["quantity"] -
                                    1;
                                double newPrice =
                                    widget.commande.calculatePrice();
                                widget.commande.setPrice = newPrice;
                              });
                            }
                          },
                          item: widget.commande.products[i]['product'],
                          animation: animation,
                          listKey: commandeListKey,
                          pannier: widget.commande,
                        );
                      }),
                ),
                Container(
                  child: Row(
                    children: [
                      Text("prix de la commande : " +
                          widget.commande.price.toString()),
                      TextButton(
                        child: Text("confirmer"),
                        onPressed: () {
                          widget.commande.setStatus = Status.pending;
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return CustomPageView(
                                allProducts: widget.allProducts,
                                selectedIndex: 0,
                                allCategories: widget.allCategories,
                                sousCategoriesList: widget.sousCategoriesList,
                                pannier: Order(
                                    userId: widget.user.userId!, products: []),
                                user: widget.user);
                          }));
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  child: ListView(
                    primary: false,
                    shrinkWrap: true,
                    children: [
                      CustomTextField(
                        enabled: enabled[0],
                        initVal: widget.user.username!,
                        onSave: (value) {
                          widget.user.username = value!;
                        },
                        enableControl: () {
                          setState(() {
                            enabled[0] = true;
                          });
                        },
                      ),
                      CustomTextField(
                        enabled: enabled[1],
                        enableControl: () {
                          setState(() {
                            enabled[1] = true;
                          });
                        },
                        initVal: widget.user.email!,
                        onSave: (value) {
                          widget.user.email = value!;
                        },
                      ),
                      CustomTextField(
                        enabled: enabled[2],
                        initVal: widget.user.adress!,
                        onSave: (value) {
                          widget.user.adress = value!;
                        },
                        enableControl: () {
                          setState(() {
                            enabled[2] = true;
                          });
                        },
                      ),
                      CustomTextField(
                        enabled: enabled[3],
                        initVal: widget.user.password!,
                        onSave: (value) {
                          widget.user.password = value!;
                        },
                        enableControl: () {
                          setState(() {
                            enabled[3] = true;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
