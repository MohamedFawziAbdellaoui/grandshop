import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grandshop/models/sous_categories.dart';
import 'package:grandshop/ui/pannier.dart';
import 'package:grandshop/ui/widgets/custom_page_view.dart';

import '../models/categories.dart';
import '../models/commande.dart';
import '../models/produits.dart';
import '../models/user.dart';

class Favorites extends StatefulWidget {
  Order pannier;
  User user;
  List<Category> allCategories;
  List<SousCategories> allSousCategroies;
  List<Product> allProducts;
  Favorites({
    Key? key,
    required this.allCategories,
    required this.allProducts,
    required this.allSousCategroies,
    required this.user,
    required this.pannier,
  }) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  GlobalKey<AnimatedListState> favListKey = GlobalKey<AnimatedListState>();
  @override
  Widget build(BuildContext context) {
    return widget.user.fav!.isEmpty
        ? Center(
            child: Text("You don't have any favorite products yet"),
          )
        : AnimatedList(
            key: favListKey,
            initialItemCount: widget.user.fav!.length,
            itemBuilder: (context, index, animation) {
              Product item = widget.user.fav![index];
              return ListTile(
                leading: Container(
                  child: item.imgPath!.startsWith("images")
                      ? Image.asset(item.imgPath!)
                      : Image.file(File(item.imgPath!)),
                ),
                title: Text(item.name!),
                subtitle: TextButton(
                  onPressed: () {
                    setState(() {
                      widget.pannier.products.add({
                        "product": item,
                        "quantity": 1,
                      });
                      double newPrice = widget.pannier.calculatePrice();
                      widget.pannier.setPrice = newPrice;
                    });
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return CustomPageView(
                          allCategories: widget.allCategories,
                          sousCategoriesList: widget.allSousCategroies,
                          selectedIndex: 3,
                          allProducts: widget.allProducts,
                          pannier: widget.pannier,
                          user: widget.user);
                    }));
                  },
                  child: Text("add to cart"),
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    widget.user.fav!.remove(item);
                    favListKey.currentState!
                        .removeItem(index, (context, animation) => Container());
                  },
                ),
              );
            },
          );
  }
}
