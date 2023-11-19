import 'package:flutter/material.dart';
import 'package:grandshop/models/produits.dart';
import 'package:grandshop/ui/allProducts.dart';
import 'package:grandshop/ui/commande.dart';
import 'package:grandshop/ui/widgets/custom_page_view.dart';
import 'package:grandshop/ui/widgets/productItem.dart';
import '../enum/status.dart';
import '../models/categories.dart';
import '../models/commande.dart';
import '../models/sous_categories.dart';
import '../models/user.dart';

class Pannier extends StatefulWidget {
  Order pannier;
  User user;
  List<Product> allProductList;
  List<SousCategories> sousCategoriesList;

  List<Category> allCategories;
  Pannier(
      {Key? key,
      required this.pannier,
      required this.user,
      required this.allProductList,
      required this.allCategories,
      required this.sousCategoriesList})
      : super(key: key);

  @override
  State<Pannier> createState() => _PannierState();
}

class _PannierState extends State<Pannier> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.pannier.products.isNotEmpty ||
                      widget.pannier.products != []
                  ? AnimatedList(
                      shrinkWrap: true,
                      key: _listKey,
                      initialItemCount: widget.pannier.products.length,
                      itemBuilder: (context, index, animator) {
                        Product product =
                            widget.pannier.products[index]["product"];
                        return ProductItem(
                          increment: () {
                            setState(() {
                              widget.pannier.products[widget.pannier.products
                                      .indexOf(widget.pannier.searchProduct(product))]
                                  ["quantity"] = widget.pannier.products[
                                          widget.pannier.products.indexOf(
                                              widget.pannier.searchProduct(product))]
                                      ["quantity"] +
                                  1;
                              double newPrice = widget.pannier.calculatePrice();
                              widget.pannier.setPrice = newPrice;
                            });
                          },
                          deleteFunction: () {
                            int index = widget.pannier.products
                                .indexOf(widget.pannier.searchProduct(product));
                            widget.pannier.products.removeAt(index);
                            _listKey.currentState!.removeItem(
                                index, (context, animation) => Container());

                            setState(() {
                              widget.pannier.setPrice =
                                  widget.pannier.calculatePrice();
                            });
                          },
                          decrement: () {
                            if (widget.pannier.products[widget.pannier.products
                                    .indexOf(widget.pannier
                                        .searchProduct(product))]["quantity"] >
                                1) {
                              setState(() {
                                widget.pannier.products[widget.pannier.products
                                        .indexOf(widget.pannier.searchProduct(product))]
                                    ["quantity"] = widget.pannier.products[
                                            widget.pannier.products.indexOf(
                                                widget.pannier.searchProduct(product))]
                                        ["quantity"] -
                                    1;
                                double newPrice =
                                    widget.pannier.calculatePrice();
                                widget.pannier.setPrice = newPrice;
                              });
                            }
                          },
                          item: product,
                          animation: animator,
                          listKey: _listKey,
                          pannier: widget.pannier,
                        );
                      },
                    )
                  : Center(
                      child: Row(
                        children: [
                          Text("votre pannier est vide , "),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CustomPageView(
                                          allCategories: widget.allCategories,
                                          allProducts: widget.allProductList,
                                          pannier: widget.pannier,
                                          selectedIndex: 0,
                                          sousCategoriesList:
                                              widget.sousCategoriesList,
                                          user: widget.user,
                                        )),
                              );
                            },
                            child: Text("voir les produit d'ici"),
                          )
                        ],
                      ),
                    ),
              Container(
                height: MediaQuery.of(context).size.height * .11,
                color: Colors.red,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: Text(
                            "Hello ${widget.user.username}",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .3,
                        ),
                        Column(
                          children: [
                            Text("Price"),
                            Text(
                              "${widget.pannier.price}",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            if (widget.pannier.products.isNotEmpty ||
                                widget.pannier.products != []) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return CheckOrder(
                                  allCategories: widget.allCategories,
                                  sousCategoriesList: widget.sousCategoriesList,
                                  allProducts: widget.allProductList,
                                  commande: widget.pannier,
                                  user: widget.user,
                                );
                              }));
                            }
                          },
                          child: Text("Commander"),
                        ),
                        TextButton(
                          onPressed: () {
                            if (widget.pannier.products.isNotEmpty ||
                                widget.pannier.products != []) {
                              for (var i = 0;
                                  i <= widget.pannier.products.length - 1;
                                  i++) {
                                _listKey.currentState!.removeItem(0,
                                    (BuildContext context,
                                        Animation<double> animation) {
                                  return Container();
                                });
                              }
                              widget.pannier.products.clear();
                              double newPrice = widget.pannier.calculatePrice();
                              setState(() {
                                widget.pannier.setPrice = newPrice;
                              });
                            }
                          },
                          child: Text("annuler"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
