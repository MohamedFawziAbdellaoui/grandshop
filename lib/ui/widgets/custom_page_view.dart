import 'package:flutter/material.dart';
import '../../models/categories.dart';
import '../../models/commande.dart';
import '../../models/produits.dart';
import '../../models/sous_categories.dart';
import '../../models/user.dart';
import '../allCategories.dart';
import '../favorites.dart';
import '../home.dart';
import '../pannier.dart';
import '../profile.dart';

class CustomPageView extends StatefulWidget {
  User user;
  int selectedIndex;
  List<SousCategories> sousCategoriesList;
  List<Product> allProducts;
  List<Category> allCategories;
  Order pannier;

  static String id = "CustomùPageView";
  CustomPageView({
    required this.allProducts,
    required this.sousCategoriesList,
    required this.allCategories,
    required this.selectedIndex,
    required this.pannier,
    required this.user,
  });

  @override
  State<CustomPageView> createState() => _CustomPageViewState();
}

class _CustomPageViewState extends State<CustomPageView> {
  bool searching = false;
  String query = "";
  List<Product> foundedList = [];
  Widget searchBar() {
    return TextField(
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
      ),
      onChanged: (query) {
        setState(() {
          for (int i = 0; i < widget.allProducts.length; i++) {
            if (widget.allProducts[i].name!.contains(query)) {
              foundedList.add(widget.allProducts[i]);
            }
          }
        });
      },
    );
  }

  Widget _searchListView() {
    return ListView.builder(
        itemCount: foundedList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.asset(foundedList[index].imgPath!),
            title: Text(foundedList[index].name!),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    foundedList = [];
    query = "";
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      Home(
        pannier: widget.pannier,
        user: widget.user,
        allProducts: widget.allProducts,
        allCategories: widget.allCategories,
        sousCategoriesList: widget.sousCategoriesList,
      ),
      AllCategories(
        allCategories: widget.allCategories,
        allProducts: widget.allProducts,
        sousCategoriesList: widget.sousCategoriesList,
        user: widget.user,
        pannier: widget.pannier,
      ),
      Favorites(
        allCategories: widget.allCategories,
        allProducts: widget.allProducts,
        allSousCategroies: widget.sousCategoriesList,
        user: widget.user,
        pannier: widget.pannier,
      ),
      Pannier(
        allCategories: widget.allCategories,
        sousCategoriesList: widget.sousCategoriesList,
        allProductList: widget.allProducts,
        pannier: widget.pannier,
        user: widget.user,
      ),
      Profile(
        user: widget.user,
      ),
    ];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: searching ? searchBar() : SizedBox(),
              toolbarHeight: MediaQuery.of(context).size.height * .07,
              backgroundColor: Colors.red,
              actions: !searching
                  ? [
                      IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            setState(() {
                              searching = true;
                            });
                          })
                    ]
                  : [
                      IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              searching = false;
                              foundedList.clear();
                            });
                          })
                    ],
            ),
            body: searching
                ? _searchListView()
                : widgets.elementAt(widget.selectedIndex),
            bottomNavigationBar: BottomNavigationBar(
              showSelectedLabels: true,
              showUnselectedLabels: true,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: new Icon(Icons.home),
                  label: "home",
                  backgroundColor: Colors.red,
                ),
                BottomNavigationBarItem(
                  icon: new Icon(Icons.category),
                  label: "categories",
                  backgroundColor: Colors.red,
                ),
                BottomNavigationBarItem(
                  icon: new Icon(Icons.favorite),
                  label: "favorites",
                  backgroundColor: Colors.red,
                ),
                BottomNavigationBarItem(
                  icon: new Icon(Icons.shopping_bag),
                  label: "pannier",
                  backgroundColor: Colors.red,
                ),
                BottomNavigationBarItem(
                  icon: new Icon(Icons.person),
                  label: "profil",
                  backgroundColor: Colors.red,
                ),
              ],
              currentIndex: widget.selectedIndex,
              onTap: (int index) {
                setState(
                  () {
                    widget.selectedIndex = index;
                  },
                );
              },
            )),
      ),
    );
  }
}
