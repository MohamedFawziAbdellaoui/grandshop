import 'package:flutter/material.dart';
import 'package:grandshop/ui/widgets/product_count.dart';

import '../../models/commande.dart';
import '../../models/produits.dart';

class ProductItem extends StatefulWidget {
  Product item;
  Animation<double> animation;
  GlobalKey<AnimatedListState> listKey;
  Order pannier;
  VoidCallback increment;
  VoidCallback deleteFunction;
  VoidCallback decrement;
  ProductItem(
      {Key? key,
      required this.deleteFunction,
      required this.item,
      required this.decrement,
      required this.increment,
      required this.animation,
      required this.listKey,
      required this.pannier})
      : super(key: key);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: widget.animation,
      child: ListTile(
        leading: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
              image: AssetImage(widget.item.imgPath!),
              fit: BoxFit.fill,
            ),
          ),
        ),
        subtitle: Text("${widget.item.price} \$"),
        trailing: Container(
          width: MediaQuery.of(context).size.width * .08,
          child: Center(
            child: IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                widget.deleteFunction();
              },
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(widget.item.name!),
            ProductCount(
              height: 500,
              product: widget.item,
              quantity: widget.pannier.products[widget.pannier.products
                      .indexOf(widget.pannier.searchProduct(widget.item))]
                  ["quantity"],
              decrementFunction: () {
                widget.decrement();
              },
              incrementFunction: () {
                widget.increment();
              },
              userOrder: widget.pannier,
              textColor: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
