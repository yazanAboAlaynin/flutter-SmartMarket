import 'package:flutter/material.dart';
import 'package:flutter_smartmarket/models/product.dart';
import 'package:flutter_smartmarket/screens/view_product/view_product.dart';
import 'package:flutter_smartmarket/services/api.dart';

class MyProducts extends StatelessWidget {
  List<Product> productsList;
  bool press;
  MyProducts({this.productsList, this.press});
  @override
  Widget build(BuildContext context) {
    List<Widget> products = new List<Widget>();
    for (int i = 0; i < productsList.length; i++) {
      Widget product = InkWell(
        onTap: () {
          if (press) {
            Navigator.push<Object>(
                context,
                new MaterialPageRoute<dynamic>(
                    builder: (context) =>
                        ProductDetails(id: productsList[i].id)));
          }
        },
        child: Padding(
          padding:
              EdgeInsets.only(top: 5.0, right: 5.0, left: 5.0, bottom: 5.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3.0,
                  blurRadius: 5.0,
                ),
              ],
              color: Colors.white,
            ),
            child: Column(
              children: [
                Hero(
                  tag: Text('${productsList[i].id}'),
                  child: Container(
                    height: 151.0,
                    width: 150.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          topRight: Radius.circular(12.0),
                          bottomLeft: Radius.circular(9.0),
                          bottomRight: Radius.circular(9.0)),
                      image: DecorationImage(
                        image: NetworkImage(
                            Api().getImagesUrl() + productsList[i].image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 6.6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      productsList[i].name,
                      style: TextStyle(fontSize: 14.0, color: Colors.black54),
                    ),
                    Text(
                      '${productsList[i].price}',
                      style: TextStyle(fontSize: 14.0, color: Colors.red[200]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
      products.add(product);
    }
    return GridView.count(
      crossAxisCount: 2,
      primary: false,
      crossAxisSpacing: 10.0,
      mainAxisSpacing: 15.0,
      childAspectRatio: 0.75,
      children: products,
    );
  }
}
