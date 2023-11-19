import 'package:flutter/material.dart';
import '../../models/commande.dart';
import '../../models/produits.dart';

class ProductCount extends StatefulWidget {
  final Color textColor;
  Product product;
  final double height;
  Order userOrder;

  VoidCallback incrementFunction;
  VoidCallback decrementFunction;
  int quantity;
  ProductCount({
    required this.quantity,
    required this.decrementFunction,
    required this.incrementFunction,
    required this.userOrder,
    required this.textColor,
    required this.product,
    required this.height,
    Key? key,
  }) : super(key: key);

  @override
  State<ProductCount> createState() => _ProductCountState();
}

class _ProductCountState extends State<ProductCount> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: widget.height * .04,
          width: widget.height * .05,
          decoration: const BoxDecoration(
            color: Colors.transparent,
            border: Border(
              top: BorderSide(color: Color.fromARGB(255, 222, 225, 220)),
              bottom: BorderSide(color: Color.fromARGB(255, 222, 225, 220)),
              left: BorderSide(color: Color.fromARGB(255, 222, 225, 220)),
              right: BorderSide(color: Color.fromARGB(255, 222, 225, 220)),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Center(
            child: IconButton(
                icon: const Icon(Icons.remove),
                iconSize: widget.height * 0.03,
                color: const Color.fromARGB(255, 222, 225, 220),
                onPressed: () {
                  widget.decrementFunction();
                }),
          ),
        ),
        SizedBox(
          width: widget.height * 0.02,
        ),
        Text(
          "${widget.quantity}",
          style: TextStyle(
            color: widget.textColor,
            fontSize: widget.height * 0.025,
          ),
        ),
        SizedBox(
          width: widget.height * 0.02,
        ),
        Container(
          height: widget.height * .04,
          width: widget.height * .05,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 222, 225, 220),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: IconButton(
            icon: const Icon(Icons.add),
            iconSize: widget.height * 0.03,
            color: Colors.white,
            onPressed: () {
              setState(() {
                widget.incrementFunction();
              });
            },
          ),
        ),
      ],
    );
  }
}
