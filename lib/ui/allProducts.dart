import 'package:flutter/material.dart';
import 'package:grandshop/models/categories.dart';
import 'package:grandshop/models/sous_categories.dart';
import 'package:grandshop/ui/productdetail.dart';
import 'package:grandshop/ui/widgets/custom_page_view.dart';
import '../models/commande.dart';
import '../models/produits.dart';
import '../models/user.dart';

class AllProducts extends StatefulWidget {
  static String id = ' AllProducts';
  User user;
  Order pannier;
  List<Product> sousProducts;
  List<SousCategories> sousCategoriesList;
  List<Product> allProducts;
  List<Category> allCategories;
  AllProducts(
      {Key? key,
      required this.sousProducts,
      required this.pannier,
      required this.allProducts,
      required this.allCategories,
      required this.sousCategoriesList,
      required this.user})
      : super(key: key);
  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  List<Product> favList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    favList = widget.user.fav!;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
            ),
          ],
          backgroundColor: Colors.red,
        ),
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
                icon: new Icon(Icons.home),
                label: "home",
                backgroundColor: Colors.red),
            BottomNavigationBarItem(
                icon: new Icon(Icons.category), label: "categories"),
            BottomNavigationBarItem(
                icon: new Icon(Icons.favorite), label: "favorites"),
            BottomNavigationBarItem(
                icon: new Icon(Icons.shopping_bag), label: "pannier"),
            BottomNavigationBarItem(
                icon: new Icon(Icons.person), label: "profil"),
          ],
          onTap: (int index) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return CustomPageView(
                  allCategories: widget.allCategories,
                  sousCategoriesList: widget.sousCategoriesList,
                  selectedIndex: index,
                  pannier: widget.pannier,
                  allProducts: widget.allProducts,
                  user: widget.user);
            }));
          },
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 30, top: 40),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 60,
              crossAxisSpacing: 6,
            ),
            shrinkWrap: true,
            itemCount: widget.sousProducts.length,
            itemBuilder: (context, index) {
              Product item = widget.sousProducts[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetail(
                          allCategories: widget.allCategories,
                          allProducts: widget.allProducts,
                          sousCategoriesList: widget.sousCategoriesList,
                          user: widget.user,
                          detailedProduct: item,
                          pannier: widget.pannier),
                    ),
                  );
                },
                child: Stack(
                  children: [
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
                            height: MediaQuery.of(context).size.height * .15,
                            width: MediaQuery.of(context).size.width * .4,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(item.imgPath!),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Text(
                            item.name!,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "${item.price} \$",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (!widget.user.fav!.contains(item)) {
                          setState(() {
                            favList.add(item);
                            widget.user.fav = favList;
                          });
                          print(widget.user.fav);
                        } else {
                          setState(() {
                            favList.remove(item);
                            widget.user.fav = favList;
                          });
                        }
                        print(widget.user.fav);
                      },
                      icon: favList.contains(item)
                          ? Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          : Icon(
                              Icons.favorite,
                              color: Colors.grey,
                            ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
