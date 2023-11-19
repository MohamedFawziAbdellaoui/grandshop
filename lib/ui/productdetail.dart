import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:grandshop/models/user.dart';
import 'package:grandshop/ui/widgets/custom_page_view.dart';
import '../models/categories.dart';
import '../models/commande.dart';
import '../models/produits.dart';
import '../models/sous_categories.dart';

class ProductDetail extends StatefulWidget {
  final Product detailedProduct;
  List<SousCategories> sousCategoriesList;
  List<Product> allProducts;
  List<Category> allCategories;
  Order pannier;
  User user;
  ProductDetail({
    Key? key,
    required this.allCategories,
    required this.allProducts,
    required this.sousCategoriesList,
    required this.user,
    required this.detailedProduct,
    required this.pannier,
  }) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  late int selectedIndex;
  late int indexedColor;
  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
    indexedColor = 0;
  }

  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      title: Center(
          child: const Text('Ajouter au pannier',
              style: TextStyle(color: Colors.red))),
      content: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .3,
          child: Column(children: [
            SizedBox(height: MediaQuery.of(context).size.height * .03),
            Text(
              "${widget.detailedProduct.name} + :",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .02),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 30),
                  child: Text("available colors :"),
                ),
                Container(
                  padding: EdgeInsets.only(top: 13),
                  height: 40.0,
                  width: MediaQuery.of(context).size.width - 276,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.detailedProduct.colors!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            indexedColor = index;
                          });
                        },
                        child: Stack(
                          children: [
                            widget.detailedProduct.colors![index] ==
                                        Colors.white ||
                                    widget.detailedProduct.colors![index] ==
                                        Color(0xFFFFFFFF) ||
                                    widget.detailedProduct.colors![index] ==
                                        Color.fromRGBO(255, 255, 255, 1)
                                ? Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    width: 44,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black,
                                    ),
                                  )
                                : SizedBox(),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              width: 44,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: widget.detailedProduct.colors![index],
                              ),
                            ),
                            indexedColor == index
                                ? Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    width: 44,
                                    decoration: BoxDecoration(
                                      color: Colors.white24,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Icon(Icons.done),
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            /* widget.detailedProduct.sizes.isNotEmpty
                ? */
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text("available sizes :"),
                ),
                SizedBox(
                  width: 25,
                ),
                Container(
                  height: 45.0,
                  width: MediaQuery.of(context).size.width - 293,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.detailedProduct.sizes!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedSize = index;
                            });
                          },
                          child: Stack(
                            children: [
                              Center(
                                child: Container(
                                  width: 44,
                                  child: Center(
                                    child: Text(
                                        widget.detailedProduct.sizes![index]),
                                  ),
                                ),
                              ),
                              selectedSize == index
                                  ? Center(
                                      child: Container(
                                        width: 44,
                                        decoration: BoxDecoration(
                                          color: Colors.white24,
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
                            ],
                          ),
                        );
                      }),
                ),
              ],
            )
            /*  : SizedBox(), */
          ])),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            setState(() {
              widget.pannier.products.add({
                "product": widget.detailedProduct,
                "quantity": 1,
              });
              double newPrice = widget.pannier.calculatePrice();
              widget.pannier.setPrice = newPrice;
            });
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return CustomPageView(
                allCategories: widget.allCategories,
                sousCategoriesList: widget.sousCategoriesList,
                selectedIndex: 3,
                allProducts: widget.allProducts,
                pannier: widget.pannier,
                user: widget.user,
              );
            }));
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
          ),
          child: const Text('CONFIRMER'),
        ),
      ],
    );
  }

  int selectedSize = 0;
  List<Product> fav = [];
  bool isFav = false;
  bool hasGiveStar = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
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
                  selectedIndex: 3,
                  allProducts: widget.allProducts,
                  pannier: widget.pannier,
                  user: widget.user,
                );
              }));
            },
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .5,
                child: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * .5,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                            image: AssetImage(widget.detailedProduct.imgPath!),
                            fit: BoxFit.fill),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.02,
                      right: MediaQuery.of(context).size.width * .13,
                      child: Container(
                        child: IconButton(
                          onPressed: () {
                            if (!widget.user.fav!
                                .contains(widget.detailedProduct)) {
                              setState(() {
                                widget.user.fav!.add(widget.detailedProduct);
                              });
                            } else {
                              setState(() {
                                widget.user.fav!.remove(widget.detailedProduct);
                              });
                            }
                          },
                          icon:
                              widget.user.fav!.contains(widget.detailedProduct)
                                  ? Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 50,
                                    )
                                  : Icon(
                                      Icons.favorite,
                                      color: Colors.grey,
                                      size: 50,
                                    ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: MediaQuery.of(context).size.height * 0.08,
                      left: MediaQuery.of(context).size.width * .06,
                      child: Container(
                        color: indexedColor ==
                                widget.detailedProduct.colors!.length - 1
                            ? widget.detailedProduct.colors![indexedColor - 1]
                            : widget.detailedProduct.colors![indexedColor + 1],
                        child: widget.detailedProduct.inpromo!
                            ? Container(
                                child: Text(
                                  "${widget.detailedProduct.promopercent! * 100} %",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            : SizedBox(),
                      ),
                    ),
                  ],
                ),
              ),
              FittedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          widget.detailedProduct.name!,
                          style: TextStyle(fontSize: 45),
                        ),
                        RatingBar.builder(
                          initialRating: 3,
                          minRating: 0.1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text("available colors :"),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * .05,
                          width: MediaQuery.of(context).size.width - 135,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.detailedProduct.colors!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      indexedColor = index;
                                    });
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .11,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: widget
                                              .detailedProduct.colors![index],
                                        ),
                                      ),
                                      indexedColor == index
                                          ? Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 20),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .11,
                                              decoration: BoxDecoration(
                                                color: Colors.white24,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Center(
                                                child: Icon(Icons.done),
                                              ),
                                            )
                                          : SizedBox(),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                    widget.detailedProduct.sizes!.isNotEmpty
                        ? Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text("available sizes :"),
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .05,
                                width: MediaQuery.of(context).size.width - 153,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        widget.detailedProduct.sizes!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedSize = index;
                                          });
                                        },
                                        child: Stack(
                                          children: [
                                            Center(
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .11,
                                                child: Center(
                                                  child: Text(widget
                                                      .detailedProduct
                                                      .sizes![index]),
                                                ),
                                              ),
                                            ),
                                            selectedSize == index
                                                ? Center(
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .11,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white24,
                                                      ),
                                                    ),
                                                  )
                                                : SizedBox(),
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          )
                        : SizedBox(),
                  ],
                ),
              ),
              FittedBox(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "${widget.detailedProduct.price} \$ ",
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 30),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.grey, side: BorderSide()),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) =>
                                    _buildPopupDialog(context));
                          },
                          child: Text("ajouter au pannier"))
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
