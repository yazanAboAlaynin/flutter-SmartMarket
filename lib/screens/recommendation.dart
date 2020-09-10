import 'package:flutter/material.dart';
import 'package:flutter_smartmarket/models/product.dart';
import 'package:flutter_smartmarket/services/api.dart';
import 'package:flutter_smartmarket/shared/loading.dart';

import 'cart/cart_view.dart';
import 'display/products_card.dart';
import 'home/home.dart';

class Recommendations extends StatefulWidget {
  @override
  _RecommendationsState createState() => _RecommendationsState();
}

class _RecommendationsState extends State<Recommendations> {
  bool loading = true;
  List<Product> products = [];
  Future<List<Product>> getRec() async {
    List<Product> l = await Api().recommendation();

    setState(() {
      products = l;
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getRec();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              elevation: 0.1,
              title: Text(
                'Recommendations',
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
              backgroundColor: Colors.blue[200],
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push<Object>(
                        context,
                        new MaterialPageRoute<dynamic>(
                            builder: (context) => CartView()));
                  },
                )
              ],
            ),
            body: Container(
              padding: EdgeInsets.only(right: 15.0, left: 22),
              width: MediaQuery.of(context).size.width - 30.0,
              height: MediaQuery.of(context).size.height,
              child: MyProducts(
                productsList: products,
                press: true,
              ),
            ),
          );
  }
}
