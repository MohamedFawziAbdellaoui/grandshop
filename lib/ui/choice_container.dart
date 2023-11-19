import 'package:flutter/material.dart';

class ChoiceContainer extends StatefulWidget {
  ChoiceContainer({
    Key? key,
    required this.onTap,
    required this.text,
    required this.screenHeight,
    required this.screenWidth,
    this.img = "",
    this.enableLight = true,
  }) : super(key: key);
  bool enableLight;
  String img;
  final VoidCallback onTap;
  final String text;
  final double screenHeight;
  final double screenWidth;

  @override
  State<ChoiceContainer> createState() => _ChoiceContainerState();
}

class _ChoiceContainerState extends State<ChoiceContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(

        height: widget.screenHeight * .2,
        width: widget.screenHeight * .2,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(image: DecorationImage(image: AssetImage(widget.img))),
              /* foregroundImage: AssetImage(widget.img),
              radius: widget.screenWidth * .15,
              backgroundColor: Colors.white, */
            ),
            Text(
              widget.text,
              style: TextStyle(
                color: Colors.black,
                fontSize: widget.screenWidth * 0.04,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}








/* class ChoiceContainer extends StatefulWidget {
  ChoiceContainer({
    Key? key,
    required this.onTap,
    required this.text,
    required this.dark,
    required this.screenHeight,
    required this.screenWidth,
    this.img = "",
    this.fontweight = FontWeight.normal,
    /* required this.fontsize,
    required this.fontfamily, */
  }) : super(key: key);
  String img;
  FontWeight fontweight;
/* 
  final double fontsize;
  final String fontfamily; */
  final VoidCallback onTap;
  final String text;
  bool dark;
  final double screenHeight;
  final double screenWidth;

  @override
  State<ChoiceContainer> createState() => _ChoiceContainerState();
}

class _ChoiceContainerState extends State<ChoiceContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: widget.screenHeight,
        width: widget.screenWidth,
        decoration: BoxDecoration(
          color: widget.dark
              ? const Color(0xFF130E58)
              : const Color.fromARGB(131, 202, 233, 248),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: widget.screenHeight * .15,
              width: widget.screenWidth * .15,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(widget.img), fit: BoxFit.fill),
              ),
            ),
            Text(
              widget.text,
              style: TextStyle(
                color: widget.dark ? Colors.white : Colors.black,
                /* fontSize: widget.fontsize,
                fontFamily: widget.fontfamily, */
                fontWeight: widget.fontweight,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
 */




