import 'package:flutter/material.dart';
import 'package:grandshop/models/commande.dart';
import 'package:grandshop/ui/allCategories.dart';
import 'package:grandshop/ui/allProducts.dart';
import 'package:grandshop/ui/allSousCategories.dart';
import 'package:grandshop/ui/productdetail.dart';
import '../models/categories.dart';
import '../models/produits.dart';
import '../models/sous_categories.dart';
import '../models/user.dart';

class Home extends StatefulWidget {
  static String id = 'Home';
  Order pannier;
  User user;
  List<SousCategories> sousCategoriesList;
  List<Product> allProducts;
  List<Category> allCategories;
  Home({
    Key? key,
    required this.allCategories,
    required this.allProducts,
    required this.sousCategoriesList,
    required this.pannier,
    required this.user,
  }) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selected = 0;
  int selectedSous = 0;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.only(left: 14, right: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Categories",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AllCategories.id);
                },
                child: Text(
                  "see All",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 250,
          width: double.infinity,
          child: SizedBox(
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(10),
              shrinkWrap: true,
              itemCount: widget.allCategories.length,
              itemBuilder: (context, index) {
                Category item = widget.allCategories[index];
                return GestureDetector(
                  onTap: () {},
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(3),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selected = index;
                                  });
                                },
                                child: Container(
                                  height: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    color: selected == index
                                        ? Colors.grey
                                        : Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 157,
                                        width: 157,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(item.imgPath!),
                                              fit: BoxFit.fill),
                                        ),
                                      ),
                                      FittedBox(
                                        child: Text(
                                          item.name!,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 25,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.only(left: 14, right: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Sous-Categorie",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              InkWell(
                onTap: () {
                  List<SousCategories> sousCategories = List.from(
                      widget.sousCategoriesList.where((element) =>
                          element.categoryId ==
                          widget.allCategories[selected].id));
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AllSousCategorie(
                        sousCategoryList: sousCategories,
                        allCategories: widget.allCategories,
                        allProducts: widget.allProducts,
                        user: widget.user,
                        pannier: widget.pannier);
                  }));
                },
                child: Text(
                  "see All",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 250,
          width: double.infinity,
          child: SizedBox(
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(10),
              shrinkWrap: true,
              itemCount: widget.sousCategoriesList
                  .where((element) =>
                      element.categoryId == widget.allCategories[selected].id)
                  .length,
              itemBuilder: (context, index) {
                List<SousCategories> newSousCategoriesList = List.from(
                    widget.sousCategoriesList.where((element) =>
                        element.categoryId ==
                        widget.allCategories[selected].id));
                SousCategories item = newSousCategoriesList[index];
                return GestureDetector(
                  onTap: () {},
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(3),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedSous =
                                        widget.sousCategoriesList.indexOf(item);
                                  });
                                },
                                child: Container(
                                  height: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    color: selectedSous == index
                                        ? Colors.grey
                                        : Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 157,
                                        width: 157,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(item.imgPath!),
                                              fit: BoxFit.fill),
                                        ),
                                      ),
                                      FittedBox(
                                        child: Text(
                                          item.name!,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 25,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.only(left: 14, right: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Produits",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return AllProducts(
                          sousProducts: [],
                          allCategories: widget.allCategories,
                          sousCategoriesList: widget.sousCategoriesList,
                          pannier: widget.pannier,
                          allProducts: List.from(
                            widget.allProducts.where((element) =>
                                element.sousCategoryId ==
                                widget.sousCategoriesList[selectedSous].id),
                          ),
                          user: widget.user,
                        );
                      },
                    ),
                  );
                },
                child: Text(
                  "see All",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 250,
          width: double.infinity,
          child: SizedBox(
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(10),
              shrinkWrap: true,
              itemCount: widget.allProducts
                  .where((element) =>
                      element.sousCategoryId ==
                      widget.sousCategoriesList[selectedSous].id)
                  .length,
              itemBuilder: (context, index) {
                List<Product> newProductList = List.from(
                  widget.allProducts.where((element) =>
                      element.sousCategoryId ==
                      widget.sousCategoriesList[selectedSous].id),
                );
                Product item = newProductList[index];
                return Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(3),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetail(
                                  allCategories: widget.allCategories,
                                  allProducts: widget.allProducts,
                                  sousCategoriesList: widget.sousCategoriesList,
                                  detailedProduct: item,
                                  user: widget.user,
                                  pannier: widget.pannier,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 200,
                            width: 200,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 157,
                                  width: 157,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(item.imgPath!),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                                Text(
                                  item.name!,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
