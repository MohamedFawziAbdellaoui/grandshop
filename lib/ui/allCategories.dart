import 'package:flutter/material.dart';
import 'package:grandshop/models/produits.dart';
import 'package:grandshop/ui/allSousCategories.dart';
import '../models/categories.dart';
import '../models/commande.dart';
import '../models/sous_categories.dart';
import '../models/user.dart';

class AllCategories extends StatefulWidget {
  static String id = ' AllCategories';
  List<SousCategories> sousCategoriesList;
  List<Product> allProducts;
  List<Category> allCategories;
  User user;
  Order pannier;
  AllCategories({
    Key? key,
    required this.sousCategoriesList,
    required this.allProducts,
    required this.user,
    required this.pannier,
    required this.allCategories,
  }) : super(key: key);

  @override
  State<AllCategories> createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories> {
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
              mainAxisSpacing: 40,
              crossAxisSpacing: 4,
            ),
            shrinkWrap: true,
            itemCount: widget.allCategories.length,
            itemBuilder: (context, index) {
              Category item = widget.allCategories[index];
              return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return AllSousCategorie(
                        allCategories: widget.allCategories,
                        allProducts: widget.allProducts,
                        sousCategoryList: List.from(widget.sousCategoriesList
                            .where((element) =>
                                element.categoryId ==
                                widget.allCategories[index].id)),
                        user: widget.user,
                        pannier: widget.pannier,
                      );
                    }));
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
        ),
      ),
    );
  }
}
