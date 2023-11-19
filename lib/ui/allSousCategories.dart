import 'package:flutter/material.dart';
import 'package:grandshop/models/categories.dart';
import 'package:grandshop/ui/allProducts.dart';
import '../models/commande.dart';
import '../models/produits.dart';
import '../models/sous_categories.dart';
import '../models/user.dart';

class AllSousCategorie extends StatefulWidget {
  static String id = 'AllSousCategorie';
  List<SousCategories> sousCategoryList;
  List<Product> allProducts;
  List<Category> allCategories;
  User user;
  Order pannier;
  AllSousCategorie(
      {required this.allProducts,
      required this.allCategories,
      required this.sousCategoryList,
      required this.user,
      required this.pannier});
  @override
  State<AllSousCategorie> createState() => _AllSousCategorieState();
}

class _AllSousCategorieState extends State<AllSousCategorie> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Padding(
            padding: EdgeInsets.only(left: 30, top: 40),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              shrinkWrap: true,
              itemCount: widget.sousCategoryList.length,
              itemBuilder: (context, index) {
                SousCategories item = widget.sousCategoryList[index];
                return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return AllProducts(
                            allCategories: widget.allCategories,
                            allProducts: widget.allProducts,
                            sousCategoriesList: widget.sousCategoryList,
                            pannier: widget.pannier,
                            sousProducts: List.from(widget.allProducts.where(
                              (element) =>
                                  element.sousCategoryId ==
                                  widget.sousCategoryList[index].id,
                            )),
                            user: widget.user,
                          );
                        },
                      ));
                    },
                    child: Stack(children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * .17,
                              width: MediaQuery.of(context).size.width * .4,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(item.imgPath!),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            FittedBox(
                              child: Text(
                                item.name!,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]));
              },
            ),

            /* ListView(children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "SousCategories ",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width * .45,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.category.sousCategoriesList.length,
                    itemBuilder: (context, index) {
                      SousCategories item =
                          widget.category.sousCategoriesList[index];
                      return Container(
                        height: MediaQuery.of(context).size.height * .2,
                        width: MediaQuery.of(context).size.width * .4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: MediaQuery.of(context).size.height * .2,
                                width: MediaQuery.of(context).size.width * .5,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .14,
                                      width: MediaQuery.of(context).size.width *
                                          .5,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(item.imgPath),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                    Text(
                                      item.name,
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
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width * .4,
                color: Color.fromARGB(255, 225, 223, 223),
                child: ListView.builder(
                  itemCount: widget.category.sousCategoriesList.length,
                  itemBuilder: (context, index) {
                    SousCategories item =
                        widget.category.sousCategoriesList[index];
                    return Container(
                      height: MediaQuery.of(context).size.height * .08,
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: 1,
                        child: Text(
                          item.name,
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 23,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ]), */
          ),
        ));
  }
}
