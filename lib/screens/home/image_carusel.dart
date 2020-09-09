import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class ImageCarusel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.0,
      child: Carousel(
        boxFit: BoxFit.cover,
        images: <AssetImage>[
          AssetImage('images/welcom.png'),
          AssetImage('images/welcomee.jpg'),
          AssetImage('images/welcomeee.jpg'),
        ],
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(
          milliseconds: 1000,
        ),
        dotSize: 5.0,
        indicatorBgPadding: 5.0,
        dotBgColor: Colors.transparent,
      ),
    );
    ;
  }
}
